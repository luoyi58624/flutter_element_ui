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
  late final AnimationController controller =
      AnimationController.unbounded(vsync: vsync)..addListener(listener);
  final isActive = Obs(false);
  final offset = Obs(const Offset(100, 100));

  late BoxConstraints constraints;

  /// 坐标距离
  double distance = 0.0;

  /// 坐标方向
  double direction = 0.0;

  double? oldValue;

  void listener() {
    if (oldValue == null) {
      oldValue = controller.value;
      distance += controller.value;
    } else {
      final details = controller.value - oldValue!;
      i(details);
      distance += details;
      oldValue = controller.value;
    }
    offset.value = Offset.fromDirection(
      direction,
      distance,
    ).clampConstraints(constraints);
    // direction = offset.value.direction;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double size = 50;
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: SizedBox(
        height: 300,
        child: LayoutBuilder(builder: (context, $constraints) {
          constraints = $constraints;
          return Stack(
            children: [
              Container(
                width: constraints.maxWidth,
                color: Colors.grey.shade300,
              ),
              const Positioned(
                child: _Demo(),
              ),
              ObsBuilder(builder: (context) {
                return Positioned(
                  left: clampDouble(
                    offset.value.dx,
                    0,
                    constraints.maxWidth - size,
                  ),
                  top: clampDouble(
                    offset.value.dy,
                    0,
                    constraints.maxHeight - size,
                  ),
                  child: GestureDetector(
                    onPanStart: (e) {
                      controller.stop();
                      oldValue = null;
                      isActive.value = true;
                    },
                    onPanUpdate: (e) {
                      offset.value += e.delta;
                    },
                    onPanEnd: (e) {
                      isActive.value = false;
                      // offset.value = offset.value.clampConstraints(constraints);

                      i(e.velocity.pixelsPerSecond.direction);
                      final dragOffset = offset.value;
                      direction = e.velocity.pixelsPerSecond.direction;
                      distance = dragOffset.distance;

                      FrictionSimulation frictionSim = FrictionSimulation(
                        0.015,
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
              }),
            ],
          );
        }),
      ),
    );
  }
}

class _Demo extends StatefulWidget {
  const _Demo({super.key});

  @override
  State<_Demo> createState() => _DemoState();
}

class _DemoState extends State<_Demo> {
  Offset dragStartOffset = Offset.zero;
  double direction = 0.0;
  double distance = 0.0;

  @override
  Widget build(BuildContext context) {
    double size = 50;
    return Transform.translate(
      offset: Offset.fromDirection(direction, distance),
      child: GestureDetector(
        onPanStart: (e) {
          dragStartOffset = Offset.fromDirection(direction, distance);
        },
        onPanUpdate: (e) {
          final dragOffset = e.globalPosition - dragStartOffset;
          i(dragOffset.direction);
          // setState(() {
          //   direction = dragOffset.direction;
          //   distance = dragOffset.distance;
          // });
        },
        child: Material(
          color: Colors.green,
          borderRadius: BorderRadius.circular(size / 2),
          clipBehavior: Clip.hardEdge,
          child: SizedBox(
            width: size,
            height: size,
          ),
        ),
      ),
    );
  }
}
