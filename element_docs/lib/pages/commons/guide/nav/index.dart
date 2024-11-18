import 'package:element_docs/global.dart';
import 'package:element_docs/pages/commons/guide/nav/render.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../component/basic/button/index.dart';

class _ClickGestureRecognizer extends TapGestureRecognizer {
  /// 重写点击拒绝事件，将拒绝变为允许，这样将会触发事件冒泡
  @override
  void rejectGesture(int pointer) {
    acceptGesture(pointer);
    super.rejectGesture(pointer);
  }
}

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
      GestureDetector(
        onTap: () {
          el.message.show('点击');
        },
        child: Container(
          width: 200,
          height: 200,
          color: Colors.green,
          alignment: Alignment.center,
          child: RawGestureDetector(
            gestures: {
              _ClickGestureRecognizer:
                  GestureRecognizerFactoryWithHandlers<_ClickGestureRecognizer>(
                () => _ClickGestureRecognizer(),
                (instance) {
                  instance.onTap = () {
                    el.message.success('点击 Child');
                  };
                },
              ),
            },
            child: Container(
              width: 100,
              height: 100,
              color: Colors.red,
            ),
          ),
        ),
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
