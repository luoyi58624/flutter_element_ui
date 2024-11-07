import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class NavPage extends ResponsivePage {
  const NavPage({super.key});

  @override
  String get title => '导航';

  @override
  List<Widget> buildPage(BuildContext context) {
    return <Widget>[
      const Gap(50),
      // const Test(),
      const Gap(8),
      const _Test2(),
      // Center(
      //   child: Container(
      //     width: 300,
      //     height: 300,
      //     color: Colors.grey,
      //     child: const Center(
      //       child: MyCard(),
      //     ),
      //   ),
      // ),
      // const _Example(),
    ];
  }
}

class _Test2 extends StatefulWidget {
  const _Test2();

  @override
  State<_Test2> createState() => _Test2State();
}

class _Test2State extends State<_Test2> {
  final size = AnimateObs(
    100.0,
    curve: Curves.easeOut,
    duration: const Duration(milliseconds: 2000),
  );

  @override
  void dispose() {
    size.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElButton(
          onPressed: () {
            size.value = (size.targetValue == 100.0 ? 300.0 : 100.0);
          },
          child: '切换动画',
        ),
        const Gap(8),
        ObsBuilder(
          builder: (context) {
            return Container(
              width: size.value,
              height: size.value,
              color: Colors.grey,
            );
          },
        ),
      ],
    );
  }
}

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 5000),
    );
    final curveAnimate = CurvedAnimation(
      parent: controller,
      curve: Curves.easeOut,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElButton(
          onPressed: () {
            controller.toggle();
          },
          child: '切换动画',
        ),
        const Gap(8),
        ElButton(
          onPressed: () {
            controller.stop();
          },
          child: '暂停动画',
        ),
        const Gap(8),
        ElButton(
          onPressed: () {
            controller.start();
          },
          child: '启动动画',
        ),
        const Gap(8),
        AnimatedBuilder(
          animation: controller.view,
          builder: (context, child) => Container(
            width: 100 + curveAnimate.value * 50,
            height: 100 + curveAnimate.value * 50,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class _Example extends StatefulHookWidget {
  const _Example();

  @override
  State<_Example> createState() => _ExampleState();
}

class _ExampleState extends State<_Example>
    with SingleTickerProviderStateMixin {
  late final controller = AnimationController(vsync: this);
  final flag = Obs(false);
  final position = Obs(Offset.zero);

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      i(controller.value);
      position.value = Offset(
        position.value.dx,
        position.value.dy + controller.value,
      );
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ObsBuilder(builder: (context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(8),
          Stack(
            children: [
              Container(
                width: 300,
                height: 300,
                color: Colors.grey,
              ),
              Positioned(
                left: position.value.dx,
                top: position.value.dy,
                child: ElDrag(
                  axis: flag.value ? Axis.vertical : Axis.horizontal,
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
          const Gap(8),
          Stack(
            children: [
              Container(
                width: 300,
                height: 300,
                color: Colors.grey,
              ),
              Positioned(
                left: position.value.dx,
                top: position.value.dy,
                child: Draggable(
                  onDragUpdate: (e) {
                    position.value += e.delta;
                  },
                  onDragEnd: (e) {
                    // FrictionSimulation();
                    controller.animateWith(FrictionSimulation(
                      0.8,
                      0,
                      10,
                    ));
                    // i(e.velocity);
                  },
                  feedback: Container(
                    width: 100,
                    height: 100,
                    color: Colors.green,
                  ),
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
          const Gap(8),
          ElSwitch(flag),
          const Gap(8),
          ElDrag(
            axis: flag.value ? Axis.vertical : Axis.horizontal,
            feedback: Container(
              width: 100,
              height: 100,
              color: Colors.green,
            ),
            child: Container(
              width: 100,
              height: 100,
              color: Colors.grey,
            ),
          ),
          const Gap(8),
          Draggable(
            rootOverlay: true,
            axis: flag.value ? Axis.vertical : Axis.horizontal,
            onDragUpdate: (e) {
              i(e.delta);
            },
            feedback: Container(
              width: 100,
              height: 100,
              color: Colors.green,
            ),
            child: Container(
              width: 100,
              height: 100,
              color: Colors.grey,
            ),
          ),
        ],
      );
    });
  }
}
