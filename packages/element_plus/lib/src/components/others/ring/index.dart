import 'package:element_plus/src/global.dart';
import 'package:flutter/material.dart';

part 'theme.dart';

part '../../../generates/components/others/ring/index.g.dart';

/// 在小部件周围绘制轮廓环
class ElRing extends StatefulWidget {
  const ElRing({
    super.key,
    required this.child,
    this.duration,
    this.curve,
    this.show,
    this.offset,
    this.width,
    this.radius,
    this.color,
  });

  /// 子组件
  final Widget child;

  /// 动画持续时间
  final Duration? duration;

  /// 动画曲线
  final Curve? curve;

  /// 是否显示轮廓环，默认 false
  final bool? show;

  /// 轮廓环与子组件的距离，默认 1.0
  final double? offset;

  /// 轮廓环的宽度，默认 1.5
  final double? width;

  /// 轮廓环的圆角值，Element UI 很多组件会通过 [setRingRadius] 方法自动设置轮廓环的圆角
  final BorderRadius? radius;

  /// 轮廓环的颜色
  final Color? color;

  /// 设置轮廓环的样式
  static void setRingStyle(
    BuildContext context, {
    Duration? duration,
    Curve? curve,
    BorderRadius? radius,
    Color? color,
  }) {
    context
        .getInheritedWidgetOfExactType<_RingInheritedWidget>()
        ?.setRingStyle(duration, curve, radius, color);
  }

  @override
  State<ElRing> createState() => _ElRingState();
}

class _ElRingState extends State<ElRing> {
  late ElRingThemeData themeData;
  Duration? _duration;

  Duration get duration => themeData.duration ?? _duration ?? Duration.zero;

  Curve? _curve;

  Curve get curve => themeData.curve ?? _curve ?? Curves.linear;

  BorderRadius? _ringRadius;

  BorderRadius get ringRadius =>
      themeData.radius ?? _ringRadius ?? BorderRadius.circular(4.0);

  Color? _ringColor;

  Color get ringColor =>
      themeData.color ?? _ringColor ?? context.elTheme.primary;

  void setRingStyle(
    Duration? duration,
    Curve? curve,
    BorderRadius? radius,
    Color? color,
  ) {
    _duration = duration;
    _curve = curve;
    _ringColor = color;
    if (radius != null) {
      _ringRadius = BorderRadius.only(
        topLeft: Radius.elliptical(
          calcRingRadius(radius.topLeft.x),
          calcRingRadius(radius.topLeft.y),
        ),
        topRight: Radius.elliptical(
          calcRingRadius(radius.topRight.x),
          calcRingRadius(radius.topRight.y),
        ),
        bottomLeft: Radius.elliptical(
          calcRingRadius(radius.bottomLeft.x),
          calcRingRadius(radius.bottomLeft.y),
        ),
        bottomRight: Radius.elliptical(
          calcRingRadius(radius.bottomRight.x),
          calcRingRadius(radius.bottomRight.y),
        ),
      );
    } else {
      _ringRadius = null;
    }
  }

  double calcRingRadius(double value) {
    if (value <= themeData.offset!) {
      return 0.0;
    } else {
      return value + themeData.offset!;
    }
  }

  @override
  Widget build(BuildContext context) {
    themeData = ElRingTheme.of(context).merge(ElRingThemeData(
      duration: widget.duration,
      curve: widget.curve,
      offset: widget.offset,
      width: widget.width,
      radius: widget.radius,
      color: widget.color,
      show: widget.show,
    ));
    final show = themeData.show!;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        _RingInheritedWidget(
          setRingStyle,
          child: widget.child,
        ),
        _AnimatedRing(
          duration: duration,
          curve: curve,
          position: -(themeData.offset! + themeData.width!),
          opacity: show ? 1.0 : 0.0,
          decoration: BoxDecoration(
            border: Border.all(
              width: show ? themeData.width! : 0.0,
              color: ringColor,
            ),
            borderRadius: ringRadius,
          ),
        ),
      ],
    );
  }
}

class _AnimatedRing extends ImplicitlyAnimatedWidget {
  const _AnimatedRing({
    required super.duration,
    super.curve,
    required this.position,
    required this.opacity,
    required this.decoration,
  });

  final double position;
  final double opacity;
  final BoxDecoration decoration;

  @override
  AnimatedWidgetBaseState<_AnimatedRing> createState() => _AnimatedRingState();
}

class _AnimatedRingState extends AnimatedWidgetBaseState<_AnimatedRing> {
  Tween<double>? _position;
  Tween<double>? _opacity;
  DecorationTween? _decoration;

  @override
  Widget build(BuildContext context) {
    final position = _position!.evaluate(animation);
    return Positioned(
      top: position,
      left: position,
      right: position,
      bottom: position,
      child: IgnorePointer(
        child: Opacity(
          opacity: _opacity!.evaluate(animation),
          child: DecoratedBox(
            decoration: _decoration!.evaluate(animation),
          ),
        ),
      ),
    );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _position = visitor(_position, widget.position,
            (dynamic value) => Tween<double>(begin: value as double))
        as Tween<double>;
    _opacity = visitor(_opacity, widget.opacity,
            (dynamic value) => Tween<double>(begin: value as double))
        as Tween<double>;
    _decoration = visitor(_decoration, widget.decoration,
            (dynamic value) => DecorationTween(begin: value as BoxDecoration))
        as DecorationTween;
  }
}

class _RingInheritedWidget extends InheritedWidget {
  const _RingInheritedWidget(
    this.setRingStyle, {
    required super.child,
  });

  final void Function(
    Duration? duration,
    Curve? curve,
    BorderRadius? value,
    Color? color,
  ) setRingStyle;

  @override
  bool updateShouldNotify(_RingInheritedWidget oldWidget) => false;
}
