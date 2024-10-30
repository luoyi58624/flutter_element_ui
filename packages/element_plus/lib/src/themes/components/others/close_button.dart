import 'package:element_plus/src/global.dart';
import 'package:flutter/material.dart';

part '../../../generates/themes/components/others/close_button.g.dart';

@ElModel.copy()
@ElThemeModel(desc: '关闭按钮默认样式', generateAnimatedThemeWidget: true)
class ElCloseButtonThemeData {
  static const theme = ElCloseButtonThemeData();
  static const darkTheme = ElCloseButtonThemeData();

  const ElCloseButtonThemeData({
    this.iconHoverColor,
    this.bgHoverColor,
    this.cursor,
  });

  /// 图标悬停颜色
  final Color? iconHoverColor;

  /// 按钮悬停背景颜色
  final Color? bgHoverColor;

  /// 鼠标悬停光标样式
  final MouseCursor? cursor;
}
