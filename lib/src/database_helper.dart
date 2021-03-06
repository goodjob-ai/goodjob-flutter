import 'package:goodjob_language/src/business.dart';
import 'package:goodjob_language/goodjob_language.dart';
import 'package:goodjob_language/src/log_utils.dart';
import 'package:path/path.dart';
import 'package:quiver/cache.dart';
import 'package:sqflite/sqflite.dart';

///数据库辅助工具
class DatabaseHelper {
  Database _database;

  /// 路径
  String path;

  /// 表名 根据语言多少种创建几个
  String tableName = '';
  static DatabaseHelper _databaseHelper;

  /// 存储
  Map<String, MapCache<String, String>> _map;

  static getInstance() {
    if (_databaseHelper == null) {
      _databaseHelper = new DatabaseHelper();
    }
    return _databaseHelper;
  }

  /// 清空数据库
  clearDB() {
    if (_database != null) {
      _database.close();
    }
  }

  /// 数据库初始化
  Future init({id}) async {
    List<LanguageModel> list =
        await GoodJobBusiness().getGoodJobDataJson(id == null ? "10133" : id);
    if (_database == null || !_database.isOpen) {
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'demo.db');
      _database = await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
        //几种语言就建几个表
        list.forEach((v) async {
          String name = v.lang;
          tableName = name;
          await db.execute(
              'CREATE TABLE $name (id INTEGER PRIMARY KEY, name TEXT, value INTEGER)');
        });
      });
      _map = new Map();
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
        _map[name] = v.mapCache;
      });
    }

    if (tableName.isNotEmpty) {
      return 1;
    } else {
      return 0;
    }
  }

  /// 插入一条翻译
  Future insertData(Map<String, dynamic> map, String tableName) async {
    if (_database.isOpen) {
      await _database.transaction((txn) async {
        txn.insert(tableName, map);
      });
    } else {
      LogUtil.v("数据库未打开");
    }
  }

  /// 查询所有
  Future queryAll() async {
    if (tableName.isNotEmpty) {
      List<Map<String, dynamic>> records = await _database.query(tableName);
      return records.toString();
    }
  }

  /// 获取翻译文字
  Future queryValue(String nameKey) async {
//    debugPrint("queryValue:$nameKey,$tableName");FF
    try {
      List<Map> maps = await _database.query(tableName,
          columns: ['name', 'value'],
          where: '"name" = ?',
          whereArgs: [nameKey]);
      return maps.first['value'];
    } catch (e) {
      LogUtil.e("Translation Error !");
      return 0;
    }
  }

  /// 从缓存读取
  Future queryCacheValue(String nameKey) async {
    MapCache<String, String> mapCache = new MapCache();
    try {
      mapCache = _map[tableName];
//      LogUtil.v(mapCache.toString(), tag: "mapCache");
      var v = await mapCache.get(nameKey);
//      LogUtil.v(v.toString(), tag: "mapCacheValue");
      return v;
    } catch (e) {
      LogUtil.e("Translation Error !");
      return 0;
    }
  }
}
