// GENERATED CODE - DO NOT MODIFY BY HAND
// Emitted on: 2020-10-30 15:36:17.593247

// **************************************************************************
// Generator: OrmM8GeneratorForAnnotation
// **************************************************************************

import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:flutter_app/models/independent/setting.dart';

class SettingProxy extends Setting {
  SettingProxy();

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['lang'] = lang;

    return map;
  }

  SettingProxy.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.lang = map['lang'];
  }
}

mixin SettingDatabaseProvider {
  Future<Database> db;
  final theSettingColumns = ["id", "lang"];

  final String theSettingTableHandler = 'settings';
  Future createSettingTable(Database db) async {
    await db.execute('''CREATE TABLE $theSettingTableHandler (
    id INTEGER  PRIMARY KEY AUTOINCREMENT,
    lang TEXT 
    )''');
  }

  Future<int> saveSetting(SettingProxy instanceSetting) async {
    var dbClient = await db;

    var result =
        await dbClient.insert(theSettingTableHandler, instanceSetting.toMap());
    return result;
  }

  Future<List<SettingProxy>> getSettingProxiesAll() async {
    var dbClient = await db;
    var result = await dbClient.query(theSettingTableHandler,
        columns: theSettingColumns, where: '1');

    return result.map((e) => SettingProxy.fromMap(e)).toList();
  }

  Future<int> getSettingProxiesCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient
        .rawQuery('SELECT COUNT(*) FROM $theSettingTableHandler  WHERE 1'));
  }

  Future<SettingProxy> getSetting(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(theSettingTableHandler,
        columns: theSettingColumns, where: '1 AND id = ?', whereArgs: [id]);

    if (result.length > 0) {
      return SettingProxy.fromMap(result.first);
    }

    return null;
  }

  Future<int> deleteSetting(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete(theSettingTableHandler, where: 'id = ?', whereArgs: [id]);
  }

  Future<bool> deleteSettingProxiesAll() async {
    var dbClient = await db;
    await dbClient.delete(theSettingTableHandler);
    return true;
  }

  Future<int> updateSetting(SettingProxy instanceSetting) async {
    var dbClient = await db;

    return await dbClient.update(
        theSettingTableHandler, instanceSetting.toMap(),
        where: "id = ?", whereArgs: [instanceSetting.id]);
  }
}
