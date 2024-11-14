import 'package:element_docs/global.dart';
import 'package:element_docs/pages/commons/guide/nav/render.dart';
import 'package:flutter/material.dart';

import '../../component/basic/button/index.dart';

class NavPage extends ResponsivePage {
  const NavPage({super.key});

  @override
  String get title => '导航';

  @override
  List<Widget> buildPage(BuildContext context) {
    return <Widget>[
      // const Gap(50),
      // const _Demo(),

      // const _Demo(),
      const _Example(),
      // ...List.generate(
      //   50,
      //   (index) => Text('列表 - ${index + 1}'),
      // ),
    ];
  }
}

class _Demo extends StatefulWidget {
  const _Demo({super.key});

  @override
  State<_Demo> createState() => _DemoState();
}

class _DemoState extends State<_Demo> {
  double _top = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: 300,
          height: 300,
          color: Colors.green,
        ),
        Positioned(
          left: 150,
          top: _top,
          child: GestureDetector(
            child: const CircleAvatar(child: Text("A")),
            //要拖动和点击的widget
            onPanUpdate: (DragUpdateDetails details) {
              setState(() {
                _top += details.delta.dy;
              });
            },
            // onVerticalDragUpdate: (e) {},
            onHorizontalDragEnd: (details) {
              print("onHorizontalDragEnd");
            },
            onTapDown: (details) {
              print("down");
            },
            onTapUp: (details) {
              print("up");
            },
          ),
        )
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
          Container(
            height: 500,
          ),
          Draggable(
            rootOverlay: true,
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
          Container(
            height: 500,
          ),
        ],
      );
    });
  }
}
