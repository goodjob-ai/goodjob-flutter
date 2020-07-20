import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/widgets.dart';
import 'package:crypto/crypto.dart';
import 'package:goodjob_flutter/src/api.dart';
import 'package:goodjob_flutter/src/log_utils.dart';
import 'package:goodjob_flutter/src/response.dart';
import 'package:goodjob_flutter/src/config.dart';
/// 监听当前的网络请求状态，根据状态显示一些必要提醒

/*Options options = Options(
  // 连接服务器超时时间(毫秒)
    sendTimeout: 10000,
    receiveTimeout: 30000,
    headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });*/

BaseOptions options =
    new BaseOptions(baseUrl: Api.baseUrl, connectTimeout: 10000, receiveTimeout: 3000, headers: {
  "Content-Type": "application/json",
  "Accept": "application/json",
});

class HttpUtil {
  static Dio _dio;

  static getInstance() {
    if (_dio == null) {
      _dio = new Dio(options);
    }
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) {
//         if(cert.pem==PEM){ // Verify the certificate
//            return true;
//          }
        return true;
      };
    };
    return _dio;
  }

  // get
  // ignore: missing_return
  static Future<ResponseEntity> get(String url,
      {Map<String, dynamic> params, needToken = false}) async {
    Response response;
    Dio dio = getInstance();
    dio.interceptors.add(new ExInterceptor());
    //print("url == " + url.toString());
    String timestamp = (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
    //从服务器获取时间戳
    var timeData = await dio.get("https://xmtest.anmaicloud.com/time");
    if (timeData != null && jsonDecode(timeData.toString())["data"] != null) {
      timestamp = jsonDecode(timeData.toString())["data"].toString();
    }
    String keyName = 'tokenGET/$url$timestamp';
    //加密
    var hmacSha256 = new Hmac(sha256, utf8.encode(GoodJobConfig.mApiSecret)); // HMAC-SHA256
    var digest = hmacSha256.convert(utf8.encode(keyName));
    LogUtil.v('params:$keyName\sign:' +
        digest.toString() +
        '\napikey:${GoodJobConfig.mApiKey}\n'
            'timestamp:$timestamp');
    if (needToken) {
//      options.headers['Authorization'] = "Bearer " + GoodJobConfig.tokenKey;
      options.headers['ApiKey'] = GoodJobConfig.mApiKey;
      options.headers['timestamp'] = timestamp;
      options.headers['sign'] = digest;
    }
    ResponseEntity entity;
    try {
      response = await dio.get(url,
          queryParameters: params, options: buildCacheOptions(Duration(days: 1)));
      if (response.statusCode == 200) {
        entity = ResponseEntity.fromJson(jsonDecode(response.toString()));
      } else {
        entity = new ResponseEntity(code: -1, status: "服务器错误:${response.statusMessage}");
      }
    } on DioError catch (e) {
      entity = new ResponseEntity(code: -1, status: "请求出错：${e.toString()}");
    }
    LogUtil.v("${Api.baseUrl}$url------" + entity.toString());
    return entity;
  }

  // post
  static Future<ResponseEntity> post(
    String url,
    Map<String, dynamic> params,
  ) async {
    LogUtil.v(params.toString());
    LogUtil.v("url == " + url.toString());
    Response response;
    Dio dio = getInstance();
    dio.interceptors.add(new ExInterceptor());
    ResponseEntity entity;
    try {
      response = await dio.get(url, queryParameters: params);
      if (response.statusCode == 200) {
        entity = ResponseEntity.fromJson(jsonDecode(response.toString()));
      } else {
        entity = new ResponseEntity(code: -1, status: "服务器错误:${response.statusMessage}");
      }
    } on DioError catch (e) {
      entity = new ResponseEntity(code: -1, status: "请求出错：${e.toString()}");
    }
    LogUtil.v(entity.toString());
    return entity;
  }
}

typedef void ChildContext(BuildContext context);

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
