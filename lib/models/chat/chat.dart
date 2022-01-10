import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chats extends ChangeNotifier {
  //!Currently does not handle deleted messages and read reciets

  final List<Chat> _chats = [];

  Chats() {
    Future.delayed(Duration(seconds: 2)).then((value) => getChats);
  }

  List<Chat> get chats => _chats;

  void get getChats {
    final ref = FirebaseFirestore.instance;
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final stream = ref.collection('chats/$userId/recieved').snapshots();

    stream.listen((message) {
      handleMessage(message);
    });
  }

  void handleMessage(QuerySnapshot<Map<String, dynamic>> messagesSnapShot) {
    final messages = messagesSnapShot.docs;
    for (var message in messages) {
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
      notifyListeners();
      print(_chats);
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

  void add(QueryDocumentSnapshot<Map<String, dynamic>> message) {
    final msg = _messages.firstWhere(
      (element) => element.id == message.id,
      orElse: () => Message.empty(),
    );

    if (msg.id != null) return;
    _messages.add(
      Message(
        message.id,
        message.data()['data'],
        Sender.other,
        DateTime.parse(
          message.data()['date'],
        ),
      ),
    );

    notifyListeners();
  }

  void send(Message message, String revieverId) {
    _messages.add(message);
    _sendMessage(message, revieverId);
    notifyListeners();
  }

  void _sendMessage(Message message, String receiverId) {
    FirebaseFirestore.instance.collection('chats/$receiverId/recieved').add({
      'data': message.data,
      'date': message.date.toString(),
      'senderID': FirebaseAuth.instance.currentUser!.uid,
    }).then((value) {
      //Later on handle delivered markers
    });
  }

  Chat.fromdata(this.id, this.name, this.email, this.profilePicture, this.bio);

  Chat.lazy(this.id, callback) {
    FirebaseFirestore.instance
        .collection('users')
        .doc('$id')
        .get()
        .then((value) {
      this.email = value.data()!['email'];
      this.bio = value.data()!['bio'];
      this.name = value.data()!['firstName'];
      callback(this);
    });
  }

  List<Message> get messages => _messages;
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
  Message.empty()
      : id = null,
        data = null,
        date = null,
        sender = null;

  Message.fromJson({this.id, this.data, this.sender, this.date});
}
