import 'package:flutter/widgets.dart';
import 'package:flutter_element_ui/src/extension.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import '../../../builders/hover.dart';
import '../../../builders/tap.dart';
import '../../../theme.dart';
import '../icon/icon.dart';

part 'style.dart';

part 'hook.dart';

class ElButton extends HookWidget {
  const ElButton(
    this.child, {
    super.key,
    this.onClick,
    this.style,
  });

  /// 支持任意类型子组件：
  /// * 如果是基础类型，则自动渲染为[Text]
  /// * 如果是[Widget]，则直接渲染
  final dynamic child;

  /// 点击事件
  final VoidCallback? onClick;

  /// 按钮样式
  final ElButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    final $style = ElButtonImportantTheme._merge(
      context,
      context.elConfig.buttonStyle.merge(
        ElButtonTheme._merge(context, style),
      ),
    );
    final currentWidget = ElHoverBuilder(
      disabled: $style.disabled!,
      builder: (isHover) => ElTapBuilder(
        onTap: onClick,
        disabled: $style.disabled!,
        delay: PlatformUtil.isDesktop ? 0 : 50,
        builder: (isTap) => _Button(child, style: $style),
      ),
    );
    return $style.block!
        ? SizedBox(width: double.maxFinite, child: currentWidget)
        : UnconstrainedBox(child: currentWidget);
  }
}

class _Button extends ElButton {
  const _Button(super.child, {super.style});

  /// 文字按钮
  bool get isTextButton => DartUtil.isBaseType(child);

  /// 纯图标按钮
  bool get isIconButton => child is ElIcon;

  @override
  Widget build(BuildContext context) {
    final buttonStyle = _useButtonStyle(context, style!);
    final buttonHeight = style!.height!;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      height: buttonHeight,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: buttonHeight / 2),
      decoration: BoxDecoration(
        color: buttonStyle.bgColor,
        border: buttonStyle.border,
        borderRadius: style!.radius ?? BorderRadius.circular(style!.round! ? buttonHeight / 2 : 4),
      ),
      child: buildChild(buttonStyle),
    );
  }

  Widget buildChild(_ButtonStyle buttonStyle) {
    if (isTextButton) {
      return Text(
        child,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: buttonStyle.textColor,
        ),
        strutStyle: const StrutStyle(
          forceStrutHeight: true,
        ),
      );
    } else if (isIconButton) {
      if (style!.circle!) {
        return const SizedBox();
      } else {
        return child;
      }
    } else {
      return const SizedBox();
    }
  }
}

class ElButtonTheme extends InheritedWidget {
  /// 局部默认样式小部件
  const ElButtonTheme({
    super.key,
    required super.child,
    required this.style,
  });

  final ElButtonStyle style;

  static ElButtonStyle? _merge(BuildContext context, ElButtonStyle? style) {
    var defaultStyle = context.dependOnInheritedWidgetOfExactType<ElButtonTheme>()?.style;
    return defaultStyle == null ? style : defaultStyle.merge(style);
  }

  @override
  bool updateShouldNotify(ElButtonTheme oldWidget) => true;
}

class ElButtonImportantTheme extends InheritedWidget {
  /// 强制后代应用的主题样式，效果与 CSS !important 类似
  const ElButtonImportantTheme({
    super.key,
    required super.child,
    required this.style,
  });

  final ElButtonStyle style;

  static ElButtonStyle _merge(BuildContext context, ElButtonStyle style) =>
      style.merge(context.dependOnInheritedWidgetOfExactType<ElButtonImportantTheme>()?.style);

  @override
  bool updateShouldNotify(ElButtonImportantTheme oldWidget) => true;
}
