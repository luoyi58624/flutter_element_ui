import 'package:flutter/widgets.dart';
import 'package:flutter_element_ui/src/global.dart';

class ElFont {
  ElFont._();

  /// 普通字重
  static FontWeight get normal => FontUtil.normal;

  static set normal(FontWeight v) => FontUtil.normal = v;

  /// 中等字重
  static FontWeight get medium => FontUtil.medium;

  static set medium(FontWeight v) => FontUtil.medium = v;

  /// 粗体字重
  static FontWeight get bold => FontUtil.bold;

  static set bold(FontWeight v) => FontUtil.bold = v;
}
