import 'package:element_plus/src/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

part 'theme.dart';

part '../../../generates/components/others/ring/index.g.dart';

/// 在小部件周围绘制轮廓环，轮廓环不会占用空间
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
  late ElRingThemeData ringThemeData;
  late final ringDuration = Obs<Duration?>(null);
  late final ringCurve = Obs<Curve?>(null);
  late final ringRadius = Obs<BorderRadius?>(null);
  late final ringColor = Obs<Color?>(null);

  void setRingStyle(
    Duration? duration,
    Curve? curve,
    BorderRadius? radius,
    Color? color,
  ) {
    if (ringThemeData.duration != null) {
      ringDuration.value = ringThemeData.duration;
    } else {
      ringDuration.value = duration;
    }

    if (ringThemeData.curve != null) {
      ringCurve.value = ringThemeData.curve;
    } else {
      ringCurve.value = curve;
    }

    if (ringThemeData.radius != null) {
      ringRadius.value = ringThemeData.radius;
    } else {
      if (radius != null) {
        ringRadius.value = BorderRadius.only(
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
        ringRadius.value = null;
      }
    }

    if (ringThemeData.color != null) {
      ringColor.value = ringThemeData.color;
    } else {
      nextTick(() {
        ringColor.value = color;
      });
    }
  }

  double get ringPosition => -(ringThemeData.offset! + ringThemeData.width!);

  double calcRingRadius(double value) {
    if (value <= ringThemeData.offset!) {
      return 0.0;
    } else {
      return value + ringThemeData.offset!;
    }
  }

  @override
  Widget build(BuildContext context) {
    ringThemeData = ElRingTheme.of(context).merge(ElRingThemeData(
      duration: widget.duration,
      curve: widget.curve,
      offset: widget.offset,
      width: widget.width,
      radius: widget.radius,
      color: widget.color,
      show: widget.show,
    ));
    return Stack(
      clipBehavior: Clip.none,
      children: [
        _RingInheritedWidget(
          setRingStyle,
          child: widget.child,
        ),
        Positioned(
          top: ringPosition,
          left: ringPosition,
          right: ringPosition,
          bottom: ringPosition,
          child: IgnorePointer(
            child: ObsBuilder(builder: (context) {
              if (ringColor.value == null) {
                return const SizedBox();
              } else {
                return AnimatedDecoratedBox(
                  duration: ringDuration.value ?? Duration.zero,
                  curve: ringCurve.value ?? Curves.linear,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: ringThemeData.show! ? ringThemeData.width! : 0.001,
                      color: ringColor.value!,
                      // color: ringThemeData.show!
                      //     ? ringColor.value!
                      //     : context.elTheme.layoutTheme.bgColor!,
                    ),
                    borderRadius:
                        ringRadius.value ?? BorderRadius.circular(2.0),
                  ),
                );
              }
            }),
          ),
        ),
      ],
    );
  }
}

class _RingInheritedWidget extends InheritedWidget {
  const _RingInheritedWidget(
    this.setRingStyle, {
    required super.child,
  });

  final void Function(
          Duration? duration, Curve? curve, BorderRadius? value, Color? color)
      setRingStyle;

  @override
  bool updateShouldNotify(_RingInheritedWidget oldWidget) => false;
}
