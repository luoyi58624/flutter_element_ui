// import 'package:element_plus/src/global.dart';
// import 'package:flutter/material.dart';
//
// part 'theme.dart';
//
// part '../../../generates/components/others/ring/index.g.dart';
//
// /// 在小部件周围绘制轮廓环，轮廓环不会占据小部件的空间，这个小部件通常用于 focus 得到焦点样式
// class ElRing extends StatefulWidget {
//   const ElRing({
//     super.key,
//     required this.child,
//     this.duration,
//     this.curve,
//     this.show,
//     this.width,
//     this.offset,
//     this.radius,
//     this.color,
//   });
//
//   /// 子组件
//   final Widget child;
//
//   /// 动画持续时间
//   final Duration? duration;
//
//   /// 动画曲线
//   final Curve? curve;
//
//   /// 是否显示轮廓环，默认 false
//   final bool? show;
//
//   /// 轮廓环的宽度
//   final double? width;
//
//   /// 轮廓环与子组件的距离
//   final double? offset;
//
//   /// 轮廓环的圆角值，圆角值和目标小部件保持一致就行，ElRing 内部会自动计算出符合视觉的最终圆角
//   final BorderRadius? radius;
//
//   /// 轮廓环的颜色，默认主题色
//   final Color? color;
//
//   @override
//   State<ElRing> createState() => _ElRingState();
// }
//
// class _ElRingState extends State<ElRing> {
//   late ElRingThemeData themeData;
//
//   BorderRadius calcRadius(BorderRadius? radius) {
//     if (radius == null) return BorderRadius.zero;
//
//     return BorderRadius.only(
//       topLeft: Radius.elliptical(
//         calcRadiusValue(radius.topLeft.x),
//         calcRadiusValue(radius.topLeft.y),
//       ),
//       topRight: Radius.elliptical(
//         calcRadiusValue(radius.topRight.x),
//         calcRadiusValue(radius.topRight.y),
//       ),
//       bottomLeft: Radius.elliptical(
//         calcRadiusValue(radius.bottomLeft.x),
//         calcRadiusValue(radius.bottomLeft.y),
//       ),
//       bottomRight: Radius.elliptical(
//         calcRadiusValue(radius.bottomRight.x),
//         calcRadiusValue(radius.bottomRight.y),
//       ),
//     );
//   }
//
//   double calcRadiusValue(double value) {
//     if (value < themeData.width! + themeData.offset!) {
//       return value +
//           (themeData.width! + themeData.offset!) *
//               (value / (themeData.width! + themeData.offset!));
//     } else {
//       return value + themeData.width! + themeData.offset!;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     themeData = ElRingTheme.of(context).merge(ElRingThemeData(
//       duration: widget.duration,
//       curve: widget.curve,
//       offset: widget.offset,
//       width: widget.width,
//       radius: widget.radius,
//       color: widget.color,
//       show: widget.show,
//     ));
//     final show = themeData.show ?? false;
//
//     return Stack(
//       clipBehavior: Clip.none,
//       children: [
//         widget.child,
//         _AnimatedRing(
//           duration: themeData.duration ?? Duration.zero,
//           curve: themeData.curve ?? Curves.linear,
//           position: -(themeData.offset! + themeData.width!),
//           opacity: show ? 1.0 : 0.0,
//           decoration: BoxDecoration(
//             border: Border.all(
//               width: themeData.width!,
//               color: themeData.color ?? context.elTheme.primary,
//             ),
//             borderRadius: calcRadius(themeData.radius),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class _AnimatedRing extends ImplicitlyAnimatedWidget {
//   const _AnimatedRing({
//     required super.duration,
//     super.curve,
//     required this.position,
//     required this.opacity,
//     required this.decoration,
//   });
//
//   final double position;
//   final double opacity;
//   final BoxDecoration decoration;
//
//   @override
//   AnimatedWidgetBaseState<_AnimatedRing> createState() => _AnimatedRingState();
// }
//
// class _AnimatedRingState extends AnimatedWidgetBaseState<_AnimatedRing> {
//   Tween<double>? _position;
//   Tween<double>? _opacity;
//   DecorationTween? _decoration;
//
//   @override
//   Widget build(BuildContext context) {
//     final position = _position!.evaluate(animation);
//     return Positioned(
//       top: position,
//       left: position,
//       right: position,
//       bottom: position,
//       child: IgnorePointer(
//         child: Opacity(
//           opacity: _opacity!.evaluate(animation),
//           child: DecoratedBox(
//             decoration: _decoration!.evaluate(animation),
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void forEachTween(TweenVisitor<dynamic> visitor) {
//     _position = visitor(_position, widget.position,
//             (dynamic value) => Tween<double>(begin: value as double))
//         as Tween<double>;
//     _opacity = visitor(_opacity, widget.opacity,
//             (dynamic value) => Tween<double>(begin: value as double))
//         as Tween<double>;
//     _decoration = visitor(_decoration, widget.decoration,
//             (dynamic value) => DecorationTween(begin: value as BoxDecoration))
//         as DecorationTween;
//   }
// }
