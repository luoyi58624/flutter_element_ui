import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

class Example1 extends HookWidget {
  const Example1({super.key, required this.title});

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
    final axisFlag = useState(0);
    final isRootOverlay = useState(false);
    final enabledTriggerOffset = useState(false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElButtonGroup.single(
          axisFlag,
          mandatory: true,
          children: const [
            ElButtonGroupItem(child: '不限方向'),
            ElButtonGroupItem(child: '固定横向'),
            ElButtonGroupItem(child: '固定垂直'),
          ],
        ),
        const Gap(8),
        Row(
          children: [
            ElSwitch(isRootOverlay),
            const Gap(8),
            ElText('rootOverlay: ${isRootOverlay.value}'),
          ],
        ),
        const Gap(8),
        Row(
          children: [
            ElSwitch(enabledTriggerOffset),
            const Gap(8),
            ElText('开启触发拖拽偏移: ${enabledTriggerOffset.value}'),
          ],
        ),
        const Gap(8),
        ElStopPropagation(
          enabled: false,
          child: ElDraggable(
            rootOverlay: isRootOverlay.value,
            triggerOffset: enabledTriggerOffset.value ? 20 : 0,
            axis: axisFlag.value == 0
                ? null
                : axisFlag.value == 1
                    ? Axis.horizontal
                    : Axis.vertical,
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
        ),
      ],
    );
  }
}

String get code => '''
class _Example extends HookWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    final axisFlag = useState(0);
    final isRootOverlay = useState(false);
    final enabledTriggerOffset = useState(false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElButtonGroup.single(
          axisFlag,
          mandatory: true,
          children: const [
            ElButtonGroupItem(child: '不限方向'),
            ElButtonGroupItem(child: '固定横向'),
            ElButtonGroupItem(child: '固定垂直'),
          ],
        ),
        const Gap(8),
        Row(
          children: [
            ElSwitch(isRootOverlay),
            const Gap(8),
            ElText('rootOverlay: \${isRootOverlay.value}'),
          ],
        ),
        const Gap(8),
        Row(
          children: [
            ElSwitch(enabledTriggerOffset),
            const Gap(8),
            ElText('开启触发拖拽偏移: \${enabledTriggerOffset.value}'),
          ],
        ),
        const Gap(8),
        ElStopPropagation(
          enabled: false,
          child: ElDrag(
            rootOverlay: isRootOverlay.value,
            triggerOffset:
                enabledTriggerOffset.value ? const Offset(20, 20) : Offset.zero,
            axis: axisFlag.value == 0
                ? null
                : axisFlag.value == 1
                    ? Axis.horizontal
                    : Axis.vertical,
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
        ),
      ],
    );
  }
}''';
