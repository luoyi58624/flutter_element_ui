import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_element_annotation/flutter_element_annotation.dart';

import '../../components/basic/link/link.dart';

part '../../generates/styles/basic/link.g.dart';

const Color hrefColor = Color.fromRGBO(9, 105, 218, 1);

@ElModel.copy()
class ElLinkStyle {
  const ElLinkStyle({
    this.cursor = SystemMouseCursors.click,
    this.color = hrefColor,
    this.activeColor = hrefColor,
    this.decoration = ElLinkDecoration.none,
    this.target = ElLinkTarget.blank,
    this.enabledPreview,
    this.enableFeedback,
  });

  /// 自定义光标样式，默认点击
  final MouseCursor cursor;

  /// 默认的超链接文本颜色
  final Color color;

  /// 激活的超链接文本颜色
  final Color activeColor;

  /// 超链接下划线显示逻辑
  final ElLinkDecoration decoration;

  /// 打开链接的目标位置，默认 blank，如果是客户端，它一律直接打开浏览器
  final ElLinkTarget target;

  /// 是否开启超链接地址预览，显示策略如下：
  /// 1. 如果链接地址是http，那么将强制显示地址预览
  /// 2. 如果链接地址是应用路由地址，默认情况下，在 web 平台将自动拼接地址前缀，客户端则不显示地址
  /// 3. 如果此变量为 true，那么客户端将显示路由地址，如果此变量为 false，那么 web 平台将不显示路由地址
  final bool? enabledPreview;

  /// 是否开启触觉回馈，默认跟随全局
  final bool? enableFeedback;
}
