import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/widgets.dart';
import 'package:crypto/crypto.dart';
import 'package:goodjob_language/src/api.dart';
import 'package:goodjob_language/src/log_utils.dart';
import 'package:goodjob_language/src/response.dart';
import 'package:goodjob_language/src/config.dart';

/// 监听当前的网络请求状态，根据状态显示一些必要提醒
BaseOptions _options = new BaseOptions(
    baseUrl: Api.baseUrl,
    connectTimeout: 10000,
    receiveTimeout: 3000,
    headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });

///网络请求工具
class HttpUtil {
  static Dio _dio;

  static getInstance() {
    if (_dio == null) {
      _dio = new Dio(_options);
    }
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
//         if(cert.pem==PEM){ // Verify the certificate
//            return true;
//          }
        return true;
      };
    };
    return _dio;
  }

  /// get
  static Future<ResponseEntity> get(String url,
      {Map<String, dynamic> params, needToken = false}) async {
    Response _response;
    Dio _dio = getInstance();
    _dio.interceptors.add(new ExInterceptor());
    //print("url == " + url.toString());
    String timestamp =
        (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
    //从服务器获取时间戳
    var timeData = await Dio().get("https://api.goodjob.ai/time");
    if (timeData != null && jsonDecode(timeData.toString())["data"] != null) {
      timestamp = jsonDecode(timeData.toString())["data"]['timestamp'].toString();
    }
    String keyName = 'tokenGET/$url$timestamp';
    //加密
    var _macSha256 = new Hmac(sha256, utf8.encode(GoodJobConfig.mApiSecret));
    var digest = _macSha256.convert(utf8.encode(keyName));
    LogUtil.v('params:$keyName\sign:' +
        digest.toString() +
        '\napikey:${GoodJobConfig.mApiKey}\n'
            'timestamp:$timestamp');
    if (needToken) {
//      options.headers['Authorization'] = "Bearer " + GoodJobConfig.tokenKey;
      _options.headers['ApiKey'] = GoodJobConfig.mApiKey;
      _options.headers['timestamp'] = timestamp;
      _options.headers['sign'] = digest;
    }
    ResponseEntity _entity;
    try {
      _response = await _dio.get(url,
          queryParameters: params,
          options: buildCacheOptions(Duration(days: 1)));
      if (_response.statusCode == 200) {
        _entity = ResponseEntity.fromJson(jsonDecode(_response.toString()));
      } else {
        _entity = new ResponseEntity(
            code: -1, status: "服务器错误:${_response.statusMessage}");
      }
    } on DioError catch (e) {
      LogUtil.v(e);
      _entity = new ResponseEntity(code: -1, status: "请求出错：${e.toString()}");
    }
    LogUtil.v("${Api.baseUrl}$url------" + _entity.toString());
    return _entity;
  }

  /// post
  static Future<ResponseEntity> post(
    String url,
    Map<String, dynamic> params,
  ) async {
    LogUtil.v(params.toString());
    LogUtil.v("url == " + url.toString());
    Response _response;
    Dio _dio = getInstance();
    _dio.interceptors.add(new ExInterceptor());
    ResponseEntity _entity;
    try {
      _response = await _dio.get(url, queryParameters: params);
      if (_response.statusCode == 200) {
        _entity = ResponseEntity.fromJson(jsonDecode(_response.toString()));
      } else {
        _entity = new ResponseEntity(
            code: -1, status: "服务器错误:${_response.statusMessage}");
      }
    } on DioError catch (e) {
      _entity = new ResponseEntity(code: -1, status: "请求出错：${e.toString()}");
    }
    LogUtil.v(_entity.toString());
    return _entity;
  }
}

typedef void ChildContext(BuildContext context);

/// 请求拦截器
class ExInterceptor extends InterceptorsWrapper {
  BuildContext context;

  @override
  onRequest(RequestOptions options) async {
    return options;
  }

  @override
  onError(DioError err) async {
    if (err.response != null && err.response.statusCode == 401) {}
    return err;
  }

  @override
  onResponse(Response response) async {
    return response;
  }
}
