import 'dart:ui';

import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

/// 摩擦力动画测试
class FrictionAnimateTest extends StatefulWidget {
  const FrictionAnimateTest({super.key});

  @override
  State<FrictionAnimateTest> createState() => _FrictionAnimateTestState();
}

class _FrictionAnimateTestState extends State<FrictionAnimateTest> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: SizedBox(
        height: 300,
        child: LayoutBuilder(builder: (context, constraints) {
          return Stack(
            children: [
              Container(
                width: constraints.maxWidth,
                color: Colors.grey.shade300,
              ),
              // const Positioned(
              //   child: _Demo(),
              // ),
              _Demo2(
                constraints: constraints,
              ),
            ],
          );
        }),
      ),
    );
  }
}

// class _Demo extends StatefulWidget {
//   const _Demo();
//
//   @override
//   State<_Demo> createState() => _DemoState();
// }
//
// class _DemoState extends State<_Demo> {
//   Offset dragStartOffset = Offset.zero;
//   late Offset offset;
//   double direction = 1.0;
//   double distance = 100.0;
//
//   @override
//   Widget build(BuildContext context) {
//     double size = 50;
//     return Transform.translate(
//       offset: Offset.fromDirection(direction, distance),
//       child: GestureDetector(
//         onPanStart: (e) {
//           offset = Offset.fromDirection(direction, distance);
//           dragStartOffset = e.globalPosition;
//         },
//         onPanUpdate: (e) {
//           final dragOffset = e.globalPosition - dragStartOffset;
//           final targetOffset = offset + dragOffset;
//           i(targetOffset.direction);
//           setState(() {
//             direction = targetOffset.direction;
//             distance = targetOffset.distance;
//           });
//         },
//         child: Material(
//           color: Colors.green,
//           borderRadius: BorderRadius.circular(size / 2),
//           clipBehavior: Clip.hardEdge,
//           child: SizedBox(
//             width: size,
//             height: size,
//           ),
//         ),
//       ),
//     );
//   }
// }

class _Demo2 extends StatefulWidget {
  const _Demo2({required this.constraints});

  final BoxConstraints constraints;

  @override
  State<_Demo2> createState() => _Demo2State();
}

class _Demo2State extends State<_Demo2> {
  late final AnimationController controller =
      AnimationController.unbounded(vsync: vsync)..addListener(listener);
  final isActive = Obs(false);
  final offset = Obs(const Offset(100, 100));

  /// 坐标方向
  double direction = 0.0;

  double? oldValue;

  void listener() {
    late double details;
    if (oldValue == null) {
      oldValue = controller.value;
      details = controller.value;
    } else {
      details = controller.value - oldValue!;
      oldValue = controller.value;
    }
    final offsetDetails = Offset.fromDirection(direction, details);
    offset.value =
        (offset.value + offsetDetails).clampConstraints(widget.constraints);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double size = 50;
    return ObsBuilder(builder: (context) {
      return Positioned(
        left: clampDouble(
          offset.value.dx,
          0,
          widget.constraints.maxWidth - size,
        ),
        top: clampDouble(
          offset.value.dy,
          0,
          widget.constraints.maxHeight - size,
        ),
        child: GestureDetector(
          onPanStart: (e) {
            controller.stop();
            isActive.value = true;
            oldValue = null;
          },
          onPanUpdate: (e) {
            offset.value += e.delta;
          },
          onPanEnd: (e) {
            isActive.value = false;
            direction = e.velocity.pixelsPerSecond.direction;
            FrictionSimulation frictionSim = FrictionSimulation(
              0.01,
              0.0,
              e.velocity.pixelsPerSecond.distance,
            );
            controller.animateWith(frictionSim);
          },
          onPanCancel: () {
            isActive.value = false;
          },
          child: Material(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(size / 2),
            clipBehavior: Clip.hardEdge,
            elevation: isActive.value ? 4 : 0,
            child: SizedBox(
              width: size,
              height: size,
            ),
          ),
        ),
      );
    });
  }
}
