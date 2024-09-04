import 'dart:developer';
import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_manager/models/task_model.dart';

class TaskDatabase {
  Database? _database;
  late String userId;

  TaskDatabase(String id) {
    userId = id;
    log(id, name: 'userId');
    _initDatabase();
  }

  String databaseName = 'tasks.db';
  static const int versionNumber = 3;
  String tableNotes = 'Tasks';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colStatus = 'status';
  String colCategory = 'category';
  String colCreatedAt = 'created_at';
  String colUpdatedAt = 'updated_at';
  String colDueAt = 'due_at';
  String colReminder = 'reminder';
  String colIsSynced = 'is_synced';
  String colUid = 'uid';
  String isDeleted = 'is_deleted';

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, userId);
    var db = await openDatabase(
      path,
      version: versionNumber,
      onCreate: _onCreate,
    );
    return db;
  }

  _onCreate(Database db, int intVersion) async {
    await db.execute('''
    CREATE TABLE $tableNotes (
      $colId INTEGER PRIMARY KEY AUTOINCREMENT,
      $colTitle TEXT ,
      $colDescription TEXT ,
      $colStatus TEXT ,
      $colCategory TEXT ,
      $colCreatedAt TEXT ,
      $colUpdatedAt TEXT ,
      $colDueAt TEXT ,
      $colReminder TEXT ,
      $colIsSynced TEXT ,
      $colUid TEXT UNIQUE,
      $isDeleted TEXT 
    )''');
  }

  Future<List<TasksModel>> getOnlineTasks() async {
    final db = await database;
    final result = await db.query(tableNotes,
        orderBy: '$colUpdatedAt DESC',
        where: '$colIsSynced = ?',
        whereArgs: ['true'],
        
        );
    return result.map((json) => TasksModel.fromJson(json)).toSet().toList();
  }

  Future<List<TasksModel>> getLocalTasks() async {
    final db = await database;
    final result = await db.query(tableNotes,
        orderBy: '$colUpdatedAt DESC',
        where: '$colIsSynced = ?',
        whereArgs: ['false']);
    return result.map((json) => TasksModel.fromJson(json)).toSet().toList();
  }

  Future<TasksModel?> read(String column, String value) async {
    final db = await database;
    final maps = await db.query(
      tableNotes,
      where: '$column = ?',
      whereArgs: [value],
    );

    if (maps.isNotEmpty) {
      return TasksModel.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<void> insert(TasksModel note) async {
    debugPrint(note.toJson().toString());
    final db = await database;
    await db.insert(
      tableNotes,
      note.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> update(TasksModel note) async {
    final db = await database;
    var res = await db.update(
      tableNotes,
      note.toJson(),
      where: '$colUid = ?',
      whereArgs: [note.id],
    );
    return res;
  }

  Future<void> delete(String id) async {
    final db = await database;
    try {
      await db.delete(tableNotes, where: "$colId = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}
