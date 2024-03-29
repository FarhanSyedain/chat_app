import 'package:chat_app/models/chat/old_message.dart';
import 'package:flutter/material.dart';

class InputBarProvider with ChangeNotifier {
  Message? message;

  replyToMessage(Message msg) {
    message = msg;
    notifyListeners();
  }

  resetReplyTo() {
    message = null;
    notifyListeners();
  }
}
