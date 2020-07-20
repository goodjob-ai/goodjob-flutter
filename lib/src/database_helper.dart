import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:goodjob_flutter/src/business.dart';
import 'package:goodjob_flutter/goodjob_flutter.dart';
import 'package:goodjob_flutter/src/log_utils.dart';
import 'package:path/path.dart';
import 'package:quiver/cache.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  Database _database;
  String keyName = "keyname";
  String languageValue = "language_value";
  String path;
  String tableName = '';
  static DatabaseHelper _databaseHelper;
  Map<String, MapCache<String, String>> map;

  static getInstance() {
    if (_databaseHelper == null) {
      _databaseHelper = new DatabaseHelper();
    }
    return _databaseHelper;
  }

  clearDB() {
    if (_database != null) {
      _database.close();
    }
  }

  ///数据库初始化
  Future init({id}) async {
    List<LanguageModel> list =
        await GoodJobBusiness().getGoodJobDataJson(id == null ? "10133" : id);
    if (_database == null || !_database.isOpen) {
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'demo.db');
      _database = await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
        //几种语言就建几个表
        list.forEach((v) async {
          String name = v.lang;
          tableName = name;
//          debugPrint("tableName:" + tableName.toString());
          await db.execute('CREATE TABLE $name (id INTEGER PRIMARY KEY, name TEXT, value INTEGER)');
        });
      });
      map = new Map();
      list.forEach((v) {
        //循环插入所有数据
        try {
          v.listMap.forEach((f) {
            insertData(f, v.lang);
          });
        } catch (e) {
          LogUtil.v(e.toString());
        }
        String name = v.lang;
        map[name] = v.mapCache;
      });
    }

    if (tableName.isNotEmpty) {
      return 1;
    } else {
      return 0;
    }
  }

  //插入一条翻译
  Future insertData(Map<String, dynamic> map, String tableName) async {
    if (_database.isOpen) {
      await _database.transaction((txn) async {
        txn.insert(tableName, map);
      });
    } else {
      LogUtil.v("数据库未打开");
    }
  }

  Future queryAll() async {
    if (tableName.isNotEmpty) {
      List<Map<String, dynamic>> records = await _database.query(tableName);
      return records.toString();
    }
  }

  //获取翻译文字
  Future queryValue(String nameKey) async {
//    debugPrint("queryValue:$nameKey,$tableName");FF
    try {
      List<Map> maps = await _database.query(tableName,
          columns: ['name', 'value'], where: '"name" = ?', whereArgs: [nameKey]);
      return maps.first['value'];
    } catch (e) {
      LogUtil.e("Translation Error !");
      return 0;
    }
  }

  Future queryCacheValue(String nameKey) async {
    MapCache<String, String> mapCache = new MapCache();
    try {
      mapCache = map[tableName];
//      LogUtil.v(mapCache.toString(), tag: "mapCache");
      var v = await mapCache.get(nameKey);
//      LogUtil.v(v.toString(), tag: "mapCacheValue");
      return v;
    } catch (e) {
      LogUtil.e("Translation Error !");
      return 0;
    }
  }

//  Future getTodo(String key) async {
//    List<Map> maps = await _database.query(tableName,
//        columns: [columnId, columnDone, columnTitle], where: '$key = ?', whereArgs: [id]);
//    if (maps.length > 0) {
//      return Todo.fromMap(maps.first);
//    }
//    return null;
//  }
}
