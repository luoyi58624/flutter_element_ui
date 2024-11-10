import 'package:element_docs/global.dart';
import 'package:element_docs/pages/commons/guide/nav/render.dart';
import 'package:flutter/material.dart';

import '../../component/basic/button/index.dart';

class _Child2 extends StatelessWidget {
  const _Child2();

  @override
  Widget build(BuildContext context) {
    const buttonPage = ButtonPage();

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      // height: 820000,
      child: Column(
        children: [
          ...buttonPage.buildPage(context),
          // ...List.generate(
          //   3000,
          //   (index) => Text('列表 - ${index + 1}'),
          // ),
        ],
      ),
    );
  }
}

class NavPage extends ResponsivePage {
  const NavPage({super.key});

  @override
  String get title => '导航';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const ElScroll(
        child: _Child2(),
      ),
    );
  }

  @override
  List<Widget> buildPage(BuildContext context) {
    return <Widget>[
      // const Gap(50),
      // const _Demo(),
      // ...List.generate(
      //   400,
      //   (index) => Text('列表 - ${index + 1}'),
      // ),
      // const _Example(),
    ];
  }
}

class _Demo extends StatefulWidget {
  const _Demo({super.key});

  @override
  State<_Demo> createState() => _DemoState();
}

class _DemoState extends State<_Demo> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElButton(
          onPressed: () {
            setState(() {
              count++;
            });
          },
          child: 'count: $count',
          type: El.primary,
        ),
        GestureDetector(
          onTap: () {
            el.message.show('hello');
          },
          child: MyRender(
            child: GestureDetector(
              onTap: () {
                w('child');
              },
              child: const ElButton(
                child: 'hello',
                type: El.primary,
              ),
            ),
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
          Container(
            height: 500,
          ),
        ],
      );
    });
  }
}
