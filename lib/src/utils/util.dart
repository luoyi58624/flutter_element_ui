import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ElUtil {
  ElUtil._();

  /// 刷新整个应用，效果相当于热更新
  static void refreshApp() {
    WidgetsBinding.instance.reassembleApplication();
  }

  /// 添加下一帧执行的回调函数，它会在 build 完成后执行
  static void nextTick(VoidCallback fun) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fun();
    });
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
}
