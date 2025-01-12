import 'package:chat_app/database/old_chat.dart';
import 'package:chat_app/database/old_chats.dart';

class DatabaseHelper {
  static Future<void> deleteDataBases() async {
    await ChatDataBase.deleteDataBase();
    await ChatsDataBase.deleteDataBase();
  }
}
