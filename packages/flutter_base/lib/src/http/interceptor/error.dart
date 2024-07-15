import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_base/flutter_base.dart';

class ErrorInterceptor extends Interceptor {
  /// 错误拦截器，注意：如果你要添加自定义拦截器，请将错误拦截器放在最后
  ErrorInterceptor();

  @override
  onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.requestOptions.extra['closeLoadingFun'] != null) {
      await response.requestOptions.extra['closeLoadingFun']();
    }
    return handler.resolve(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    e(err, '全局Http请求异常：${err.requestOptions.uri}');
    if (err.requestOptions.extra['closeLoadingFun'] != null) {
      await err.requestOptions.extra['closeLoadingFun']();
    }
    String errorMsg = '';
    switch (err.type) {
      case DioExceptionType.sendTimeout:
      case DioExceptionType.connectionTimeout:
        errorMsg = '服务器连接超时，请稍后重试！';
        break;
      case DioExceptionType.receiveTimeout:
        errorMsg = '服务器响应超时，请稍后重试！';
        break;
      case DioExceptionType.badResponse:
        if (err.message != null && err.message!.contains('404')) {
          errorMsg = '请求接口404';
        } else {
          errorMsg = '无效请求';
        }
        break;
      case DioExceptionType.connectionError:
        errorMsg = '服务器连接错误';
        break;
      case DioExceptionType.badCertificate:
        errorMsg = '服务证书错误';
        break;
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.unknown:
        if (err.error is SocketException) {
          errorMsg = '网络连接错误，请检查网络连接！';
        } else {
          errorMsg = '网络连接出现未知错误！';
        }
        break;
    }
    if (err.requestOptions.extra['errorMessageFun'] != null) {
      if (errorMsg != '') err.requestOptions.extra['errorMessageFun'](errorMsg);
    }
    handler.reject(err);
  }
}
