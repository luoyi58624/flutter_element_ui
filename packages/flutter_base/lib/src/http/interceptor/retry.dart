import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';

/// 重试请求拦截器
Interceptor retryInterceptor(Dio http) {
  return RetryInterceptor(
    dio: http,
    logPrint: print,
    retries: 3,
    retryDelays: const [
      Duration(seconds: 1),
      Duration(seconds: 2),
      Duration(seconds: 3),
    ],
  );
}
