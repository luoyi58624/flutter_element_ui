import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';
import 'package:pixel_snap/pixel_snap.dart';
// import 'package:pixel_snap/material.dart';

import '../../component/basic/button/index.dart';
import 'render.dart';

class NavPage extends ResponsivePage {
  const NavPage({super.key});

  @override
  String get title => '导航';

  @override
  List<Widget> buildPage(BuildContext context) {
    final ps = PixelSnap.of(context);
    return <Widget>[
      // const Gap(50),
      // const _Demo(),

      // const _Demo(),
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
      Wrap(
        spacing: 20,
        runSpacing: 20,
        children: ButtonPage.buttonTypes
            .map(
              (type) => FocusExample(type),
            )
            .toList(),
      ),
      // const _Example(),
      // ...List.generate(
      //   50,
      //   (index) => Text('列表 - ${index + 1}'),
      // ),
    ];
  }
}

class FocusExample extends HookWidget {
  const FocusExample(this.type, {super.key});

  final String? type;

  @override
  Widget build(BuildContext context) {
    final isHover = useState(false);
    return ElEventTheme(
      data: ElEventThemeData(
        onHover: (e) {
          isHover.value = true;
        },
        onExit: (e) {
          isHover.value = false;
        },
      ),
      child: ElRingTheme(
        data: ElRingThemeData(
          show: isHover.value,
        ),
        child: ElButton(
          child: 'Hello',
          type: type,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
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
