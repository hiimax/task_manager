import 'dart:io' as io;

import 'package:task_manager/res/import/import.dart';

class AuthDataBase {
  Database? _database;

  String databaseName = 'auth.db';
  static const int versionNumber = 1;
  String tableNotes = 'Users';
  String colUUid = 'uuid';
  String colFullName = 'fullName';
  String colEmail = 'email';
  String colUpdated = 'updated';
  String colCreated = 'created';
 

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, databaseName);
    var db =
        await openDatabase(path, version: versionNumber, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int intVersion) async {
    await db.execute("CREATE TABLE IF NOT EXISTS $tableNotes ("
        "$colUUid INTEGER PRIMARY KEY,"
        "$colFullName TEXT,"
        "$colEmail TEXT,"
        "$colCreated TEXT,"
        "$colUpdated TEXT,"
       
        ")");
  }

  Future<List<UserModel>> getAll() async {
    final db = await database;
    final result = await db.query(tableNotes, orderBy: '$colUUid ASC');
    return result.map((json) => UserModel.fromJson(json)).toList();
  }

  Future<UserModel?> read(String column, String value) async {
    final db = await database;
    final maps = await db.query(
      tableNotes,
      where: '$column = ?',
      whereArgs: [value],
    );

    if (maps.isNotEmpty) {
      return UserModel.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<void> insert(UserModel note) async {
    final db = await database;
    await db.insert(tableNotes, note.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> update(UserModel note) async {
    final db = await database;
    var res = await db.update(tableNotes, note.toJson(),
        where: '$colUUid = ?', whereArgs: [note.uuid]);
    return res;
  }

  Future<void> delete(String id) async {
    final db = await database;
    try {
      await db.delete(tableNotes, where: "$colUUid = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}
