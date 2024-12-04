import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class FlutterUtil {
  FlutterUtil._();

  /// 刷新整个应用，其效果相当于热重载
  static void refreshApp() {
    throttle(WidgetsBinding.instance.reassembleApplication, 50)();
  }

  /// 隐藏手机软键盘但保留焦点
  static Future<void> hideKeyboard() async {
    await SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  /// 显示手机软键盘
  static Future<void> showKeyboard() async {
    await SystemChannels.textInput.invokeMethod('TextInput.show');
  }

  /// 隐藏手机软键盘并失去焦点
  static Future<void> unFocus() async {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  /// 通过当前context，获取目标祖先元素
  static Element? getAncestorElement<T>(BuildContext context) {
    Element? element;
    context.visitAncestorElements((e) {
      if (e.widget is T) {
        element = e;
        return false;
      }
      return true;
    });
    return element;
  }

  /// 通过当前context，检查是否包含某个祖先widget
  static bool hasAncestorElement<T>(BuildContext context) {
    return getAncestorElement<T>(context) != null;
  }

  /// 计算限制后的元素尺寸，返回类似于自适应大小的图片尺寸
  static Size calcConstraintsSize(
    double width,
    double height,
    double maxWidth,
    double maxHeight,
  ) {
    late double newWidth;
    late double newHeight;
    if (width > height) {
      if (width > maxWidth) {
        newWidth = maxWidth;
        double aspect = maxWidth / width;
        newHeight = (height * aspect).ceilToDouble();
      } else {
        newWidth = width;
        newHeight = height;
      }
    } else {
      if (height > maxHeight) {
        newHeight = maxHeight;
        double aspect = maxHeight / height;
        newWidth = (width * aspect).ceilToDouble();
      } else {
        newWidth = width;
        newHeight = height;
      }
    }
    return Size(newWidth, newHeight);
  }

  static final List<String> _throttleKeyList = [];

  /// 创建一个节流函数，忽略指定时间内的多次调用
  /// * wait 节流时间(毫秒)
  /// * key 如果是匿名函数，请添加一个标识符，否则无法识别是否是同一个函数执行
  static dynamic throttle(
    Function fun,
    int wait, {
    String? key,
  }) {
    assert(wait > 0);
    key ??= fun.hashCode.toString();

    return () {
      if (_throttleKeyList.contains(key)) return;
      fun();
      _throttleKeyList.add(key!);
      Timer(Duration(milliseconds: wait), () {
        _throttleKeyList.remove(key);
      });
    };
  }

  static final Map<String, Timer> _debounceTimerMap = {};

  /// 创建一个防抖函数，如果在指定时间内多次执行函数，那么会忽略掉它，并重置等待时间，当等待时间结束后再执行函数
  /// * wait 防抖时间(毫秒)
  /// * key 如果是匿名函数，请添加一个标识符，否则无法识别是否是同一个函数执行
  static dynamic debounce(
    Function fun,
    int wait, {
    String? key,
  }) {
    assert(wait > 0);
    key ??= fun.hashCode.toString();
    return () {
      if (_debounceTimerMap.containsKey(key)) {
        _debounceTimerMap[key!]!.cancel();
        _debounceTimerMap[key] = Timer(Duration(milliseconds: wait), () {
          fun();
          _debounceTimerMap.remove(key);
        });
        return;
      } else {
        _debounceTimerMap[key!] = Timer(Duration(milliseconds: wait), () {
          fun();
          _debounceTimerMap.remove(key);
        });
      }
    };
  }
}
