import 'package:chat_app/database/chat.dart';
import 'package:chat_app/database/chats.dart';

class DatabaseHelper {
  static Future<void> deleteDataBases() async {
    await ChatDataBase.deleteDataBase();
    await ChatsDataBase.deleteDataBase();
  }
}
