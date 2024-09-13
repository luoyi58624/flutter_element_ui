import 'package:flutter/material.dart';
import 'package:flutter_element_annotation/flutter_element_annotation.dart';

part '../generates/styles/color_data.g.dart';

/// Element UI 常规颜色主题配置
@ElModel.copy()
class ElColorData {
  /// 全局背景色
  final Color bg;

  /// 图标默认颜色
  final Color icon;

  /// 默认文本颜色
  final Color text;

  /// 常规文本颜色
  final Color regularText;

  /// 次要文本颜色
  final Color secondaryText;

  /// 占位文本颜色
  final Color placeholderText;

  /// 边框颜色
  final Color border;

  const ElColorData({
    this.bg = const Color(0xfffafafa),
    this.icon = const Color.fromRGBO(96, 98, 102, 1.0),
    this.text = const Color(0xff323232),
    this.regularText = const Color(0xff606266),
    this.secondaryText = const Color(0xff909399),
    this.placeholderText = const Color(0xffA8ABB2),
    this.border = const Color(0xffDCDFE6),
  });

  const ElColorData.dark({
    this.bg = const Color(0xff2b2b2b),
    this.icon = const Color(0xfff6f6f6),
    this.text = const Color(0xfff2f2f2),
    this.regularText = const Color(0xffCFD3DC),
    this.secondaryText = const Color(0xffA3A6AD),
    this.placeholderText = const Color(0xff8D9095),
    this.border = const Color(0xffa3a3a3),
  });
}
