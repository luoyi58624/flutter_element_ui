// part of '../tabs.dart';
//
// /// 谷歌风格标签页离顶部有4px的间距
// const double _googleTabPadding = 4.0;
//
// /// 构建标签页外围容器
// class _GoogleTabsWidget extends StatelessWidget {
//   const _GoogleTabsWidget();
//
//   @override
//   Widget build(BuildContext context) {
//     i('build');
//     final $tabsData = _TabsInheritedWidget.of(context);
//     final $width = $tabsData.maxWidth;
//     final $height = $tabsData.height - _googleTabPadding;
//     double radius = $height / 4 * 3;
//     return _GoogleTabsInheritedWidget(
//       radius,
//       $height,
//       child: ElCustomMultiChildLayout(
//         width: $width + ($width - radius) * ($tabsData.children.length - 1),
//         delegateBuilder: (updateSize) => _GoogleTabLayoutDelegate(
//           updateSize,
//           // 0,
//           // $tabsData.children.length,
//           // $tabsData.maxWidth,
//           // radius,
//         ),
//         children: [
//           ...$tabsData.children.mapIndexed(
//             (i, e) => ElChildIndexData(
//               index: i,
//               child: LayoutId(
//                 id: i,
//                 child: ClipPath(
//                   clipper: _GoogleTabClipper(radius),
//                   child: e,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// /// 具体标签子项
// class _GoogleTab extends StatelessWidget {
//   const _GoogleTab();
//
//   @override
//   Widget build(BuildContext context) {
//     final $tabsData = _TabsInheritedWidget.of(context);
//     final $tabData = _TabInheritedWidget.of(context);
//     final $googleTabData = _GoogleTabsInheritedWidget.of(context);
//     final $indexData = ElChildIndexData.of(context);
//     final Color? color = $tabsData.modelValue.value == $indexData.index
//         ? context.isDark
//             ? context.elTheme.primary
//             : Colors.white
//         : HoverBuilder.of(context)
//             ? context.isDark
//                 ? context.elTheme.primary.light1(context)
//                 : Colors.grey.shade100
//             : null;
//     Widget result = UnconstrainedBox(
//       child: SizedBox(
//         height: $googleTabData.height,
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: $googleTabData.radius),
//           child: Row(
//             children: [
//               ElText(
//                 $tabData.title,
//                 style: TextStyle(fontSize: $tabsData.fontSize),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//     if (color != null) {
//       result = ColoredBox(
//         color: color,
//         child: result,
//       );
//     }
//     return result;
//   }
// }
//
// class _GoogleTabsInheritedWidget extends InheritedWidget {
//   const _GoogleTabsInheritedWidget(
//     this.radius,
//     this.height, {
//     required super.child,
//   });
//
//   /// google风格标签页的圆角值
//   final double radius;
//   final double height;
//
//   static _GoogleTabsInheritedWidget of(BuildContext context) {
//     final _GoogleTabsInheritedWidget? result = context
//         .dependOnInheritedWidgetOfExactType<_GoogleTabsInheritedWidget>();
//     assert(result != null, 'No _GoogleTabsInheritedWidget found in context');
//     return result!;
//   }
//
//   @override
//   bool updateShouldNotify(_GoogleTabsInheritedWidget oldWidget) => true;
// }
//
// class _GoogleTabLayoutDelegate extends MultiChildLayoutDelegate {
//   _GoogleTabLayoutDelegate(
//     this.updateSize,
//     // this.activeIndex,
//     // this.length,
//     // this.maxWidth,
//     // this.radius,
//   );
//
//   /// 更新布局尺寸回调函数
//   final ElUpdateCustomLayoutSize updateSize;
//
//   /// 标签数量
//   final int length = 20;
//
//   /// 激活的下标
//   // final int activeIndex;
//
//   /// 子标签最大宽度
//   final double maxWidth = 200;
//
//   /// 以标签页的圆角值作为每个标签的偏移值
//   final double radius = 16;
//
//   /// 当前是否是第二次布局，[ElCustomMultiChildLayout] 计算完尺寸后会再进行一次重建
//   bool secondLayout = false;
//
//   Size? activeTabSize;
//   double? activeOffsetLeft;
//
//   @override
//   void performLayout(Size size) {
//     // i('per');
//     if (length == 0) return;
//     Size firstSize = layoutChild(
//       0,
//       BoxConstraints(minWidth: 0, maxWidth: maxWidth),
//     );
//     double parentWidth = firstSize.width;
//     for (int i = 1; i < length; i++) {
//       // 如果是第二次进行布局，我们需要将激活的标签放到最后进行布局，这样它的层级将会最高，
//       // 其他标签的鼠标悬停样式才不会覆盖它
//       // if (secondLayout && i == activeIndex) {
//       //   activeOffsetLeft = parentWidth;
//       //   parentWidth += activeTabSize!.width - radius;
//       //   continue;
//       // }
//       final currentSize = layoutChild(
//         i,
//         BoxConstraints(minWidth: 0, maxWidth: maxWidth),
//       );
//       // if (!secondLayout && i == activeIndex) activeTabSize = currentSize;
//       positionChild(i, Offset(parentWidth - radius, 0));
//       parentWidth += currentSize.width - radius;
//     }
//     // if (secondLayout && activeOffsetLeft != null) {
//     //   positionChild(activeIndex, Offset(activeOffsetLeft!, 0));
//     // }
//     // 布局完成设置外围标签页容器的实际尺寸
//     secondLayout = updateSize(Size(parentWidth, size.height));
//   }
//
//   @override
//   bool shouldRelayout(_GoogleTabLayoutDelegate oldDelegate) {
//     i(oldDelegate);
//     return false;
//     // return activeIndex != oldDelegate.activeIndex ||
//     //     length != oldDelegate.length;
//   }
// }
//
// class _GoogleTabClipper extends CustomClipper<Path> {
//   final double r;
//
//   _GoogleTabClipper(this.r);
//
//   @override
//   Path getClip(Size size) {
//     final w = size.width;
//     final h = size.height;
//     final path = Path()
//       ..moveTo(0, h)
//       ..cubicTo(r, h, 0, 0, r, 0)
//       ..lineTo(w - r, 0)
//       ..cubicTo(w, 0, w - r, h, w, h);
//     return path;
//   }
//
//   @override
//   bool shouldReclip(covariant CustomClipper<dynamic> oldClipper) {
//     return true;
//   }
// }
