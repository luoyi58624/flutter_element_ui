import 'package:element_docs/global.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Example2 extends HookWidget {
  const Example2({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title),
        CodeExample(
          code: code,
          children: const [
            _Example(),
          ],
        ),
      ],
    );
  }
}

class _Example extends StatefulWidget {
  const _Example();

  @override
  State<_Example> createState() => _ExampleState();
}

class _ExampleState extends State<_Example>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller =
      AnimationController.unbounded(vsync: this)..addListener(listener);

  late BoxConstraints constraints;

  /// 拖拽偏移值
  Offset offset = Offset.zero;

  /// 拖拽结束时的方向
  double endDirection = 0.0;

  void listener() {
    // late double details;
    // if (oldValue == null) {
    //   oldValue = controller.value;
    //   details = controller.value;
    // } else {
    //   details = controller.value - oldValue!;
    //   oldValue = controller.value;
    // }
    // final offsetDetails = Offset.fromDirection(endDirection, details);
    // offset = (offset + offsetDetails).clampConstraints(constraints);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double size = 100;
    return LayoutBuilder(builder: (context, $constraints) {
      constraints = $constraints;
      return Stack(
        children: [
          Container(
            height: 300,
            color: Colors.grey,
          ),
          Positioned(
            left: clampDouble(
              offset.dx,
              0,
              constraints.maxWidth - size,
            ),
            top: clampDouble(
              offset.dy,
              0,
              constraints.maxHeight - size,
            ),
            child: ElDrag(
              onDragStarted: (e){

              },
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(size / 2),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}

String get code => '''
class _Example extends HookWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    final flag = useState(false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ElSwitch(flag),
            const Gap(8),
            ElText('rootOverlay: \${flag.value}'),
          ],
        ),
        const Gap(8),
        ElDrag(
          rootOverlay: flag.value,
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
  }
}''';
