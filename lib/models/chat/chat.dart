import 'dart:async';
import 'dart:io';
import 'package:chat_app/database/chat.dart';
import 'package:chat_app/database/chats.dart';
import 'package:chat_app/utilities/images.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chats extends ChangeNotifier {
  //!Currently does not handle deleted messages and read reciets

  final List<Chat> _chats = [];

  List<Chat> get chats {
    final _chatCopy = _chats; // Lists are pointers my bad
    _chatCopy.sort((a, b) {
      final DateTime valA = a.messages.length > 0
          ? a.messages.first.date as DateTime
          : a.creationTime as DateTime;
      final DateTime valB = b.messages.length > 0
          ? b.messages.first.date as DateTime
          : b.creationTime as DateTime;
      return -valA.toString().compareTo(valB.toString());
    });
    return _chatCopy;
  }

  void get getChats {
    final ref = FirebaseFirestore.instance;
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final stream = ref
        .collection('chats/$userId/recieved')
        .orderBy('date')
        .limit(5)
        .snapshots();

    stream.listen((message) {
      handleMessage(message);
    });
  }

  void handleMessage(QuerySnapshot<Map<String, dynamic>> messagesSnapShot) {
    final messages = messagesSnapShot.docs;
    for (var message in messages) {
      if (!message.data().keys.contains('data')) continue;

      _addMessage(message);
    }
  }

  void _addMessage(QueryDocumentSnapshot<Map<String, dynamic>> message) {
    final senderID = message.data()['senderID'];
    final _chat = _chats.firstWhere(
      (element) => element.id == senderID,
      orElse: () => Chat.lazy(
        senderID,
        addtoChats,
      ), // This will not be rendered till meta data is fetched
    );
    _chat.add(message);
    message.reference.delete();
  }

  void addtoChats(chat) {
    if (_chats.where((element) => element.id == chat.id).isEmpty) {
      _chats.add(chat);
      ChatsDataBase.instance.create(chat);
      notifyListeners();
    }
  }

  Future<void> fetchChats() async {
    final chatsRead = await ChatsDataBase.instance.readAllChats();
    ChatsDataBase.instance.readAllChats();
    _chats.addAll(chatsRead);
    await populateChildren();
    return;
  }

  Future<void> populateChildren() async {
    for (var c in _chats) {
      await c.populate(c.id);
    }
  }
}

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

  void add(QueryDocumentSnapshot<Map<String, dynamic>> message) {
    final msg = _messages.firstWhere(
      (element) => element.id == message.id,
      orElse: () => Message.empty(),
    );

    if (msg.id != null) return;
    final _message = Message(
      message.id,
      message.data()['data'],
      Sender.other,
      DateTime.parse(message.data()['date']),
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

  void _sendMessage(Message message, String receiverId) {
    ChatDataBase.instance.create(message, id);
    FirebaseFirestore.instance.collection('chats/$receiverId/recieved').add({
      'data': message.data,
      'date': message.date.toString(),
      'senderID': FirebaseAuth.instance.currentUser!.uid,
    }).then((value) {
      //Later on handle delivered markers
    });
  }

  Chat.fromdata(this.id, this.name, this.email, this.profilePicture, this.bio,
      this.creationTime);

  static Chat fromJson(json) {
    final dp = json[ChatsFields.profilePicture] == null
        ? null
        : File.fromRawPath(
            json[json.decode(ChatsFields.profilePicture)],
          );

    return Chat.fromdata(
      json[ChatsFields.mid].toString(),
      json[ChatsFields.name],
      json[ChatsFields.email],
      dp,
      json[ChatsFields.bio],
      DateTime.parse(json[ChatsFields.creationTime]),
    );
  }

  Chat.lazy(this.id, callback) {
    FirebaseFirestore.instance
        .collection('users')
        .doc('$id')
        .get()
        .then((value) {
      this.email = value.data()!['email'];
      this.bio = value.data()!['bio'];
      this.name = value.data()!['firstName'];
      this.creationTime = DateTime.now();
      callback(this);
    });
  }

  Map<String, Object?> toJson() {
    final chat = this;
    return {
      ChatsFields.mid: chat.id,
      ChatsFields.email: chat.email,
      ChatsFields.name: chat.name!,
      ChatsFields.bio: chat.bio,
      ChatsFields.creationTime: creationTime.toString(),
      ChatsFields.profilePicture: chat.profilePicture != null
          ? iamgeToString(chat.profilePicture!)
          : null,
    };
  }

  List<Message> get messages => _messages.reversed.toList();
  String get title => name ?? 'No name';
  String? get subtitle => _messages.isNotEmpty ? _messages.last.data : null;
  bool get read => true; //implement later
  int get count => 0; //implement later
  String? get time => _messages.isNotEmpty
      ? DateFormat('EEEEEE', 'en_US').format(_messages.last.date!)
      : null;
}

enum Sender { me, other }

class Message {
  final String? id;
  final String? data;
  final Sender? sender;
  final DateTime? date;

  Message(this.id, this.data, this.sender, this.date);

  Message.fromData({this.id, this.data, this.sender, this.date});

  Message.empty()
      : id = null,
        data = null,
        date = null,
        sender = null;

  Map<String, Object?> toJson(senderId) {
    final message = this;
    return {
      ChatFields.mid: senderId,
      ChatFields.data: message.data,
      ChatFields.date: message.date!.toIso8601String(),
      ChatFields.sender: message.sender == Sender.me ? 0 : 1,
    };
  }

  static Message fromJson(json) {
    return Message.fromData(
      id: json[ChatFields.id].toString(),
      data: json[ChatFields.data],
      date: DateTime.parse(json[ChatFields.date]),
      sender:
          int.parse(json[ChatFields.sender]) == 0 ? Sender.me : Sender.other,
    );
  }
}
