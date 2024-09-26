import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_element_ui/src/global.dart';

part 'state.dart';

class ElSwitch extends ElModelValue<bool> {
  const ElSwitch(
    super.modelValue, {
    super.key,
    super.onChanged,
    this.size = 24.0,
    this.width,
    this.gap = 4.0,
    this.activeColor,
    this.color,
    this.activeBgColor,
    this.bgColor,
    this.activeText,
    this.inactiveText,
    this.activeIcon,
    this.inactiveIcon,
    this.disabled = false,
  });

  /// 开关尺寸
  final double size;

  /// 自定义开关宽度，默认为[size]两倍
  final double? width;

  /// 开关与容器之间的间距
  final double gap;

  /// 开关未激活颜色，默认白色
  final Color? color;

  /// 开关未激活背景颜色，默认边框颜色
  final Color? bgColor;

  /// 开关激活颜色，默认白色
  final Color? activeColor;

  /// 开关激活背景颜色，默认主题色
  final Color? activeBgColor;

  /// 开关激活文字（待实现）
  final String? activeText;

  /// 开关未激活文字（待实现）
  final String? inactiveText;

  /// 开关激活图标（待实现）
  final ElIcon? activeIcon;

  /// 开关未激活图标（待实现）
  final ElIcon? inactiveIcon;

  /// 是否禁用
  final bool disabled;

  @override
  State<ElSwitch> createState() => _ElSwitchState();
}

