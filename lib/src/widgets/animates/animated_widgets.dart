import 'package:flutter/material.dart';

/// 动画装饰器盒子
class ElAnimatedDecoratedBox extends ImplicitlyAnimatedWidget {
  const ElAnimatedDecoratedBox({
    super.key,
    required super.duration,
    super.curve,
    super.onEnd,
    required this.decoration,
    this.child,
  });

  final BoxDecoration decoration;
  final Widget? child;

  @override
  AnimatedWidgetBaseState<ElAnimatedDecoratedBox> createState() =>
      _ElAnimatedDecoratedBoxState();
}

class _ElAnimatedDecoratedBoxState
    extends AnimatedWidgetBaseState<ElAnimatedDecoratedBox> {
  DecorationTween? _decoration;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: _decoration!.evaluate(animation),
      child: widget.child,
    );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _decoration = visitor(_decoration, widget.decoration,
            (dynamic value) => DecorationTween(begin: value as BoxDecoration))
        as DecorationTween;
  }
}

/// 动画颜色盒子
class ElAnimatedColoredBox extends ImplicitlyAnimatedWidget {
  const ElAnimatedColoredBox({
    super.key,
    required super.duration,
    super.curve,
    super.onEnd,
    required this.color,
    this.child,
  });

  final Color color;
  final Widget? child;

  @override
  AnimatedWidgetBaseState<ElAnimatedColoredBox> createState() =>
      _ElAnimatedColoredBoxState();
}

class _ElAnimatedColoredBoxState
    extends AnimatedWidgetBaseState<ElAnimatedColoredBox> {
  ColorTween? _color;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: _color!.evaluate(animation)!,
      child: widget.child,
    );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _color = visitor(_color, widget.color,
        (dynamic value) => ColorTween(begin: value as Color)) as ColorTween;
  }
}

/// 动画刷新指示器
class ElAnimatedRefreshProgressIndicator extends ImplicitlyAnimatedWidget {
  const ElAnimatedRefreshProgressIndicator({
    super.key,
    required super.duration,
    super.curve,
    super.onEnd,
    this.value,
    this.color,
    this.backgroundColor,
    this.valueColor,
    this.strokeWidth = 2.5,
    this.strokeAlign = 0.0,
    this.strokeCap,
    this.semanticsLabel,
    this.semanticsValue,
    this.elevation = 2.0,
    this.indicatorMargin = const EdgeInsets.all(4.0),
    this.indicatorPadding = const EdgeInsets.all(12.0),
  });

  final double? value;
  final Color? color;
  final Color? backgroundColor;
  final Animation<Color?>? valueColor;
  final double strokeWidth;
  final double strokeAlign;
  final StrokeCap? strokeCap;
  final String? semanticsLabel;
  final String? semanticsValue;
  final double elevation;
  final EdgeInsetsGeometry indicatorMargin;
  final EdgeInsetsGeometry indicatorPadding;

  @override
  AnimatedWidgetBaseState<ElAnimatedRefreshProgressIndicator> createState() =>
      _ElAnimatedRefreshProgressIndicatorState();
}

class _ElAnimatedRefreshProgressIndicatorState
    extends AnimatedWidgetBaseState<ElAnimatedRefreshProgressIndicator> {
  ColorTween? _color;
  ColorTween? _backgroundColor;

  @override
  Widget build(BuildContext context) {
    return RefreshProgressIndicator(
      value: widget.value,
      color: _color?.evaluate(animation),
      backgroundColor: _backgroundColor?.evaluate(animation),
      valueColor: widget.valueColor,
      strokeWidth: widget.strokeWidth,
      strokeAlign: widget.strokeAlign,
      strokeCap: widget.strokeCap,
      semanticsLabel: widget.semanticsLabel,
      semanticsValue: widget.semanticsValue,
      elevation: widget.elevation,
      indicatorMargin: widget.indicatorMargin,
      indicatorPadding: widget.indicatorPadding,
    );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _color = visitor(_color, widget.color,
        (dynamic value) => ColorTween(begin: value as Color)) as ColorTween?;
    _backgroundColor = visitor(_backgroundColor, widget.backgroundColor,
        (dynamic value) => ColorTween(begin: value as Color)) as ColorTween?;
  }
}
