import 'dart:async';

import 'package:chat_app/models/chat/message.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String tableNotes = 'chat';
const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
const textTypeNonNull = 'TEXT NOT NULL';

class ChatFields {
  static final List<String> values = [
    id,
    date,
    commonId,
    mid,
    data,
    sender,
    messageStatus,
    replyTo,
  ];
  static const String id = '_id';
  static const String mid = 'id';
  static const String commonId = 'commonId';
  static const String date = 'data';
  static const String data = 'date';
  static const String sender = 'sender';
  static const String replyTo = 'replyTo';
  static const String messageStatus = 'message_status';
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
    int nbrMigrationScripts = migrationScripts.length;
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: nbrMigrationScripts,
      onCreate: _createDB,
      onUpgrade: _updateDB,
    );
  }

  Future _createDB(Database db, int version) async {
    int nbrMigrationScripts = migrationScripts.length;
    for (int i = 1; i <= nbrMigrationScripts; i++) {
      await db.execute(migrationScripts[i]!);
    }
  }

  Future _updateDB(Database db, int oldVersion, int newVersion) async {
    for (int i = oldVersion + 1; i <= newVersion; i++) {
      await db.execute(migrationScripts[i]!);
    }
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
    return await db.update(
      tableNotes,
      note.toJson(senderId),
      where: '${ChatFields.commonId} = ?',
      whereArgs: [note.commonId],
    );
  }

  Future<void> updateReadStatus(Message message) async {
    final db = await instance.database;
    db.rawUpdate(
      '''
    UPDATE $tableNotes 
    SET ${ChatFields.messageStatus} = ? 
    WHERE ${ChatFields.commonId} = ?
    ''',
      [message.getReadStatus(), message.commonId],
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

  static Future close() async {
    final db = await instance.database;
    db.close();
  }

  static deleteDataBase() async {
    final db = await instance.database;

    await db.delete(tableNotes);
    print('Done');
  }
}

Map<int, String> migrationScripts = {
  1: '''
    CREATE TABLE $tableNotes ( 
      ${ChatFields.id} $idType, 
      ${ChatFields.mid} $textTypeNonNull, 
      ${ChatFields.commonId} $textTypeNonNull, 
      ${ChatFields.data} $textTypeNonNull,
      ${ChatFields.date} $textTypeNonNull,
      ${ChatFields.sender} $textTypeNonNull,
      ${ChatFields.messageStatus} $textTypeNonNull
    )''',
  2: 'ALTER TABLE $tableNotes ADD replyTo TEXT',
};
