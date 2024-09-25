import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_element_annotation/flutter_element_annotation.dart';

import '../../components/basic/link/link.dart';

part '../../generates/styles/basic/link.g.dart';

@ElModel.copy()
class ElLinkThemeData {
  static const Color hrefColor = Color.fromRGBO(9, 105, 218, 1.0);
  static const Color darkHrefColor = Color.fromRGBO(64, 158, 255, 1.0);

  const ElLinkThemeData({
    required this.color,
    required this.activeColor,
    this.decoration = ElLinkDecoration.none,
    this.allowDrag = true,
  });

  /// 默认的超链接文本颜色
  final Color color;

  /// 激活的超链接文本颜色
  final Color activeColor;

  /// 超链接下划线显示逻辑
  final ElLinkDecoration decoration;

  /// 是否允许拖拽超链接（仅限 web 平台）
  final bool allowDrag;
}
