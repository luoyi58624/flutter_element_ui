import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

import '../../../../global.dart';

class MyCard extends StatefulWidget {
  const MyCard({super.key});

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  double direction = 0;

  Offset dragStartOffset = const Offset(0, 0);
  Offset dragUpdateOffset = const Offset(0, 0);

  @override
  void initState() {
    super.initState();
    controller = AnimationController.unbounded(vsync: vsync)
      ..addListener(() {
        i(controller.value);
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _handleNextCardStatusListener() {
    i(controller.value);
    Size screenSize = MediaQuery.of(context).size;
    Offset cardOffset = Offset.fromDirection(direction, controller.value);
    if (cardOffset.dx.abs() > screenSize.width ||
        cardOffset.dy.abs() > screenSize.width) {
      controller.stop();
      controller.removeListener(_handleNextCardStatusListener);
    }
  }

  bool _hasEscapeVelocity(DragEndDetails dragDetails, Offset dragOffset) {
    Size screenSize = MediaQuery.of(context).size;
    return dragOffset.distance.abs() +
                dragDetails.velocity.pixelsPerSecond.distance.abs() >
            screenSize.width / 2 &&
        dragDetails.velocity.pixelsPerSecond.distance > 300;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: AnimatedBuilder(
          animation: controller,
          builder: (context, snapshot) {
            return Transform.translate(
              offset: Offset.fromDirection(
                direction,
                controller.value,
              ),
              child: GestureDetector(
                onPanStart: (DragStartDetails details) {
                  dragStartOffset = details.globalPosition;
                },
                onPanUpdate: (DragUpdateDetails details) {
                  dragUpdateOffset = details.globalPosition;
                  Offset dragOffset = dragUpdateOffset - dragStartOffset;
                  controller.value = dragOffset.distance;
                  direction = dragOffset.direction;
                },
                onPanEnd: (DragEndDetails e) {
                  Offset dragOffset = dragUpdateOffset - dragStartOffset;
                  // if (_hasEscapeVelocity(e, dragOffset)) {
                  if (e.velocity.pixelsPerSecond.distance > 10300) {
                    FrictionSimulation frictionSim = FrictionSimulation(
                      1.1,
                      controller.value,
                      e.velocity.pixelsPerSecond.distance,
                      tolerance: const Tolerance(distance: 1, velocity: 1),
                    );
                    controller.animateWith(frictionSim);
                    controller.addListener(_handleNextCardStatusListener);
                  } else {
                    SpringDescription springDesc = const SpringDescription(
                      mass: 20,
                      stiffness: 500,
                      damping: 0.75,
                    );
                    SpringSimulation springSim = SpringSimulation(
                      springDesc,
                      controller.value,
                      0,
                      e.velocity.pixelsPerSecond.distance,
                    );
                    controller.animateWith(springSim);
                  }
                },
                child: Card(
                  clipBehavior: Clip.hardEdge,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 3,
                ),
              ),
            );
          }),
    );
  }
}
