import 'package:element_docs/global.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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
      ElFocus(
        child: ElEvent(
          onPointerDown: (e) {
            if (e.buttons == kBackMouseButton) {
              i('鼠标返回');
            } else if (e.buttons == kForwardMouseButton) {
              i('鼠标前进');
            }
          },
          child: Builder(builder: (context) {
            return Container(
              width: 200,
              height: 200,
              color: context.isFocusVisible ? Colors.green : Colors.grey,
              alignment: Alignment.center,
            );
          }),
        ),
      ),
      const Gap(8),
      Stack(
        children: [
          GestureDetector(
            onTapDown: (e) {
              el.message.show('parent');
            },
            child: Container(
              width: 300,
              height: 300,
              color: Colors.grey,
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapDown: (e) {
              el.message.success('child');
            },
            child: Container(
              width: 100,
              height: 100,
              // color: Colors.black12,
            ),
          ),
        ],
      ),
      const _Example(),
      // ...List.generate(
      //   50,
      //   (index) => Text('列表 - ${index + 1}'),
      // ),
    ];
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
          const Gap(50),
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
            height: 50,
          ),
          DragTarget(
            // onWillAcceptWithDetails: (e)
            builder: (context, _, __) => Container(
              height: 100,
              color: Colors.grey.shade200,
            ),
          ),
        ],
      );
    });
  }
}
