import 'package:element_plus/src/global.dart';
import 'package:flutter/material.dart';

part 'theme.dart';

part '../../../generates/components/others/ring/index.g.dart';

/// 在小部件周围绘制轮廓环，轮廓环不会占据小部件的空间，这个小部件通常用于 focus 焦点样式
class ElRing extends StatefulWidget {
  const ElRing({
    super.key,
    required this.child,
    this.duration,
    this.curve,
    this.show,
    this.width,
    this.offset,
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

  /// 轮廓环的宽度
  final double? width;

  /// 轮廓环与子组件的距离
  final double? offset;

  /// 轮廓环的圆角值，圆角值和目标小部件保持一致就行，ElRing 内部会自动计算出符合视觉的最终圆角
  final BorderRadius? radius;

  /// 轮廓环的颜色，默认主题色
  final Color? color;

  @override
  State<ElRing> createState() => _ElRingState();
}

class _ElRingState extends State<ElRing> {
  late ElRingThemeData themeData;

  Obs<_RingStyle>? ringStyle;
  final LayerLink layerLink = LayerLink();
  OverlayState? overlay;
  OverlayEntry? overlayEntry;

  BorderRadius calcRadius(BorderRadius? radius) {
    if (radius == null) return BorderRadius.zero;

    return BorderRadius.only(
      topLeft: Radius.elliptical(
        calcRadiusValue(radius.topLeft.x),
        calcRadiusValue(radius.topLeft.y),
      ),
      topRight: Radius.elliptical(
        calcRadiusValue(radius.topRight.x),
        calcRadiusValue(radius.topRight.y),
      ),
      bottomLeft: Radius.elliptical(
        calcRadiusValue(radius.bottomLeft.x),
        calcRadiusValue(radius.bottomLeft.y),
      ),
      bottomRight: Radius.elliptical(
        calcRadiusValue(radius.bottomRight.x),
        calcRadiusValue(radius.bottomRight.y),
      ),
    );
  }

  double calcRadiusValue(double value) {
    if (value < themeData.width! + themeData.offset!) {
      return value +
          (themeData.width! + themeData.offset!) *
              (value / (themeData.width! + themeData.offset!));
    } else {
      return value + themeData.width! + themeData.offset!;
    }
  }

  @override
  void initState() {
    super.initState();
    nextTick(() {
      ringStyle = Obs(_RingStyle(
        show: themeData.show ?? false,
        size: context.size!,
        width: themeData.width!,
        offset: themeData.offset! + themeData.width!,
        color: themeData.color ?? context.elTheme.primary,
        borderRadius: calcRadius(themeData.radius),
      ));

      if (overlayEntry == null) {
        overlayEntry = OverlayEntry(builder: (context) {
          return IgnorePointer(
            child: UnconstrainedBox(
              child: ObsBuilder(builder: (context) {
                final style = ringStyle!.value;
                return _AnimatedRing(
                  duration: themeData.duration ?? Duration.zero,
                  curve: themeData.curve ?? Curves.linear,
                  link: layerLink,
                  size: style.size,
                  offset: style.offset,
                  opacity: style.show ? 1.0 : 0.0,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: style.width,
                      color: style.color,
                    ),
                    borderRadius: calcRadius(themeData.radius),
                  ),
                );
              }),
            ),
          );
        });
        overlay!.insert(overlayEntry!);
      }
    });
  }

  @override
  void dispose() {
    if (overlayEntry != null) {
      overlayEntry!.remove();
      overlayEntry = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    overlay ??= Overlay.of(context);
    themeData = ElRingTheme.of(context).merge(ElRingThemeData(
      duration: widget.duration,
      curve: widget.curve,
      offset: widget.offset,
      width: widget.width,
      radius: widget.radius,
      color: widget.color,
      show: widget.show,
    ));
    if (ringStyle != null) {
      bool flag = false;
      final show = themeData.show ?? false;
      final offset = themeData.offset! + themeData.width!;
      final color = themeData.color ?? context.elTheme.primary;
      final borderRadius = calcRadius(themeData.radius);
      final style = ringStyle!.value;
      if (style.show != show) {
        ringStyle!.value.show = show;
        flag = true;
      }
      if (style.width != themeData.width) {
        ringStyle!.value.width = themeData.width!;
        flag = true;
      }
      if (style.offset != offset) {
        ringStyle!.value.offset = offset;
        flag = true;
      }
      if (style.color != color) {
        ringStyle!.value.color = color;
        flag = true;
      }
      if (style.borderRadius != borderRadius) {
        ringStyle!.value.borderRadius = borderRadius;
        flag = true;
      }
      if (flag) {
        nextTick(() {
          ringStyle!.notify();
        });
      }
    }

    return NotificationListener<SizeChangedLayoutNotification>(
      onNotification: (e) {
        nextTick(() {
          ringStyle!.value.size = context.size!;
          ringStyle!.notify();
        });
        return false;
      },
      child: SizeChangedLayoutNotifier(
        child: CompositedTransformTarget(
          link: layerLink,
          child: widget.child,
        ),
      ),
    );
  }
}

class _RingStyle {
  bool show;
  Size size;
  double width;
  double offset;
  Color color;
  BorderRadius borderRadius;

  _RingStyle({
    required this.show,
    required this.size,
    required this.width,
    required this.offset,
    required this.color,
    required this.borderRadius,
  });
}

class _AnimatedRing extends ImplicitlyAnimatedWidget {
  const _AnimatedRing({
    required super.duration,
    super.curve,
    required this.link,
    required this.size,
    required this.offset,
    required this.opacity,
    required this.decoration,
  });

  final LayerLink link;
  final Size size;
  final double offset;
  final double opacity;
  final BoxDecoration decoration;

  @override
  AnimatedWidgetBaseState<_AnimatedRing> createState() => _AnimatedRingState();
}

class _AnimatedRingState extends AnimatedWidgetBaseState<_AnimatedRing> {
  Tween<double>? _offset;
  Tween<double>? _opacity;
  DecorationTween? _decoration;

  @override
  Widget build(BuildContext context) {
    final offset = _offset!.evaluate(animation);
    return CompositedTransformFollower(
      link: widget.link,
      offset: Offset(-offset, -offset),
      child: SizedBox(
        width: widget.size.width + offset * 2,
        height: widget.size.height + offset * 2,
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
    _offset = visitor(_offset, widget.offset,
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
