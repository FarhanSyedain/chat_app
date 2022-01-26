import 'package:chat_app/database/chats.dart';
import 'package:chat_app/models/chat/chat.dart';
import 'package:chat_app/models/extras/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Chats extends ChangeNotifier {
  final List<Chat> _chats = [];

  //Return chats sorted by datetime of last message
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
    } catch (e) {}
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
    _chats.forEach((element) async {
      await element.populate(element.id);
    });
  }
  void clearInMemoryData() async {
    _chats.forEach((element) { 
      element.clearInMemoryData();
    });
    _chats.clear();
  }
}
