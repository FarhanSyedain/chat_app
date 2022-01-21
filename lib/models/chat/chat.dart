import 'dart:async';
import 'dart:io';
import 'package:chat_app/database/chat.dart';
import 'package:chat_app/database/chats.dart';
import 'package:chat_app/utilities/images.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum Sender { me, other }
enum DeleteType { local, everywhere }
enum MessageStatus { sending, sent, delivered, read, received }

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
        .limit(15)
        .snapshots();

    stream.listen((message) {
      handleMessage(message);
    });
  }

  void handleMessage(QuerySnapshot<Map<String, dynamic>> messagesSnapShot) {
    final messages = messagesSnapShot.docs;
    for (var message in messages) {
      if (message.data().keys.contains('deleteId')) {
        final senderId = message.data()['senderID'];
        final messageId = message.data()['deleteId'];
        _handleDeleteMessageEvent(senderId, messageId);
        message.reference.delete();
      } else if (message.data().keys.contains('readId')) {
        final _messageId = message.data()['readId'];
        final senderId = message.data()['senderID'];
        final _messageDate = message.data()['messageDate'];
        _handleReadMessageStatus(_messageId, senderId, _messageDate);
        message.reference.delete();
      } else if (message.data().keys.contains('deliveredId')) {
        final _messageId = message.data()['deliveredId'];
        final senderId = message.data()['senderID'];
        _handleDeliveredStatus(_messageId, senderId);
        message.reference.delete();
      } else {
        if (!message.data().keys.contains('data')) continue;
        _addMessage(message);
      }
    }
  }

  _handleDeliveredStatus(commonId, senderId) async {
    try {
      final targetedChat =
          _chats.firstWhere((element) => element.id == senderId);

      targetedChat.messages
          .firstWhere((element) => element.commonId == commonId)
          .setMessageStatus(MessageStatus.delivered, senderId);
    } catch (e) {}
  }

  _handleReadMessageStatus(commonId, senderId, String messageDate) async {
    try {
      final targetedChat =
          _chats.firstWhere((element) => element.id == senderId);

      targetedChat.setBulkReadStatus(senderId, commonId, messageDate);
    } catch (e) {
      print(e);
    }
  }

  void _handleDeleteMessageEvent(senderId, messageId) {
    try {
      final targetedChat =
          _chats.firstWhere((element) => element.id == senderId);

      targetedChat.deleteMessageInMemory(messageId);
      targetedChat.deleteMessageLocally(messageId);
    } catch (e) {}
  }

  void _addMessage(QueryDocumentSnapshot<Map<String, dynamic>> message) {
    final senderID = message.data()['senderID'];
    _messageDelivered(message.data()['commonID'], senderID);
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

  void _messageDelivered(commonId, String senderId) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection('chats/$senderId/recieved').add({
      'senderID': uid,
      'deliveredId': commonId,
      'date': DateTime.now(),
    }).then((value) {});
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

  void deleteMessageInMemory(String commonId) {
    _messages.removeWhere((element) => element.commonId == commonId);
    notifyListeners();
  }

  void setBulkReadStatus(
      String senderID, String messageID, String messageDate) {
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
    final _message = Message(
      message.id,
      message.data()['data'],
      Sender.other,
      DateTime.parse(message.data()['date']),
      message.data()['commonID'],
      MessageStatus.received,
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
      'commonID': message.commonId,
    }).then((value) {
      message.setMessageStatus(MessageStatus.sent, id);
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

  Future<void> deleteMessage(
      String id, String senderId, DeleteType deleteType, String? userId) async {
    deleteMessageInMemory(id);
    if (deleteType == DeleteType.everywhere) {
      await FirebaseFirestore.instance
          .collection('chats/$userId/recieved')
          .add({
        'date': DateTime.now(),
        'senderID': senderId,
        'deleteId': id,
      }).then((value) => deleteMessageLocally(id));
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

  void updateReadStatusBulkInMemory(DateTime dateTime) {
    for (var message in messages) {
      if (message.date!.isBefore(dateTime) ||
          message.date!.isAtSameMomentAs(dateTime)) {
        if (message.messageStatus == MessageStatus.read) break;
        message.setMessageStatusInMemory();
      }
    }
  }

  List<Message> get messages => _messages.reversed.toList();
  String get title => name ?? 'No name';
  String? get subtitle => _messages.isNotEmpty ? _messages.last.data : null;
  bool get read => count > 0 ? false : true;
  int get count {
    return messages
        .where((element) => element.messageStatus == MessageStatus.received)
        .length;
  }

  String? get time => _messages.isNotEmpty
      ? DateFormat('EEEEEE', 'en_US').format(_messages.last.date!)
      : null;
}

class Message with ChangeNotifier {
  final String? id;
  final String? data;
  final Sender? sender;
  final DateTime? date;
  final String? commonId;
  MessageStatus messageStatus = MessageStatus.sending;

  Message(
    this.id,
    this.data,
    this.sender,
    this.date,
    this.commonId,
    this.messageStatus,
  );

  Message.fromData({
    this.id,
    this.data,
    this.sender,
    this.date,
    this.commonId,
    required this.messageStatus,
  });

  Message.empty()
      : id = null,
        data = null,
        date = null,
        commonId = null,
        messageStatus = MessageStatus.sent,
        sender = null;

  Map<String, Object?> toJson(senderId) {
    final message = this;
    return {
      ChatFields.mid: senderId,
      ChatFields.commonId: commonId,
      ChatFields.data: message.data,
      ChatFields.date: message.date!.toIso8601String(),
      ChatFields.sender: message.sender == Sender.me ? 0 : 1,
      ChatFields.messageStatus:
          getIntForMessageStatus(message.messageStatus).toString(),
    };
  }

  static Message fromJson(json) {
    return Message.fromData(
        id: json[ChatFields.id].toString(),
        commonId: json[ChatFields.commonId],
        data: json[ChatFields.data],
        date: DateTime.parse(json[ChatFields.date]),
        sender:
            int.parse(json[ChatFields.sender]) == 0 ? Sender.me : Sender.other,
        messageStatus:
            getMessageStatusForInt(int.parse(json[ChatFields.messageStatus])));
  }

  void setMessageStatus(MessageStatus status, String senderId,
      {cacheOnly = false}) {
    this.messageStatus = status;
    if (cacheOnly) return;
    ChatDataBase.instance.updateReadStatus(this);
    notifyListeners();
  }

  void setMessageStatusInMemory() {
    ChatDataBase.instance.updateReadStatus(this);
  }

  void onMessageRead(String receiverId, String userId, DateTime messageDate,
      Chat parentProvider) {
    if (this.messageStatus == MessageStatus.read) {
      return;
    }
    parentProvider.updateReadStatusBulkInCache(messageDate);
    FirebaseFirestore.instance.collection('chats/$receiverId/recieved').add({
      'senderID': userId,
      'readId': commonId,
      'date': DateTime.now(),
      'messageDate': messageDate.toString(),
    }).then((value) {
      parentProvider.updateReadStatusBulkInMemory(messageDate);
    });
  }

  String getReadStatus() {
    return getIntForMessageStatus(this.messageStatus).toString();
  }
}

int getIntForMessageStatus(MessageStatus status) {
  switch (status) {
    case MessageStatus.sending:
      return 0;
    case MessageStatus.sent:
      return 1;
    case MessageStatus.delivered:
      return 2;
    case MessageStatus.read:
      return 3;
    case MessageStatus.received:
      return 4;
  }
}

MessageStatus getMessageStatusForInt(int number) {
  switch (number) {
    case 0:
      return MessageStatus.sending;
    case 1:
      return MessageStatus.sent;
    case 2:
      return MessageStatus.delivered;
    case 3:
      return MessageStatus.read;
    default:
      return MessageStatus.received;
  }
}
