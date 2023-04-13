import 'package:chat_ai/features/chat_ai/data/datasource/database_tables.dart';
import 'package:chat_ai/features/chat_ai/data/model/chat_message/chat_message_model.dart';
import 'package:chat_ai/features/chat_ai/data/request/chat_message/chat_message_request.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SqlHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute('''CREATE TABLE ${DbTables.chatMessages}(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      text TEXT,
      isImage INTEGER NOT NULL,
      sender TEXT
      date TEXT
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      ''');
  }

  static Future<sql.Database> dbInit() async {
    return sql.openDatabase('chatai.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

 static Future<dynamic> alterTable(String tableName, String columnName) async {
    final sql.Database db = await dbInit();

    final  count = await db.execute('ALTER TABLE $tableName ADD '
        'COLUMN $columnName TEXT;');
   // print(await db.query(DbTables.chatMessages));
    return count;
  }

  static Future<ChatMessage> addMessage(
      ChatMessageRequest messageRequest) async {
    final sql.Database db = await dbInit();
    final Map<String, dynamic> data = <String, dynamic>{
      'text' : messageRequest.text,
      'isImage' :messageRequest.isImage == true ? 1 : 0,
      //'createdAt': messageRequest.createdAt,
      'sender': messageRequest.sender,
      'date' : messageRequest.createdAt,
    };
    final int id = await db.insert(
      DbTables.chatMessages,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
    final ChatMessage chatMessage = await fetchChatMessage(id);
    return chatMessage;
  }

  static Future<List<ChatMessage>> fetchChatMessages() async {
    final sql.Database db = await dbInit();
    final List<Map<String, dynamic>> items =
        await db.query(DbTables.chatMessages, orderBy: 'id');
    print(items);
    return List<ChatMessage>.from(
      items.map<ChatMessage>(
        (Map<String, dynamic> data) {
          final Map<String, dynamic> json = <String,dynamic>{
            'id': data['id'],
            'text' : data['text'],
            'isImage' :data['isImage'] == 1 ? true : false,
            'createdAt': data['date'],
            'sender': data['sender'],
          };
         return ChatMessage.fromJson(json);
        },
      ),
    );
  }

  static Future<ChatMessage> fetchChatMessage(int id) async {
    final sql.Database db = await dbInit();
    final List<Map<String, dynamic>> items = await db.query(
      DbTables.chatMessages,
      where: '?',
      whereArgs: <int>[id],
      limit: 1,
    );
    final Map<String, dynamic> data = items[0];
    final Map<String, dynamic> json = <String,dynamic>{
      'id': data['id'],
      'text' : data['text'],
      'isImage' :data['isImage'] == 1 ? true : false,
      'createdAt': data['date'],
      'sender': data['sender'],
    };
    return ChatMessage.fromJson(json);
  }

  static Future<ChatMessage> updateChatMessage(int messageId,
      ChatMessageRequest messageRequest) async {
    final sql.Database db = await dbInit();

    final Map<String, dynamic> data = <String, dynamic>{
      'text' : messageRequest.text,
      'isImage' :messageRequest.isImage == true ? 1 : 0,
      //'createdAt': messageRequest.createdAt,
      'sender': messageRequest.sender,
      'date': messageRequest.createdAt,
    };
    final int id = await db.update(
      DbTables.chatMessages,
      data,
      where: '?',
      whereArgs: <int>[messageId],
    );
    final  ChatMessage chatMessage = await fetchChatMessage(id);
    return chatMessage;
  }

  static Future<void> deleteChatMessage(int id) async{
    final sql.Database db = await dbInit();
    try{
      print(id);
      final int count = await db.delete(DbTables.chatMessages,  where: 'id = ?',
        whereArgs: <int>[id],);
      debugPrint('Deleted $count row(s)');
    }catch(e){
      debugPrint('Something went wrong deleting the item $e');
    }
  }
}
