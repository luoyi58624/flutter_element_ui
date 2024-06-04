import 'package:flutter/widgets.dart';
import 'package:flutter_element_ui/src/extension.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import '../../builders/hover.dart';
import '../../builders/tap.dart';
import '../../theme.dart';
import 'icon.dart';
import 'text.dart';

/// 按钮样式
class ElButtonStyle {
  /// 默认按钮样式
  static const ElButtonStyle style = ElButtonStyle(
    height: 36,
    type: null,
    text: false,
    plain: false,
    round: false,
    block: false,
    radius: null,
    rightIcon: null,
    circle: false,
    disabled: false,
  );

  /// 按钮高度，默认36
  final double? height;

  /// 主题类型，默认null
  final ElThemeType? type;

  /// 文字按钮，默认false
  final bool? text;

  /// 镂空按钮，默认false
  final bool? plain;

  /// 圆角按钮，默认false
  final bool? round;

  /// 块级按钮，宽度会充满容器，默认false
  final bool? block;

  /// 自定义按钮圆角，如果[round]为true，则渲染圆角按钮，否则按钮默认圆角为 4 像素
  final BorderRadiusGeometry? radius;

  /// 按钮右图标，默认null
  final ElIcon? rightIcon;

  /// 圆形图标按钮，当child为[ElIcon]时生效，默认false
  final bool? circle;

  /// 禁用按钮，默认false
  final bool? disabled;

  /// 自定义按钮样式，创建的样式会基于默认的[style]进行合并
  const ElButtonStyle({
    this.height,
    this.type,
    this.text,
    this.plain,
    this.round,
    this.block,
    this.radius,
    this.rightIcon,
    this.circle,
    this.disabled,
  });

  ElButtonStyle copyWith({
    double? height,
    ElThemeType? type,
    bool? text,
    bool? plain,
    bool? round,
    bool? block,
    BorderRadiusGeometry? radius,
    ElIcon? rightIcon,
    bool? circle,
    bool? disabled,
  }) {
    return ElButtonStyle(
      height: height ?? this.height,
      type: type ?? this.type,
      text: text ?? this.text,
      plain: plain ?? this.plain,
      round: round ?? this.round,
      block: block ?? this.block,
      radius: radius ?? this.radius,
      rightIcon: rightIcon ?? this.rightIcon,
      circle: circle ?? this.circle,
      disabled: disabled ?? this.disabled,
    );
  }

  /// 合并新的主题配置
  ElButtonStyle merge([ElButtonStyle? style]) {
    if (style == null) return this;
    return copyWith(
      height: style.height,
      type: style.type,
      text: style.text,
      plain: style.plain,
      round: style.round,
      block: style.block,
      radius: style.radius,
      rightIcon: style.rightIcon,
      circle: style.circle,
      disabled: style.disabled,
    );
  }

  @override
  String toString() {
    return 'ElButtonStyle{height: $height, type: $type, text: $text, plain: $plain, round: $round, block: $block, radius: $radius, rightIcon: $rightIcon, circle: $circle, disabled: $disabled}';
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
  /// 强制后代小部件应用的主题样式，效果类似于 CSS !important
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
    final currentWidget = SelectionContainer.disabled(
      child: ElHoverBuilder(
        disabled: $style.disabled!,
        builder: (isHover) => ElTapBuilder(
          onTap: onClick,
          disabled: $style.disabled!,
          delay: PlatformUtil.isDesktop ? 0 : 50,
          builder: (isTap) => _Button(child, style: $style),
        ),
      ),
    );
    return $style.block!
        ? SizedBox(width: double.maxFinite, child: currentWidget)
        : UnconstrainedBox(child: currentWidget);
  }
}

class _Button extends ElButton {
  const _Button(super.child, {super.style});

  /// child类型为基础类型
  bool get isBaseType => DartUtil.isBaseType(child);

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
    if (isBaseType) {
      // return Text(child);
      return ElText(
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

typedef _ButtonStyle = ({Color? bgColor, Color? textColor, Border? border});

/// 计算按钮样式 Hook
_ButtonStyle _useButtonStyle(BuildContext context, ElButtonStyle style) {
  final bgColor = useState<Color?>(null);
  final textColor = useState<Color?>(null);
  final borderColor = useState<Color?>(null);

  final isHover = ElHoverBuilder.of(context);
  final isTap = ElTapBuilder.of(context);
  final $bgColor = context.elTheme.bgColor;

  // 计算文字按钮样式
  if (style.text!) {
    bgColor.value = $bgColor.onHover(isHover, 4).onTap(isTap, 4);
    style.type == null
        ? textColor.value = context.elTheme.textColor
        : textColor.value = context.themeTypeColors[style.type]!;

    if (style.disabled!) {
      textColor.value = textColor.value!.withOpacity(0.6);
    }
  } else {
    // 计算默认按钮样式
    if (style.type == null) {
      final primaryColor = context.elTheme.primary;
      bgColor.value = isHover || isTap ? primaryColor.elThemeLightBg(context) : $bgColor;
      textColor.value = isHover || isTap ? primaryColor : context.elTheme.textColor;
      borderColor.value = isTap
          ? primaryColor
          : isHover
              ? primaryColor.elThemeLightBorder(context)
              : context.elTheme.borderColor;
    }
    // 计算主题按钮样式
    else {
      // 镂空按钮
      if (style.plain!) {
        final primaryColor = context.themeTypeColors[style.type]!;
        textColor.value = isHover || isTap ? context.darkTheme.textColor : primaryColor;
        bgColor.value = PlatformUtil.isDesktop
            ? (isTap
                ? primaryColor.elTap(context)
                : isHover
                    ? primaryColor
                    : primaryColor.elThemeLightBg(context))
            : (isTap ? primaryColor : primaryColor.elThemeLightBg(context));
        borderColor.value = PlatformUtil.isDesktop
            ? (isTap
                ? primaryColor.elTap(context)
                : isHover
                    ? primaryColor
                    : primaryColor.elThemeLightBorder(context))
            : (isTap ? primaryColor : primaryColor.elThemeLightBorder(context));
      }
      // 主题按钮
      else {
        final primaryColor = context.themeTypeColors[style.type]!;
        textColor.value = context.darkTheme.textColor;
        bgColor.value = isTap
            ? primaryColor.elTap(context)
            : isHover
                ? primaryColor.elHover(context)
                : primaryColor;
      }
    }

    // 计算禁用样式
    if (style.disabled!) {
      if (style.type == null) {
        textColor.value = textColor.value!.withOpacity(0.6);
        borderColor.value = borderColor.value!.withOpacity(0.6);
      } else {
        if (style.plain!) {
          bgColor.value = bgColor.value!.withOpacity(0.6);
          textColor.value = textColor.value!.withOpacity(0.6);
          borderColor.value = borderColor.value!.withOpacity(0.6);
        } else {
          bgColor.value = bgColor.value!.withOpacity(0.6);
          textColor.value = textColor.value!.withOpacity(0.9);
        }
      }
    }
  }

  return (
    bgColor: bgColor.value,
    textColor: textColor.value,
    border: borderColor.value != null ? Border.all(color: borderColor.value!) : null
  );
}
