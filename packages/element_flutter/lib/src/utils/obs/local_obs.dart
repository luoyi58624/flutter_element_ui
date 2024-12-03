import 'package:flutter_obs/flutter_obs.dart';

class LocalObs<T> extends Obs<T> {
  /// 支持本地缓存响应式变量
  LocalObs(
    super.value, {
    this.cacheKey,
    this.expire = -1,
    super.watch,
    super.immediate,
  }) {
    super.addWatch((newValue, oldValue) {});
  }

  /// 缓存 key，请保证唯一
  final String? cacheKey;

  /// 缓存过期时间，单位毫秒，默认 -1，如果小于 0，则表示无过期时间
  final int expire;
}
