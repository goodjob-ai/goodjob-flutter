import 'dart:convert';

import 'package:goodjob_flutter/src/goodjob_entity.dart';
import 'package:goodjob_flutter/src/language_entity.dart';
import 'package:goodjob_flutter/src/http_util.dart';
import 'package:goodjob_flutter/src/log_utils.dart';
import 'package:quiver/cache.dart';
import 'package:goodjob_flutter/src/config.dart';
import 'package:goodjob_flutter/src/database_helper.dart';
import 'package:goodjob_flutter/src/response.dart';
import 'package:goodjob_flutter/src/api.dart';

class GoodJobBusiness {
  // ignore: missing_return
  static GoodJobBusiness _goodJobBusiness;

  static getInstance() {
    if (_goodJobBusiness == null) {
      _goodJobBusiness = new GoodJobBusiness();
    }
    return _goodJobBusiness;
  }

  DatabaseHelper _databaseHelper = DatabaseHelper.getInstance();
  GoodJobConfig config = GoodJobConfig.getInstances();

  ///初始化sdk
  Future initSDK({apiKey = "", apiSecret = "", token = "", id, isDebug}) async {
    config.initAuth(apiKey: apiKey, apiSecret: apiSecret);
    LogUtil.init(isDebug: isDebug, tag: "goodjob:");
    var r = await _databaseHelper.init(id: id);
    LogUtil.v("数据库初始化结果" + r.toString());
    return r;
  }

  ///获取当前语言
  getLanguage() {
    return _databaseHelper.tableName;
  }

  ///切换语言
  switchLanguage({language}) {
    _databaseHelper.tableName = language;
  }

  ///翻譯
  Future interpret(String text) async {
    //先從緩存拿，失敗后再去數據庫
    var content = await _databaseHelper.queryCacheValue(text);
    if (content == 0) {
      var c = await _databaseHelper.queryValue(text);
      if (content == 0) {
        return "error!";
      } else {
        return c;
      }
    } else {
      return content;
    }
  }

  ///获取国家列表
  Future<List<LanguageEntity>> getLanguageList() async {
    ResponseEntity res = await HttpUtil.get(Api.languageList, needToken: true);
    List<LanguageEntity> list = List();
    if (res.code == 0) {
      (res.data['LanguageList'] as List).forEach((v) {
        list.add(LanguageEntity.fromJson(v));
      });
    } else {
      list = [];
    }
//    LanguageListEntity listEntity = LanguageListEntity.fromJson(jsonDecode(res.toString()));
    return list;
  }

  ///获取字典内容
  Future<List<GoodjobEntity>> getGoodJobData(String id) async {
    List<GoodjobEntity> list = new List();
    ResponseEntity res = await HttpUtil.get(Api.getGoodJobData + id, needToken: true);
    if (res.code == 0) {
      (res.data['contents'] as List).forEach((f) {
        list.add(GoodjobEntity.fromJson(f));
      });
    } else {
      list = [];
    }
    return list;
  }

  Future<List<LanguageModel>> getGoodJobDataJson(String id) async {
    List<GoodjobEntity> list = new List();
    List<LanguageModel> listLang = new List();
    //写入到缓存的数据
    Map<String, MapCache<String, String>> mapCache = new Map();
    ResponseEntity res = await HttpUtil.get(Api.getGoodJobData + id, needToken: true);
    if (res.code == 0) {
      (res.data as List).forEach((v) {
        LanguageModel languageModel = LanguageModel.fromJson(v);
        if (languageModel.lang.isNotEmpty) {
          listLang.add(languageModel);
          mapCache[languageModel.lang] = languageModel.mapCache;
        }
      });
      return listLang;
    } else {
      return [];
    }
  }
}

class LanguageModel {
  String title;
  String lang;
  List<Map<String, dynamic>> listMap;
  MapCache<String, String> mapCache = new MapCache();

  LanguageModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    lang = json['lang'].toString().replaceFirst("-", "");
    if (json["list"] != null) {
      listMap = new List();
      (json["list"] as List).forEach((f) {
        Map<String, dynamic> map = new Map();
        String keyName = f["u_key"].toString().isEmpty ? f["g_key"] : f["u_key"];
        map['name'] = keyName;
        map['value'] = f['name'];
        mapCache.set(keyName, f['name']);
        listMap.add(map);
      });
    }
  }

  @override
  String toString() {
    return 'LanguageModel{title: $title, lang: $lang, listMap: $listMap}';
  }
}
