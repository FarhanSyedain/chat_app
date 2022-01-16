import 'package:chat_app/models/chat/chat.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String tableNotes = 'chats';

class ChatsFields {
  static final List<String> values = [id, name, profilePicture, bio, email,creationTime];

  static final String id = '_id';
  static final String mid = 'id';
  static final String name = 'name';
  static final String profilePicture = 'profilePicture';
  static final String bio = 'bio';
  static final String email = 'email';
  static final String creationTime = 'creation';

}

class ChatsDataBase {
  static final ChatsDataBase instance = ChatsDataBase._init();

  static Database? _database;

  ChatsDataBase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('chats.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT';
    final textTypeNonNull = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE $tableNotes ( 
      ${ChatsFields.id} $idType, 
      ${ChatsFields.mid} $textTypeNonNull, 
      ${ChatsFields.name} $textTypeNonNull,
      ${ChatsFields.bio} $textType,
      ${ChatsFields.profilePicture} $textType,
      ${ChatsFields.email} $textTypeNonNull,
      ${ChatsFields.creationTime} $textTypeNonNull
    )
      ''');
  }

  Future<void> create(Chat chat) async {
    final db = await instance.database;
    await db.insert(tableNotes, chat.toJson());
  }

  Future<List<Chat>> readAllChats() async {
    final db = await instance.database;
    final result = await db.query(tableNotes);
    return result.map((json) => Chat.fromJson(json)).toList();
  }

  Future<int> update(Chat note) async {
    final db = await instance.database;

    return db.update(
      tableNotes,
      note.toJson(),
      where: '${ChatsFields.id} = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableNotes,
      where: '${ChatsFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
