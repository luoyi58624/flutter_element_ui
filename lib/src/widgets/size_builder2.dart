import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_element_ui/src/global.dart';

//
// class ElAnimateSizedBox extends StatefulWidget {
//   const ElAnimateSizedBox({
//     super.key,
//     required this.child,
//     this.curve = Curves.linear,
//   });
//
//   final Widget child;
//
//   final Curve curve;
//
//   @override
//   State<ElAnimateSizedBox> createState() => _ElAnimateSizedBoxState();
// }
//
// class _ElAnimateSizedBoxState extends State<ElAnimateSizedBox>
//     with SingleTickerProviderStateMixin {
//   GlobalKey key = GlobalKey();
//   late AnimationController controller = AnimationController(
//     vsync: this,
//     duration: 300.ms,
//   )..addListener(() {
//       currentSize = sizeAnimate.value!;
//     });
//
//   late Animation<Size?> sizeAnimate = SizeTween(
//     begin: currentSize,
//     end: currentSize,
//   ).animate(CurvedAnimation(
//     parent: controller,
//     curve: widget.curve,
//   ));
//
//   Size currentSize = Size.infinite;
//
//   bool hasInitialize = false;
//
//   @override
//   void initState() {
//     super.initState();
//     setAnimate(Size.infinite);
//   }
//
//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }
//
//   setAnimate(Size size) {
//     i(size);
//     sizeAnimate = SizeTween(
//       begin: currentSize,
//       end: size,
//     ).animate(CurvedAnimation(
//       parent: controller,
//       curve: widget.curve,
//     ));
//     controller.forward(from: 0);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (hasInitialize) {
//       ElUtils.nextTick(() {
//         setAnimate(key.currentContext!.size!);
//       });
//     } else {
//       hasInitialize = true;
//     }
//     return AnimatedBuilder(
//       animation: controller.view,
//       builder: (context, child) {
//         return ConstrainedBox(
//           key: key,
//           constraints: BoxConstraints(
//             minWidth: 0,
//             minHeight: 0,
//             maxWidth: sizeAnimate.value!.width,
//             maxHeight: sizeAnimate.value!.height,
//           ),
//           child: SingleChildScrollView(child: widget.child),
//         );
//       },
//     );
//   }
// }

// class ElAniateSize extends SingleChildRenderObjectWidget {
//   const ElSizeBuilder2({
//     super.key,
//     required super.child,
//   });
//
//   @override
//   RenderObject createRenderObject(BuildContext context) {
//     return _Render();
//   }
// }
//
// class _Render extends RenderBox with RenderObjectWithChildMixin<RenderBox> {
//   @override
//   void performLayout() {
//     i('performLayout');
//     child!.layout(BoxConstraints.loose(const Size(300, 300)),
//         parentUsesSize: true);
//     size = child!.size;
//   }
//
//   @override
//   void paint(PaintingContext context, Offset offset) {
//     if (child != null) {
//       context.paintChild(child as RenderObject, offset);
//     }
//   }
// }

typedef ElSizeChange = void Function(Size size);

class ElAnimateSize extends SingleChildRenderObjectWidget {
  final ElSizeChange onChanged;

  const ElAnimateSize({
    super.key,
    required this.onChanged,
    required super.child,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _Render(onChanged);
  }
}

class _Render extends RenderProxyBox {
  Size? oldSize;
  final ElSizeChange onChanged;

  _Render(this.onChanged);

  @override
  void performLayout() {
    super.performLayout();

    Size newSize = child!.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    ElUtils.nextTick(() {
      onChanged(newSize);
    });
  }
}
