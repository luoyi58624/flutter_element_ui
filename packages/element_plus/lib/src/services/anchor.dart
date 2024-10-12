import 'package:flutter/widgets.dart';

mixin AnchorService {
  /// 锚点服务对象，通常可以搭配 [ElAnchor] 小部件一起使用，
  final AnchorServiceInstance anchor = AnchorServiceInstance();
}

class AnchorServiceInstance {
  /// 瞄点集合
  final Map<String, GlobalKey> _anchorMap = {};

  /// 获取全部锚点名字
  List<String> get keys => _anchorMap.keys.toList();

  /// 获取锚点元素对象
  BuildContext? getContext(String key) => _anchorMap[key]?.currentContext;

  /// 设置锚点
  void setAnchor(
    String? key,
    GlobalKey value, {
    bool override = true,
  }) {
    if (key != null) {
      String $key = _getKey(key);
      if (override) {
        _anchorMap[$key] = value;
      } else {
        if (_anchorMap.containsKey($key) == false) {
          _anchorMap[$key] = value;
        }
      }
    }
  }

  /// 移除锚点
  void removeAnchor(String? key) {
    if (key != null) {
      String $key = _getKey(key);
      _anchorMap.remove($key);
    }
  }

  /// 滚动到锚点位置，如果 url 包含了 # 符号，则会自动解析字符串，否则直接当做 name 访问
  void scrollTo(String? url) {
    if (url != null) {
      BuildContext? context;
      // 如果 url 存在 # 锚点符号，则尝试解析 url 地址获取 ElLink 的 context 对象
      if (url.contains('#')) {
        final key = Uri.decodeComponent(url).split('#').last;
        context = getContext(_getKey(key));
      }
      // 若是单纯的字符串，则当作 name 直接访问
      else {
        context = getContext(_getKey(url));
      }
      if (context != null) {
        Scrollable.ensureVisible(context);
      }
    }
  }
}

String _getKey(String key) {
  String $key = key;
  if (key.startsWith('#') == false) {
    $key = '#$key';
  }
  return $key;
}
