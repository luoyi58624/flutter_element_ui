import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_element_ui/src/extensions/element.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import '../../widgets/model_value.dart';
import '../basic/icon.dart';

class ElSwitch extends ElModelValue<bool> {
  const ElSwitch(
    super.modelValue, {
    super.key,
    super.onChanged,
    this.size = 20.0,
    this.width,
    this.gap = 4.0,
    this.activeColor,
    this.inactiveColor,
    this.activeBgColor,
    this.inactiveBgColor,
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

  /// 开关激活颜色，默认白色
  final Color? activeColor;

  /// 开关未激活颜色，默认白色
  final Color? inactiveColor;

  /// 开关激活背景颜色，默认主题色
  final Color? activeBgColor;

  /// 开关未激活背景颜色，默认边框颜色
  final Color? inactiveBgColor;

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

class _ElSwitchState extends ElModelValueState<ElSwitch, bool>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late Animation<double> animation;
  bool _isInitial = true;

  double get containerHeight => widget.size + widget.gap;

  double get containerWidth => widget.width ?? containerHeight * 2;

  double get disabledOpacity => widget.disabled ? 0.5 : 1.0;

  Color get activeColor => widget.activeColor ?? Colors.white;

  Color get inactiveColor => widget.inactiveColor ?? Colors.white;

  Color get activeBgColor => (widget.activeBgColor ?? context.elTheme.primary)
      .withOpacity(disabledOpacity);

  Color get inactiveBgColor =>
      (widget.inactiveBgColor ?? context.elTheme.borderColor)
          .withOpacity(disabledOpacity);

  @override
  String get componentName => 'ElSwitch';

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      value: modelValue ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 200),
    );
    final offset = containerWidth / 2 - containerHeight / 2;
    animation = Tween(begin: -offset, end: offset).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget builder(BuildContext context, bool value) {
    if (_isInitial) {
      _isInitial = false;
    } else {
      value ? controller.forward() : controller.reverse();
      HapticFeedback.mediumImpact();
    }
    return GestureDetector(
      onTap: widget.disabled ? null : () => modelValue = !value,
      child: HoverBuilder(
        disabled: widget.disabled,
        cursor: SystemMouseCursors.click,
        builder: (context) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: containerHeight,
            width: containerWidth,
            decoration: BoxDecoration(
              color: value ? activeBgColor : inactiveBgColor,
              borderRadius: BorderRadius.circular(containerHeight / 2),
            ),
            child: AnimatedBuilder(
              animation: animation,
              builder: (context, child) => Transform.translate(
                offset: Offset(animation.value, 0),
                child: UnconstrainedBox(
                  child: Container(
                    width: widget.size,
                    height: widget.size,
                    decoration: BoxDecoration(
                      color: value ? activeColor : inactiveColor,
                      borderRadius: BorderRadius.circular(widget.size / 2),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
