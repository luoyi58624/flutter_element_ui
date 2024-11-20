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

class _Example extends HookWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    final offset = useState(Offset.zero);

    double size = 100;
    return SizedBox(
      height: 300,
      child: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          children: [
            Container(
              color: Colors.grey,
            ),
            Positioned(
              left: clampDouble(
                offset.value.dx,
                0,
                constraints.maxWidth - size,
              ),
              top: clampDouble(
                offset.value.dy,
                0,
                constraints.maxHeight - size,
              ),
              child: ElStopPropagation(
                child: ElDrag(
                  onDragDown: (e) {
                    offset.value = offset.value.clampConstraints(BoxConstraints(
                      maxWidth: constraints.maxWidth - size,
                      maxHeight: constraints.maxHeight - size,
                    ));
                  },
                  onChanged: (e) {
                    offset.value += e.details;
                  },
                  enabledAnimate: true,
                  damping: 0.975,
                  triggerOffset: const Offset(30, 30),
                  child: Container(
                    width: size,
                    height: size,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      // borderRadius: BorderRadius.circular(size / 2),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
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
