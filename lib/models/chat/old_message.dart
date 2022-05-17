import 'package:chat_app/database/old_chat.dart';
import 'package:chat_app/models/chat/old_chat.dart';
import 'package:chat_app/models/extras/old_enums.dart';
import 'package:chat_app/models/extras/old_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Message with ChangeNotifier {
  final String? id;
  final String? data;
  final Sender? sender;
  final DateTime? date;
  final String? commonId;
  final String? replyTo;
  MessageStatus messageStatus = MessageStatus.sending;

  Message(
    this.id,
    this.data,
    this.sender,
    this.date,
    this.commonId,
    this.messageStatus,
    this.replyTo,
  );

  Message.fromData({
    this.id,
    this.data,
    this.sender,
    this.date,
    this.commonId,
    required this.messageStatus,
    this.replyTo,
  });

  Message.empty()
      : id = null,
        data = null,
        date = null,
        commonId = null,
        messageStatus = MessageStatus.sent,
        replyTo = null,
        sender = null;

  Map<String, Object?> toJson(senderId) {
    final message = this;
    return {
      ChatFields.mid: senderId,
      ChatFields.commonId: commonId,
      ChatFields.data: message.data,
      ChatFields.date: message.date!.toIso8601String(),
      ChatFields.sender: message.sender == Sender.me ? 0 : 1,
      ChatFields.replyTo: message.replyTo,
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
        replyTo: json[ChatFields.replyTo],
        sender:
            int.parse(json[ChatFields.sender]) == 0 ? Sender.me : Sender.other,
        messageStatus:
            getMessageStatusForInt(int.parse(json[ChatFields.messageStatus])));
  }

  void setMessageStatus(MessageStatus status, String senderId,
      {cacheOnly = false}) {
    messageStatus = status;
    if (cacheOnly) return;
    ChatDataBase.instance.updateReadStatus(this);
    notifyListeners();
  }

  void setMessageStatusInMemory() {
    ChatDataBase.instance.updateReadStatus(this);
  }

  void onMessageRead(String receiverId, String userId, DateTime messageDate,
      Chat parentProvider) {
    if (messageStatus == MessageStatus.read) {
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
    return getIntForMessageStatus(messageStatus).toString();
  }

  MessageReply? replyToMessage(Chat provider) {
    if (replyTo == null || replyTo == '') {
      return null;
    }
    try {
      final providerValues = provider.messages
          .firstWhere((element) => element.commonId == replyTo);
      return MessageReply(
        data: providerValues.data!,
        sender: providerValues.sender!,
      );
    } catch (e) {
      return MessageReply(
        data: 'This message could\'nt be found',
        sender: Sender.me,
      );
    }
  }
}

class MessageReply {
  final String data;
  final Sender sender;

  MessageReply({
    required this.data,
    required this.sender,
  });
}
