import 'package:flutter/widgets.dart';
import 'package:flutter_element_annotation/flutter_element_annotation.dart';
import '../../services/message.dart';

part '../../generates/styles/navigation/navigation_menu.g.dart';

@ElModel.copy()
class ElNavigationMenuStyle {
  const ElNavigationMenuStyle({
    required this.activeTextColor,
  });

  /// 菜单激活文字颜色
  final Color activeTextColor;
}
