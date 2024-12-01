import 'dart:convert';

import 'package:flutter_base/flutter_base.dart';

/// 缓存拦截器
class CacheInterceptor extends Interceptor {
  static late String _cacheKey;
  static late int _cacheTime;
  static late bool _showLog;

  static Map<String, Map<String, dynamic>> cacheData = {};

  /// 初始化http本地缓存
  /// * cacheKey 缓存key
  /// * cacheTime 缓存时间
  /// * showLog 是否打印日志
  static Future<void> init({
    String cacheKey = 'http_cache',
    int cacheTime = 1000 * 60 * 60,
    bool showLog = true,
  }) async {
    _cacheKey = cacheKey;
    _cacheTime = cacheTime;
    _showLog = showLog;
    var localStr = sp.getString(_cacheKey);
    if (localStr != null) {
      cacheData =
          (jsonDecode(localStr) as Map).cast<String, Map<String, dynamic>>();
    }
  }

  /// 清除http缓存数据
  static Future<void> clearCache() async {
    cacheData.clear();
    sp.remove(_cacheKey);
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String url = options.uri.toString();
    if (options.extra['useCache'] == true) {
      String key = FlutterUtil.md5(url);
      if (cacheData[key] == null) {
        handler.next(options);
      } else {
        final modelData = ExpireDataModel.fromJson(cacheData[key]!);
        if (modelData.expire == null ||
            modelData.expire! <= 0 ||
            modelData.expire! > currentMilliseconds) {
          if (_showLog) i(url, '接口缓存');
          if (options.extra['closeLoadingFun'] != null) {
            await options.extra['closeLoadingFun']();
          }
          handler
              .resolve(Response(requestOptions: options, data: modelData.data));
        } else {
          handler.next(options);
        }
      }
    } else {
      handler.next(options);
    }
  }

  @override
  onResponse(Response response, ResponseInterceptorHandler handler) async {
    // 判断请求选项是否配置了enableCache，如果为true则将结果保存到本地
    if (response.requestOptions.extra['enableCache'] == true) {
      String key = FlutterUtil.md5(response.requestOptions.uri.toString());
      cacheData[key] = ExpireDataModel(response.data,
              response.requestOptions.extra['cacheTime'] ?? _cacheTime)
          .toJson();
      sp.setString(
        _cacheKey,
        jsonEncode(cacheData),
      );
    }
    return handler.next(response);
  }
}
