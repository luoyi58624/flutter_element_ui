import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_element_ui/src/global.dart';

class ElUtils {
  ElUtils._();

  /// loading 加载光标
  static MouseCursor get loadingCursor {
    if (kIsWeb) return SystemMouseCursors.wait;
    if (ElPlatformUtil.isMacOS) {
      return SystemMouseCursors.forbidden;
    } else {
      return SystemMouseCursors.wait;
    }
  }

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

  /// 计算限制后的元素尺寸，返回类似于自适应大小的图片尺寸
  static SizeModel calcConstraintsSize(
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
    return SizeModel(newWidth, newHeight);
  }
}
