import 'package:chat_app/models/chat/chat.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String tableNotes = 'chat';

class ChatFields {
  static final List<String> values = [id, date, commonId, mid, data, sender];
  static final String id = '_id';
  static final String mid = 'id';
  static final String commonId = 'commonId';
  static final String date = 'data';
  static final String data = 'date';
  static final String sender = 'sender';
}

class ChatDataBase {
  static final ChatDataBase instance = ChatDataBase._init();

  static Database? _database;

  ChatDataBase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('chat.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 2, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textTypeNonNull = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE $tableNotes ( 
      ${ChatFields.id} $idType, 
      ${ChatFields.mid} $textTypeNonNull, 
      ${ChatFields.commonId} $textTypeNonNull, 
      ${ChatFields.data} $textTypeNonNull,
      ${ChatFields.date} $textTypeNonNull,
      ${ChatFields.sender} $textTypeNonNull
    )
      ''');
  }

  Future<void> create(Message message, String senderId) async {
    final db = await instance.database;
    await db.insert(tableNotes, message.toJson(senderId));
  }

  Future<List<Message>> readAllMessages() async {
    final db = await instance.database;
    final result = await db.query(tableNotes);

    return result.map((json) => Message.fromJson(json)).toList();
  }

  Future<List<Message>> readMessagesFor(id) async {
    final db = await instance.database;

    final result = await db.query(
      tableNotes,
      columns: ChatFields.values,
      where: '${ChatFields.mid} = ?',
      whereArgs: [id],
      orderBy: '${ChatFields.date} ASC',
    );
    return result.map((json) => Message.fromJson(json)).toList();
  }

  Future<int> update(Message note, String senderId) async {
    final db = await instance.database;

    return db.update(
      tableNotes,
      note.toJson(senderId),
      where: '${ChatFields.id} = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> delete(String id) async {
    final db = await instance.database;
    return await db.delete(
      tableNotes,
      where: '${ChatFields.commonId} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
