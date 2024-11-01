import 'dart:convert';

import 'package:archive/archive.dart';
import 'package:element_dart/element_dart.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:crypto/crypto.dart' as crypto;

class ElUtil {
  ElUtil._();

  static final Codec<String, String> _base64Codec = utf8.fuse(base64);

  /// 判断一个变量是否为空，例如：null、''、[]、{}
  ///
  /// checkNum - 若为true，则判断数字是否为0
  /// checkString - 若为true，则判断字符串是否为 'null'
  static bool isEmpty(
    dynamic value, {
    bool? checkNum,
    bool? checkString,
  }) {
    if (null == value) {
      return true;
    } else if (value is String) {
      var str = value.trim();
      if (checkString == true) {
        return str.isEmpty || str == 'null';
      } else {
        return str.isEmpty;
      }
    } else if (checkNum == true && value is num) {
      return value == 0;
    } else if (value is List) {
      return value.isEmpty;
    } else if (value is Map) {
      return value.isEmpty;
    } else if (value is Object) {
      return value == {};
    } else {
      return false;
    }
  }

  /// 判断变量是否是基本数据类型
  static bool isBaseType(dynamic value) {
    return (value is num || value is String || value is bool);
  }

  /// 将动态类型转换成实际基础类型：String、int、double、num、bool，如果
  /// * strict 如果为true，对于非基础类型将一律返回null
  static dynamic dynamicToBaseType(dynamic value, [bool? strict]) {
    String type = value.runtimeType.toString();
    if (type == 'String') {
      dynamic v = int.tryParse(value);
      if (v != null) return v;
      v = double.tryParse(value);
      if (v != null) return v;
      v = bool.tryParse(value);
      if (v != null) return v;
      return value;
    }
    if (type == 'int') return value;
    if (type == 'double') return value;
    if (type == 'bool') return value;
    if (type == 'num') return value;
    return strict == true ? null : value;
  }

  /// 安全解析String，如果传递的value为空，则返回一个默认值
  static String safeString(dynamic value, [String defaultValue = '']) {
    if (isEmpty(value)) {
      return defaultValue;
    } else {
      return value.toString();
    }
  }

  /// 判断字符串是否是 http 链接
  static bool isHttp(String url) => url.startsWith('http');

  /// 刷新整个应用，其效果相当于热重载
  static void refreshApp() {
    WidgetsBinding.instance.reassembleApplication.throttle(50)();
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

  /// 使用md5加密字符串
  static String md5(String str) =>
      crypto.md5.convert(utf8.encode(str)).toString();

  /// 字符串转base64
  static String toBase64(String str) => _base64Codec.encode(str);

  /// base64转字符串
  static String formBase64(String base64Str) => _base64Codec.decode(base64Str);

  /// 将字符串编码压缩
  static String encodeString(String str) {
    List<int> stringBytes = utf8.encode(str);
    List<int> gzipBytes = GZipEncoder().encode(stringBytes)!;
    return base64UrlEncode(gzipBytes);
  }

  /// 将字符串编码压缩
  static String decodeString(String str) {
    List<int> stringBytes = base64Url.decode(str);
    List<int> gzipBytes = GZipDecoder().decodeBytes(stringBytes);
    return utf8.decode(gzipBytes);
  }

  /// 给定一个包含任意类型的变量数组，判断内部变量是否仅有一个元素不为null
  /// * allowAllNull 允许所有变量均为null
  static bool onlyOneNotNull(
    List values, {
    bool allowAllNull = false,
  }) {
    final l = values.where((e) => e != null).length;
    return allowAllNull ? l == 0 || l == 1 : l == 1;
  }
}
