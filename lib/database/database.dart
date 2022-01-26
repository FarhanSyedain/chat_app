import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Future<void> deleteDataBases() async {
    final dbPath = await getDatabasesPath();
    final chatPath = join(dbPath, 'chats.db');
    final chatsPath = join(dbPath, 'chat.db');
    await _deleteDatabase(chatPath);
    await _deleteDatabase(chatsPath);
    print('Hi how are you');
  }

  static Future<void> _deleteDatabase(String path) =>
      databaseFactory.deleteDatabase(path);
}
