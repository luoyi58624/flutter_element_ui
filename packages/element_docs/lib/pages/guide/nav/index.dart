import 'dart:ui';

import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

import 'button_list.dart';

class NavPage extends ResponsivePage {
  const NavPage({super.key});

  @override
  String get title => '导航';

  @override
  List<Widget> buildPage(BuildContext context) {
    return [
      const Gap(50),
      const Row(
        children: [
          ElRing(
            show: true,
            offset: 8,
            child: ElButton(child: 'Hello'),
          ),
          ElText('Hello'),
        ],
      ),
      const Gap(30),
      ElButton(
        onPressed: () {
          context.push(const ButtonListTestPage());
        },
        child: 'ElButton',
      ),
      const Gap(8),
      ElButton(
        onPressed: () {
          context.push(const ButtonListTestPage2());
        },
        child: 'ElButton',
      ),
      const Gap(8),
      ElButton(
        onPressed: () {
          context.push(const ButtonListTestPage3());
        },
        child: 'ElevatedButton',
      ),
      const Gap(8),
      Container(
        width: 400,
        height: 400,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image:
                AssetImage("assets/images/contribute/button_local_theme.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: ClipRect(
            child: Container(
              width: 160,
              height: 160,
              color: Colors.white10,
              child: Center(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: const ElText('hello'),
                ),
              ),
            ),
          ),
        ),
      ),
      const Gap(8),
      ElButton(
        onPressed: () {
          getTextElement(el.context);
        },
        child: '查找所有 Text',
      ),

      ...FontWeight.values.map((e) => ElText(
            '这是一段文字',
            style: TextStyle(fontWeight: e),
          )),

      const TranslatorText(
        child: ElText('你好'),
      ),

      Container(
        width: 300,
        height: 200,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: ['#e66465'.toColor(), '#9198e5'.toColor()],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
      const Gap(8),

      ElEvent(
        child: Builder(builder: (context) {
          return ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: context.hasTap
                  ? [
                      Color.fromRGBO(255, 255, 255, 0.9),
                      Color.fromRGBO(0, 0, 0, 0.1),
                    ]
                  : [
                      Color.fromRGBO(255, 255, 255, 0.15),
                      Color.fromRGBO(0, 0, 0, 0.1),
                    ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.0, 1.0],
            ).createShader(bounds),
            child: Container(
              width: 300,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: context.elLayout.borderColor!),
              ),
            ),
          );
        }),
      ),
      const Gap(8),
      Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          shape: BoxShape.rectangle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(25),
              offset: const Offset(0, 14),
              blurRadius: 24,
              spreadRadius: 0,
            ),
          ],
        ),
      ),

      const Gap(50),

      Container(
        width: 100,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade600,
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 4),
            ),
            BoxShadow(
              color: Colors.white,
              offset: const Offset(-4, 0),
            ),
            BoxShadow(
              color: Colors.white,
              offset: const Offset(4, 0),
            )
          ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.grey.shade200,
              Colors.grey.shade300,
              Colors.grey.shade400,
              Colors.grey.shade500,
            ],
          ),
        ),
        child: Center(child: Text('hello')),
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
