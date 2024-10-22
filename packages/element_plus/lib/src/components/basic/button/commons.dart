part of 'index.dart';

/// 按钮最小宽度
const double _minWidth = 64;

/// 按钮 background、border 禁用透明度
const double _disabledOpacity = 0.6;

/// 按钮 text 禁用透明度
const double _textDisabledOpacity = 0.36;

/// 主题按钮 text 禁用透明度
const double _themeButtonTextDisabledOpacity = 0.85;

/// 按钮动画持续时间，默认 100 毫秒
const _duration = Duration(milliseconds: 100);

/// 按钮默认文本样式
const _defaultTextStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.w500);

/// 按钮组悬停退出延迟器
Timer? _buttonGroupHoverExitTimer;

extension _ButtonColorExtension on Color {
  /// hover 悬停颜色，颜色会变得更浅
  Color hover(BuildContext context) => elLight3(context);

  /// tap 按下颜色，颜色会变得更深
  Color tap(BuildContext context) => elLight3(context, reverse: true);

  /// 应用主题透明背景颜色
  Color themeLightBg(BuildContext context) => elLight9(context);

  /// 应用主题透明边框颜色
  Color themeLightBorder(BuildContext context) => elLight6(context);
}

/// 计算按钮颜色样式
typedef _ColorStyle = ({
  Color? bgColor,
  Color? textColor,
  Color? borderColor,
  Color? loadingTextColor
});

/// 按钮最终的 prop 配置
class _ButtonProp {
  final dynamic child;
  final double? width;
  final double height;
  final Color? bgColor;
  final Color? color;
  final String? type;
  final bool text;
  final bool bg;
  final bool link;
  final bool plain;
  final bool round;
  final bool block;
  final ElBorderBuilder borderBuilder;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry? padding;
  final double iconSize;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final bool circle;
  final bool disabled;
  final bool loading;
  final Widget loadingWidget;
  final Widget Function(ElButtonLoadingState state)? loadingBuilder;

  _ButtonProp({
    required this.child,
    required this.width,
    required this.height,
    required this.bgColor,
    required this.color,
    required this.type,
    required this.text,
    required this.bg,
    required this.link,
    required this.plain,
    required this.round,
    required this.block,
    required this.borderBuilder,
    required this.borderRadius,
    required this.padding,
    required this.iconSize,
    required this.leftIcon,
    required this.rightIcon,
    required this.circle,
    required this.disabled,
    required this.loading,
    required this.loadingWidget,
    required this.loadingBuilder,
  });

  /// 通过工厂函数创建按钮最终 prop 配置
  factory _ButtonProp.create(
    BuildContext context,
    ElButton widget,
    bool hasGroup,
  ) {
    final $data = ElButtonTheme.of(context);
    late final double $height;
    late final Color? $bgColor;
    late final String? $type;
    late final bool $text;
    late final bool $bg;
    late final bool $circle;
    late final bool $link;
    late final bool $plain;
    late final bool $round;
    final bool $block = widget.block ?? $data.block ?? false;
    final $loading = widget.loading ?? $data.loading ?? false;
    final $disabled = (widget.disabled ?? $data.disabled ?? false) || $loading;

    if (hasGroup) {
      $height = $data.height ?? context.elConfig.size;
      $bgColor = $data.bgColor;
      $type = $data.type;
      $text = $data.text ?? false;
      $bg = $data.bg ?? false;
      $circle = false;
      $link = false;
      $plain = $data.plain ?? false;
      $round = $data.round ?? false;
    } else {
      $height = widget.height ?? $data.height ?? context.elConfig.size;
      $bgColor = widget.bgColor ?? $data.bgColor;
      $type = widget.type ?? $data.type;
      $circle = widget.circle ?? $data.circle ?? false;
      $text = widget.text ?? $data.text ?? false;
      $bg = widget.bg ?? $data.bg ?? false;
      $link = widget.link ?? $data.link ?? false;
      $plain = widget.plain ?? $data.plain ?? false;
      $round = widget.round ?? $data.round ?? false;
    }

    final $horizontalPadding = $height / 2;
    final $padding = $circle || $link
        ? null
        : (widget.padding ??
            $data.padding ??
            EdgeInsets.symmetric(horizontal: $horizontalPadding));
    final $borderRadius = $round || $circle
        ? BorderRadius.circular($height / 2)
        : widget.borderRadius ?? $data.borderRadius ?? context.elConfig.radius;

    return _ButtonProp(
      child: widget.child ?? $data.child,
      width: widget.width ?? $data.width,
      height: $height,
      bgColor: $bgColor,
      color: widget.color ?? $data.color,
      type: $type,
      text: $text,
      bg: $bg,
      link: $link,
      plain: $plain,
      round: $round,
      block: $block,
      borderBuilder:
          widget.borderBuilder ?? $data.borderBuilder ?? _borderBuilder,
      borderRadius: $borderRadius,
      padding: $padding,
      iconSize: widget.iconSize ?? $data.iconSize ?? $height / 2 - 2,
      leftIcon: widget.leftIcon ?? $data.leftIcon,
      rightIcon: widget.rightIcon ?? $data.rightIcon,
      circle: $circle,
      disabled: $disabled,
      loading: $loading,
      loadingWidget: widget.loadingWidget ??
          $data.loadingWidget ??
          const ElLoading(ElIcons.loading),
      loadingBuilder: widget.loadingBuilder ?? $data.loadingBuilder,
    );
  }
}

ElBorderBuilder _borderBuilder =
    (color) => Border.all(width: 1.0, color: color);

class _ElButtonGroupInheritedWidget extends InheritedWidget {
  const _ElButtonGroupInheritedWidget({
    required this.modelValue,
    required this.axis,
    required this.hoverIndex,
    required this.borderColor,
    required this.onChanged,
    required super.child,
  });

  final dynamic modelValue;
  final Axis axis;
  final Obs<int> hoverIndex;
  final Obs<Color?> borderColor;
  final ValueChanged onChanged;

  static _ElButtonGroupInheritedWidget? maybeOf(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<_ElButtonGroupInheritedWidget>();

  @override
  bool updateShouldNotify(_ElButtonGroupInheritedWidget oldWidget) => true;
}

class _ButtonStyleUtil {
  /// 计算按钮颜色样式
  static _ColorStyle _calcColorStyle(
    BuildContext context, {
    required _ButtonProp prop,
    required bool isHover,
    required bool isTap,
  }) {
    if (prop.loadingBuilder != null && prop.loading) {
      return loadingStyle(
        context,
        type: prop.type,
        bgColor: prop.bgColor,
        link: prop.link,
        text: prop.text,
        plain: prop.plain,
      );
    } else {
      if (prop.link) {
        return linkStyle(
          context,
          type: prop.type,
          disabled: prop.disabled,
          isHover: isHover,
          isTap: isTap,
        );
      } else if (prop.text) {
        return textStyle(
          context,
          type: prop.type,
          bgColor: prop.bgColor,
          bg: prop.bg,
          disabled: prop.disabled,
          isHover: isHover,
          isTap: isTap,
        );
      } else {
        if (prop.type == null && prop.bgColor == null) {
          return defaultStyle(
            context,
            disabled: prop.disabled,
            isHover: isHover,
            isTap: isTap,
          );
        } else {
          if (prop.plain) {
            return plainStyle(
              context,
              type: prop.type,
              bgColor: prop.bgColor,
              disabled: prop.disabled,
              isHover: isHover,
              isTap: isTap,
            );
          } else {
            return themeStyle(
              context,
              type: prop.type,
              bgColor: prop.bgColor,
              disabled: prop.disabled,
              isHover: isHover,
              isTap: isTap,
            );
          }
        }
      }
    }
  }

  static _ColorStyle defaultStyle(
    BuildContext context, {
    required bool disabled,
    bool isHover = false,
    bool isTap = false,
  }) {
    final $elTheme = context.elTheme;
    final $defaultBorderColor = $elTheme.borderColor;

    var $bgColor = isTap || isHover
        ? $elTheme.primary.themeLightBg(context)
        : $elTheme.bgColor;

    var $textColor =
        isTap || isHover ? $elTheme.primary : $elTheme.regularTextColor;
    if (disabled) {
      $textColor = $textColor.withOpacity(_textDisabledOpacity);
    }

    var $borderColor = isTap
        ? $elTheme.primary
        : isHover
            ? $elTheme.primary.themeLightBorder(context)
            : $defaultBorderColor;

    if (disabled) {
      $borderColor = $borderColor.withOpacity(_disabledOpacity);
    }

    return (
      bgColor: $bgColor,
      textColor: $textColor,
      borderColor: $borderColor,
      loadingTextColor: null,
    );
  }

  static _ColorStyle themeStyle(
    BuildContext context, {
    required String? type,
    required Color? bgColor,
    required bool disabled,
    bool isHover = false,
    bool isTap = false,
  }) {
    final $themeColor = bgColor ?? context.elThemeColors[type]!;

    var $bgColor = isTap
        ? $themeColor.tap(context)
        : isHover
            ? $themeColor.hover(context)
            : $themeColor;

    var $textColor = $themeColor.elTextColor(context);
    if (disabled) {
      $bgColor = $bgColor.withOpacity(_disabledOpacity);
      $textColor = $textColor.withOpacity(_themeButtonTextDisabledOpacity);
    }

    return (
      bgColor: $bgColor,
      textColor: $textColor,
      borderColor: null,
      loadingTextColor: null,
    );
  }

  static _ColorStyle plainStyle(
    BuildContext context, {
    required String? type,
    required Color? bgColor,
    required bool disabled,
    bool isHover = false,
    bool isTap = false,
  }) {
    final $themeColor = bgColor ?? context.elThemeColors[type]!;

    var $bgColor = PlatformUtil.isDesktop
        ? (isTap
            ? $themeColor.tap(context)
            : isHover
                ? $themeColor
                : $themeColor.themeLightBg(context))
        : (isTap ? $themeColor : $themeColor.themeLightBg(context));

    var $textColor =
        isTap || isHover ? $themeColor.elTextColor(context) : $themeColor;

    var $borderColor = PlatformUtil.isDesktop
        ? (isTap
            ? $themeColor.tap(context)
            : isHover
                ? $themeColor
                : $themeColor.themeLightBorder(context))
        : (isTap ? $themeColor : $themeColor.themeLightBorder(context));

    if (disabled) {
      $bgColor = $bgColor.withOpacity(_disabledOpacity);
      $textColor = $textColor.withOpacity(_textDisabledOpacity);
      $borderColor = $borderColor.withOpacity(_disabledOpacity);
    }

    return (
      bgColor: $bgColor,
      textColor: $textColor,
      borderColor: $borderColor,
      loadingTextColor: null,
    );
  }

  static _ColorStyle textStyle(
    BuildContext context, {
    required String? type,
    required Color? bgColor,
    required bool bg,
    required bool disabled,
    bool isHover = false,
    bool isTap = false,
  }) {
    final $elTheme = context.elTheme;

    final pageBgColor = $elTheme.bgColor;
    Color? $bgColor;
    if (bg) {
      $bgColor = pageBgColor
          .deepen(4)
          .on(isHover, color: pageBgColor.deepen(10))
          .on(isTap, color: pageBgColor.deepen(16));
    } else {
      if (isTap) {
        $bgColor = pageBgColor.deepen(10);
      } else if (isHover) {
        $bgColor = pageBgColor.deepen(4);
      }
    }
    var $textColor = type == null && bgColor == null
        ? $elTheme.regularTextColor
        : context.elThemeColors[type]!;
    if (disabled) {
      $textColor = $textColor.withOpacity(_textDisabledOpacity);
    }

    return (
      bgColor: $bgColor,
      textColor: $textColor,
      borderColor: null,
      loadingTextColor: null,
    );
  }

  static _ColorStyle linkStyle(
    BuildContext context, {
    required String? type,
    required bool disabled,
    bool isHover = false,
    bool isTap = false,
  }) {
    final $elTheme = context.elTheme;

    var $textColor = (type == null
        ? $elTheme.regularTextColor
        : context.elThemeColors[type]!);
    $textColor = $textColor
        .on(isHover, color: $textColor.withOpacity(_disabledOpacity))
        .on(isTap, color: $textColor.tap(context));
    if (disabled) {
      $textColor = $textColor.withOpacity(_textDisabledOpacity);
    }

    return (
      bgColor: null,
      textColor: $textColor,
      borderColor: null,
      loadingTextColor: null,
    );
  }

  static _ColorStyle loadingStyle(
    BuildContext context, {
    required String? type,
    required Color? bgColor,
    required bool link,
    required bool text,
    required bool plain,
  }) {
    final $elTheme = context.elTheme;
    final $isDark = context.isDark;

    Color? $loadingTextColor;
    Color? $bgColor;
    Color? $borderColor;

    if (link || text) {
      $loadingTextColor = type == null && bgColor == null
          ? $elTheme.regularTextColor
          : context.elThemeColors[type]!;
    } else {
      $bgColor = $isDark
          ? const Color.fromRGBO(57, 57, 57, 1.0)
          : const Color.fromRGBO(224, 224, 224, 1.0);
      $loadingTextColor = $isDark
          ? const Color.fromRGBO(118, 118, 118, 1.0)
          : const Color.fromRGBO(166, 166, 166, 1.0);
      if ((type == null && bgColor == null) || plain) {
        $borderColor = $isDark
            ? const Color.fromRGBO(57, 57, 57, 1.0)
            : const Color.fromRGBO(224, 224, 224, 1.0);
      }
    }

    return (
      bgColor: $bgColor,
      textColor: null,
      borderColor: $borderColor,
      loadingTextColor: $loadingTextColor,
    );
  }
}

class _ButtonGroupUtil {
  static bool isSelected(dynamic modelValue, int index) {
    // 如果是按钮组，则将选中的值作为悬停状态
    if (modelValue != null) {
      if (modelValue is List) {
        if (modelValue.contains(index)) {
          return true;
        }
      } else if (modelValue == index) {
        return true;
      }
    }

    return false;
  }
}
