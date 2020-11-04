// GENERATED CODE - DO NOT MODIFY BY HAND
// Emitted on: 2020-10-30 15:36:17.593247

// **************************************************************************
// Generator: OrmM8GeneratorForAnnotation
// **************************************************************************

import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:flutter_app/models/independent/tasks.dart';

class TasksProxy extends Tasks {
  TasksProxy();

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['description'] = description;
    map['audio'] = audio;

    return map;
  }

  TasksProxy.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.description = map['description'];
    this.audio = map['audio'];
  }
}

mixin TasksDatabaseProvider {
  Future<Database> db;
  final theTasksColumns = ["id", "description", "audio"];

  final String theTasksTableHandler = 'tasks';
  Future createTasksTable(Database db) async {
    await db.execute('''CREATE TABLE $theTasksTableHandler (
    id INTEGER  PRIMARY KEY AUTOINCREMENT,
    description TEXT ,
    audio TEXT 
    )''');
  }

  Future<int> saveTasks(TasksProxy instanceTasks) async {
    var dbClient = await db;

    var result =
        await dbClient.insert(theTasksTableHandler, instanceTasks.toMap());
    return result;
  }

  Future<List<TasksProxy>> getTasksProxiesAll() async {
    var dbClient = await db;
    var result = await dbClient.query(theTasksTableHandler,
        columns: theTasksColumns, where: '1');

    return result.map((e) => TasksProxy.fromMap(e)).toList();
  }

  Future<int> getTasksProxiesCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient
        .rawQuery('SELECT COUNT(*) FROM $theTasksTableHandler  WHERE 1'));
  }

  Future<TasksProxy> getTasks(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(theTasksTableHandler,
        columns: theTasksColumns, where: '1 AND id = ?', whereArgs: [id]);

    if (result.length > 0) {
      return TasksProxy.fromMap(result.first);
    }

    return null;
  }

  Future<int> deleteTasks(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete(theTasksTableHandler, where: 'id = ?', whereArgs: [id]);
  }

  Future<bool> deleteTasksProxiesAll() async {
    var dbClient = await db;
    await dbClient.delete(theTasksTableHandler);
    return true;
  }

  Future<int> updateTasks(TasksProxy instanceTasks) async {
    var dbClient = await db;

    return await dbClient.update(theTasksTableHandler, instanceTasks.toMap(),
        where: "id = ?", whereArgs: [instanceTasks.id]);
  }
}
