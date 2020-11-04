// GENERATED CODE - DO NOT MODIFY BY HAND
// Emitted on: 2020-10-30 15:36:17.593247

// **************************************************************************
// Generator: OrmM8GeneratorForAnnotation
// **************************************************************************

import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:flutter_app/models/independent/user.dart';

class UserProxy extends User {
  UserProxy();

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['mobile'] = mobile;
    map['firstname'] = firstname;
    map['lastname'] = lastname;

    return map;
  }

  UserProxy.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.mobile = map['mobile'];
    this.firstname = map['firstname'];
    this.lastname = map['lastname'];
  }
}

mixin UserDatabaseProvider {
  Future<Database> db;
  final theUserColumns = ["id", "mobile", "firstname", "lastname"];

  final String theUserTableHandler = 'users';
  Future createUserTable(Database db) async {
    await db.execute('''CREATE TABLE $theUserTableHandler (
    id INTEGER  PRIMARY KEY AUTOINCREMENT,
    mobile TEXT ,
    firstname TEXT ,
    lastname TEXT ,
    UNIQUE (mobile)
    )''');
  }

  Future<int> saveUser(UserProxy instanceUser) async {
    var dbClient = await db;

    var result =
        await dbClient.insert(theUserTableHandler, instanceUser.toMap());
    return result;
  }

  Future<List<UserProxy>> getUserProxiesAll() async {
    var dbClient = await db;
    var result = await dbClient.query(theUserTableHandler,
        columns: theUserColumns, where: '1');

    return result.map((e) => UserProxy.fromMap(e)).toList();
  }

  Future<int> getUserProxiesCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient
        .rawQuery('SELECT COUNT(*) FROM $theUserTableHandler  WHERE 1'));
  }

  Future<UserProxy> getUser(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(theUserTableHandler,
        columns: theUserColumns, where: '1 AND id = ?', whereArgs: [id]);

    if (result.length > 0) {
      return UserProxy.fromMap(result.first);
    }

    return null;
  }

  Future<int> deleteUser(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete(theUserTableHandler, where: 'id = ?', whereArgs: [id]);
  }

  Future<bool> deleteUserProxiesAll() async {
    var dbClient = await db;
    await dbClient.delete(theUserTableHandler);
    return true;
  }

  Future<int> updateUser(UserProxy instanceUser) async {
    var dbClient = await db;

    return await dbClient.update(theUserTableHandler, instanceUser.toMap(),
        where: "id = ?", whereArgs: [instanceUser.id]);
  }
}
