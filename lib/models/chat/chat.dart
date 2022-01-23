import 'dart:async';
import 'dart:io';
import 'package:chat_app/database/chat.dart';
import 'package:chat_app/database/chats.dart';
import 'package:chat_app/models/chat/message.dart';
import 'package:chat_app/models/extras/enums.dart';
import 'package:chat_app/utilities/images.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chat extends ChangeNotifier {
  Chat({required this.id});
  final String id;
  final List<Message> _messages = [];
  String? name;
  File? profilePicture;
  String? bio;
  String? email;
  DateTime? creationTime;

  Future<void> populate(id) async {
    final m = await ChatDataBase.instance.readMessagesFor(id);
    _messages.addAll(m);
  }

  void deleteMessageInMemory(String commonId) {
    _messages.removeWhere((element) => element.commonId == commonId);
    notifyListeners();
  }

  void setBulkReadStatus(
    String senderID,
    String messageID,
    String messageDate,
  ) {
    DateTime dateTime = DateTime.parse(messageDate);
    for (var message in messages) {
      if (message.date!.isBefore(dateTime) ||
          message.date!.isAtSameMomentAs(dateTime)) {
        if (message.messageStatus == MessageStatus.read) break;
        message.setMessageStatus(MessageStatus.read, senderID);
      }
    }
  }

  void add(QueryDocumentSnapshot<Map<String, dynamic>> message) {
    final msg = _messages.firstWhere(
      (element) => element.id == message.id,
      orElse: () => Message.empty(),
    );

    if (msg.id != null) return;

    final data = message.data();
    final replyto = data['replyto'];

    final _message = Message(
      message.id,
      data['data'],
      Sender.other,
      DateTime.parse(data['date']),
      data['commonID'],
      MessageStatus.received,
      replyto,
    );

    ChatDataBase.instance.create(_message, id);


    _messages.add(_message);

    notifyListeners();
  }

  void send(Message message, String revieverId) {
    _messages.add(message);
    _sendMessage(message, revieverId);
    notifyListeners();
  }

  Chat.fromdata(this.id, this.name, this.email, this.profilePicture, this.bio,
      this.creationTime);

  static Chat fromJson(json) {
    final displayPicture = json[ChatsFields.profilePicture] == null
        ? null
        : File.fromRawPath(
            json[json.decode(ChatsFields.profilePicture)],
          );

    return Chat.fromdata(
      json[ChatsFields.mid].toString(),
      json[ChatsFields.name],
      json[ChatsFields.email],
      displayPicture,
      json[ChatsFields.bio],
      DateTime.parse(json[ChatsFields.creationTime]),
    );
  }

  Chat.lazy(this.id, callback) {
    final firebase = FirebaseFirestore.instance.collection('users').doc('$id');
    firebase.get().then((value) {
      final data = value.data()!;
      this.email = data['email'];
      this.bio = data['bio'];
      this.name = data['firstName'];
      final String? lastName = data['lastName'];
      this.name = name! + ' ' + (lastName ?? '');
      name = name?.trim();
      this.creationTime = DateTime.now();
      callback(this);
    });
  }

  Map<String, Object?> toJson() {
    return {
      ChatsFields.mid: id,
      ChatsFields.email: email,
      ChatsFields.name: name!,
      ChatsFields.bio: bio,
      ChatsFields.creationTime: creationTime.toString(),
      ChatsFields.profilePicture:
          profilePicture != null ? iamgeToString(profilePicture!) : null,
    };
  }

  Future<void> deleteMessage(
    String id,
    String senderId,
    DeleteType deleteType,
    String? userId,
  ) async {
    deleteMessageInMemory(id);

    if (deleteType == DeleteType.everywhere) {
      final firebase =
          FirebaseFirestore.instance.collection('chats/$userId/recieved');
      await firebase.add({
        'date': DateTime.now(),
        'senderID': senderId,
        'deleteId': id,
      }).then(
        (value) => deleteMessageLocally(id),
      );
    } else {
      deleteMessageLocally(id);
    }
  }

  void deleteMessageLocally(String id) async {
    await ChatDataBase.instance.delete(id);
  }

  void updateReadStatusBulkInCache(DateTime dateTime) {
    for (var message in messages) {
      if (message.date!.isBefore(dateTime) ||
          message.date!.isAtSameMomentAs(dateTime)) {
        if (message.messageStatus == MessageStatus.read) break;
        message.setMessageStatus(MessageStatus.read, id);
      }
    }
  }

  void _sendMessage(Message message, String receiverId) {
    ChatDataBase.instance.create(message, id);
    final firebase =
        FirebaseFirestore.instance.collection('chats/$receiverId/recieved');
    firebase.add({
      'data': message.data,
      'date': message.date.toString(),
      'senderID': FirebaseAuth.instance.currentUser!.uid,
      'commonID': message.commonId,
      'replyto': message.replyTo,
    }).then((value) {
      message.setMessageStatus(MessageStatus.sent, id);
    });
  }

  void updateReadStatusBulkInMemory(DateTime dateTime) {
    for (var message in messages) {
      if (message.date!.isBefore(dateTime) ||
          message.date!.isAtSameMomentAs(dateTime)) {
        if (message.messageStatus == MessageStatus.read) break;
        message.setMessageStatusInMemory();
      }
    }
  }

  //The messages of the chat
  List<Message> get messages => _messages.reversed.toList();
  //The name of the recipient
  String get title => name ?? 'No name';
  //Subtitle for the chatTile
  String? get subtitle => _messages.isNotEmpty ? _messages.last.data : null;
  //Weather all messages are read by user
  bool get read => count > 0 ? false : true;
  //Number of unread messages
  int get count =>
      messages.where((e) => e.messageStatus == MessageStatus.received).length;
  //The time of last message of this chat
  String? get time => _messages.isNotEmpty
      ? DateFormat('EEEEEE', 'en_US').format(_messages.last.date!)
      : DateFormat('EEEEEE', 'en_US').format(creationTime!);
}
