import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

class NavPage extends ResponsivePage {
  const NavPage({super.key});

  @override
  String get title => '导航';

  @override
  List<Widget> buildPage(BuildContext context) {
    return <Widget>[
      const Gap(50),
      // const FocusExample(),
      const Gap(8),
      ElButton(
        onPressed: () {
          getTextElement(el.context);
        },
        child: '查找所有 Text',
      ),

      const TranslatorText(
        child: ElText('你好'),
      ),

      // ElEvent(
      //   onPointerDown: (e) {
      //     i(e.buttons);
      //     if (e.buttons == kBackMouseButton) {
      //       i('鼠标返回');
      //     } else if (e.buttons == kForwardMouseButton) {
      //       i('鼠标前进');
      //     }
      //   },
      //   child: Builder(builder: (context) {
      //     return Container(
      //       width: 200,
      //       height: 200,
      //       alignment: Alignment.center,
      //       color: Colors.grey,
      //     );
      //   }),
      // ),

      // const _Example(),
    ];
  }
}

void getTextElement(BuildContext context) {
  context.visitChildElements((element) {
    if (element.widget is ElText) {
      i((element.widget as ElText).data);
    }
    getTextElement(element);
  });
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
