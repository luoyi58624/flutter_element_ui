// import 'package:element_plus/src/global.dart';
// import 'package:flutter/material.dart';
//
// part 'render.dart';
//
// part 'theme.dart';
//
// part '../../../generates/components/others/ring/index.g.dart';
//
// /// 在小部件周围绘制轮廓环
// class ElRing extends StatefulWidget {
//   const ElRing({
//     super.key,
//     required this.child,
//     this.duration,
//     this.curve,
//     this.show,
//     this.offset,
//     this.width,
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
//   /// 轮廓环与子组件的距离，默认 1.0
//   final double? offset;
//
//   /// 轮廓环的宽度，默认 1.5
//   final double? width;
//
//   /// 轮廓环的圆角值，Element UI 很多组件会通过 [setRingRadius] 方法自动设置轮廓环的圆角
//   final BorderRadius? radius;
//
//   /// 轮廓环的颜色
//   final Color? color;
//
//   /// 设置轮廓环的样式
//   static void setRingStyle(
//     BuildContext context, {
//     Duration? duration,
//     Curve? curve,
//     BorderRadius? radius,
//     Color? color,
//   }) {
//     context
//         .getInheritedWidgetOfExactType<_RingInheritedWidget>()
//         ?.setRingStyle(duration, curve, radius, color);
//   }
//
//   @override
//   State<ElRing> createState() => _ElRingState();
// }
//
// class _ElRingState extends State<ElRing> with SingleTickerProviderStateMixin {
//   late final AnimationController controller = AnimationController(vsync: this);
//   late CurvedAnimation curvedAnimation = CurvedAnimation(
//     parent: controller,
//     curve: Curves.linear,
//   );
//   late Animation ringAnimation;
//
//   late ElRingThemeData themeData;
//   bool _show = false;
//
//   set show(bool v) {
//     if (_show != v) {
//       _show = v;
//       _show ? controller.forward() : controller.reverse();
//     }
//   }
//
//   BorderRadius? _ringRadius;
//
//   BorderRadius get ringRadius =>
//       themeData.radius ?? _ringRadius ?? BorderRadius.circular(4.0);
//
//   Color? _ringColor;
//
//   Color get ringColor =>
//       themeData.color ?? _ringColor ?? context.elTheme.primary;
//
//   void setRingStyle(
//     Duration? duration,
//     Curve? curve,
//     BorderRadius? radius,
//     Color? color,
//   ) {
//     if (themeData.duration != null) {
//       controller.duration = themeData.duration;
//     } else {
//       controller.duration = duration;
//     }
//
//     if (themeData.curve != null) {
//       curvedAnimation = CurvedAnimation(
//         parent: controller,
//         curve: themeData.curve!,
//       );
//     } else if (curve != null) {
//       curvedAnimation = CurvedAnimation(
//         parent: controller,
//         curve: curve,
//       );
//     } else if (curvedAnimation.curve != Curves.linear) {
//       curvedAnimation = CurvedAnimation(
//         parent: controller,
//         curve: Curves.linear,
//       );
//     }
//
//     ringAnimation =
//         Tween(begin: 0.0, end: themeData.width!).animate(curvedAnimation);
//
//     _ringColor = color;
//
//     if (radius != null) {
//       _ringRadius = BorderRadius.only(
//         topLeft: Radius.elliptical(
//           calcRingRadius(radius.topLeft.x),
//           calcRingRadius(radius.topLeft.y),
//         ),
//         topRight: Radius.elliptical(
//           calcRingRadius(radius.topRight.x),
//           calcRingRadius(radius.topRight.y),
//         ),
//         bottomLeft: Radius.elliptical(
//           calcRingRadius(radius.bottomLeft.x),
//           calcRingRadius(radius.bottomLeft.y),
//         ),
//         bottomRight: Radius.elliptical(
//           calcRingRadius(radius.bottomRight.x),
//           calcRingRadius(radius.bottomRight.y),
//         ),
//       );
//     } else {
//       _ringRadius = null;
//     }
//   }
//
//   double calcRingRadius(double value) {
//     if (value <= themeData.offset!) {
//       return 0.0;
//     } else {
//       return value + themeData.offset!;
//     }
//   }
//
//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
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
//     controller.duration = themeData.duration ?? Duration.zero;
//     ringAnimation = Tween(
//       begin: 0.0,
//       end: themeData.width!,
//     ).animate(curvedAnimation);
//     show = themeData.show ?? false;
//     final double ringPosition = -(themeData.offset! + themeData.width!);
//     return Stack(
//       clipBehavior: Clip.none,
//       children: [
//         _RingInheritedWidget(
//           setRingStyle,
//           child: widget.child,
//         ),
//         Positioned(
//           top: ringPosition,
//           left: ringPosition,
//           right: ringPosition,
//           bottom: ringPosition,
//           child: IgnorePointer(
//             child: AnimatedBuilder(
//               animation: controller.view,
//               builder: (context, child) {
//                 return Opacity(
//                   opacity: controller.value,
//                   child: DecoratedBox(
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         width: ringAnimation.value,
//                         color: ringColor,
//                       ),
//                       borderRadius: ringRadius,
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class _RingInheritedWidget extends InheritedWidget {
//   const _RingInheritedWidget(
//     this.setRingStyle, {
//     required super.child,
//   });
//
//   final void Function(
//     Duration? duration,
//     Curve? curve,
//     BorderRadius? value,
//     Color? color,
//   ) setRingStyle;
//
//   @override
//   bool updateShouldNotify(_RingInheritedWidget oldWidget) => false;
// }
