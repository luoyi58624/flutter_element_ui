import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_element_annotation/component.dart';
import 'package:flutter_element_ui/src/extension.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import '../../../builders/hover.dart';
import '../../../builders/tap.dart';
import '../../../styles/basic/button.dart';
import '../../../styles/basic/icon.dart';
import '../../../styles/basic/text.dart';
import '../icon/icon.dart';
import '../text.dart';

part 'hook.dart';

@ElComponent.all()
class ElButton extends HookWidget {
  const ElButton(
    this.child, {
    super.key,
    this.style,
    this.onPressed,
  });

  /// 支持任意类型子组件：
  /// * 如果是基础类型，则自动渲染为[Text]
  /// * 如果是[Widget]，则直接渲染
  final dynamic child;

  /// 按钮样式
  final ElButtonStyle? style;

  /// 点击事件
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final $style = ElButtonImportantTheme._merge(
      context,
      context.elConfig.buttonStyle.merge(
        ElButtonTheme._merge(context, style),
      ),
    );
    final currentWidget = SelectionContainer.disabled(
      child: ElHoverBuilder(
        disabled: $style.disabled!,
        builder: (isHover) => ElTapBuilder(
          onTap: onPressed,
          disabled: $style.disabled!,
          builder: (isTap) => _Button(child, style: $style),
        ),
      ),
    );
    return $style.block! && $style.circle == false
        ? SizedBox(width: double.maxFinite, child: currentWidget)
        : UnconstrainedBox(child: currentWidget);
  }
}

class _Button extends ElButton {
  const _Button(super.child, {super.style});

  /// child类型为基础类型
  bool get isBaseType => child == null || DartUtil.isBaseType(child);

  @override
  Widget build(BuildContext context) {
    final buttonStyle = _useButtonStyle(context, style!);
    final buttonHeight = style!.height!;
    final isCircle = style!.circle == true;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      width: isCircle ? buttonHeight : null,
      height: buttonHeight,
      alignment: Alignment.center,
      padding: isCircle ? null : style!.padding ?? EdgeInsets.symmetric(horizontal: buttonHeight / 2),
      decoration: BoxDecoration(
        color: buttonStyle.bgColor,
        border: buttonStyle.border,
        borderRadius: style!.round! || isCircle ? BorderRadius.circular(buttonHeight / 2) : style!.radius,
      ),
      child: buildChild(buttonStyle),
    );
  }

  Widget buildChild(_ElButtonStyle buttonStyle) {
    late Widget childWidget;
    if (child is Widget) {
      if (child is ElIcon) {
        childWidget = ElIconTheme(
          style: ElIconStyle(color: buttonStyle.textColor),
          child: child,
        );
      } else {
        childWidget = child;
      }
    } else {
      childWidget = ElText(
        child,
        style: ElTextStyle(
          textStyle: TextStyle(
            fontWeight: FontWeight.w500,
            color: buttonStyle.textColor,
          ),
          strutStyle: const StrutStyle(
            forceStrutHeight: true,
          ),
        ),
      );
    }
    return childWidget;
  }
}

class ElButtonTheme extends InheritedWidget {
  /// 局部默认样式小部件，你可以用来定义某个小部件的默认样式
  const ElButtonTheme({super.key, required super.child, required this.style});

  final ElButtonStyle style;

  static ElButtonStyle? _merge(BuildContext context, ElButtonStyle? style) {
    var defaultStyle = context.dependOnInheritedWidgetOfExactType<ElButtonTheme>()?.style;
    return defaultStyle == null ? style : defaultStyle.merge(style);
  }

  @override
  bool updateShouldNotify(ElButtonTheme oldWidget) => oldWidget.style != style;
}

class ElButtonImportantTheme extends InheritedWidget {
  /// 强制后代小部件应用的主题样式，效果类似于 CSS !important，但目前很简陋
  const ElButtonImportantTheme({super.key, required super.child, required this.style});

  final ElButtonStyle style;

  static ElButtonStyle _merge(BuildContext context, ElButtonStyle style) =>
      style.merge(context.dependOnInheritedWidgetOfExactType<ElButtonImportantTheme>()?.style);

  @override
  bool updateShouldNotify(ElButtonImportantTheme oldWidget) => oldWidget.style != style;
}
