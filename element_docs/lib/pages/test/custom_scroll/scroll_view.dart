// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
//
// class MyScrollView extends MultiChildRenderObjectWidget {
//   const MyScrollView({super.key, super.children});
//
//   @override
//   RenderObject createRenderObject(BuildContext context) {
//     return _Render();
//   }
// }
//
// class _ParentData extends ContainerBoxParentData<RenderBox> {}
//
// class _Render extends RenderBox
//     with
//         ContainerRenderObjectMixin<RenderBox, _ParentData>,
//         RenderBoxContainerDefaultsMixin<RenderBox, _ParentData> {
//   @override
//   void performLayout() {
//     var child = firstChild;
//     double scrollViewHeight = 0;
//     while (child != null) {
//       var childParentData = child.parentData as _ParentData;
//       child.layout(
//         constraints.loosen(),
//         parentUsesSize: true,
//       );
//       childParentData.offset = Offset(0, child.size.height);
//       scrollViewHeight += child.size.height;
//       child = childAfter(child);
//     }
//     size = Size(constraints.maxWidth, scrollViewHeight);
//   }
//
//   @override
//   void paint(PaintingContext context, Offset offset) {
//     defaultPaint(context, offset);
//   }
//
//   @override
//   bool hitTestSelf(Offset position) {
//     return true;
//   }
//
//   @override
//   bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
//     return defaultHitTestChildren(result, position: position);
//   }
//
//   @override
//   void setupParentData(RenderObject child) {
//     if (child.parentData is! _ParentData) {
//       child.parentData = _ParentData();
//     }
//   }
// }
