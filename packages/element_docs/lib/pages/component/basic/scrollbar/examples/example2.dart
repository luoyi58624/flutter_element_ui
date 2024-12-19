import 'package:element_docs/global.dart';

import 'package:flutter/material.dart';

class Example2 extends StatelessWidget {
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
    final controller = useScrollController();
    final width = useState(6.0);
    final mainAxisMargin = useState(0.0);
    final crossAxisMargin = useState(1.0);
    final enabledRadius = useState(true);
    final showTrack = useState(false);
    final interactive = useState(true);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const ElText('宽度'),
            Expanded(
              child: Slider(
                min: 1.0,
                max: 20.0,
                label: width.value.round().toString(),
                value: width.value,
                onChanged: (v) => width.value = v,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const ElText('上下边距'),
            Expanded(
              child: Slider(
                min: 0.0,
                max: 8.0,
                label: mainAxisMargin.value.round().toString(),
                value: mainAxisMargin.value,
                onChanged: (v) => mainAxisMargin.value = v,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const ElText('左右边距'),
            Expanded(
              child: Slider(
                min: 0.0,
                max: 8.0,
                label: crossAxisMargin.value.round().toString(),
                value: crossAxisMargin.value,
                onChanged: (v) => crossAxisMargin.value = v,
              ),
            ),
          ],
        ),
        const Gap(8),
        Row(
          children: [
            const ElText('开启圆角'),
            const Gap(8),
            ElSwitch(enabledRadius),
          ],
        ),
        const Gap(16),
        Row(
          children: [
            const ElText('显示轨道'),
            const Gap(8),
            ElSwitch(showTrack),
          ],
        ),
        const Gap(16),
        Row(
          children: [
            const ElText('允许交互'),
            const Gap(8),
            ElSwitch(interactive),
          ],
        ),
        const Gap(8),
        Container(
          height: 300,
          decoration: BoxDecoration(
            border: context.elBorder,
          ),
          child: Material(
            color: context.elTheme.bgColor,
            child: ElScrollbar(
              controller: controller,
              mode: ElScrollbarMode.always,
              thickness: width.value,
              mainAxisMargin: mainAxisMargin.value,
              crossAxisMargin: crossAxisMargin.value,
              radius: Radius.circular(
                enabledRadius.value ? width.value / 2 : 0.0,
              ),
              trackBorderColor: showTrack.value
                  ? (context.isDark ? Colors.white30 : Colors.black12)
                  : Colors.transparent,
              interactive: interactive.value,
              child: ListView.builder(
                controller: controller,
                itemCount: 30,
                itemBuilder: (context, index) => ListTile(
                  onTap: () {},
                  title: ElText('Item - ${index + 1}'),
                ),
              ),
            ),
          ),
        ).noScrollBehavior,
      ],
    );
  }
}

String get code => '''
class _Example extends HookWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    final controller = useScrollController();
    final width = useState(6.0);
    final mainAxisMargin = useState(0.0);
    final crossAxisMargin = useState(1.0);
    final enabledRadius = useState(true);
    final showTrack = useState(false);
    final interactive = useState(true);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const ElText('宽度'),
            Expanded(
              child: Slider(
                min: 1.0,
                max: 20.0,
                label: width.value.round().toString(),
                value: width.value,
                onChanged: (v) => width.value = v,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const ElText('上下边距'),
            Expanded(
              child: Slider(
                min: 0.0,
                max: 8.0,
                label: mainAxisMargin.value.round().toString(),
                value: mainAxisMargin.value,
                onChanged: (v) => mainAxisMargin.value = v,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const ElText('左右边距'),
            Expanded(
              child: Slider(
                min: 0.0,
                max: 8.0,
                label: crossAxisMargin.value.round().toString(),
                value: crossAxisMargin.value,
                onChanged: (v) => crossAxisMargin.value = v,
              ),
            ),
          ],
        ),
        const Gap(8),
        Row(
          children: [
            const ElText('开启圆角'),
            const Gap(8),
            ElSwitch(enabledRadius),
          ],
        ),
        const Gap(16),
        Row(
          children: [
            const ElText('显示轨道'),
            const Gap(8),
            ElSwitch(showTrack),
          ],
        ),
        const Gap(16),
        Row(
          children: [
            const ElText('允许交互'),
            const Gap(8),
            ElSwitch(interactive),
          ],
        ),
        const Gap(8),
        Container(
          height: 300,
          decoration: BoxDecoration(
            border: context.elBorder,
          ),
          child: Material(
            color: context.elTheme.bgColor,
            child: ElScrollbar(
              controller: controller,
              mode: ElScrollbarMode.always,
              thickness: width.value,
              mainAxisMargin: mainAxisMargin.value,
              crossAxisMargin: crossAxisMargin.value,
              radius: Radius.circular(
                enabledRadius.value ? width.value / 2 : 0.0,
              ),
              trackBorderColor: showTrack.value
                  ? (context.isDark ? Colors.white30 : Colors.black12)
                  : Colors.transparent,
              interactive: interactive.value,
              child: ListView.builder(
                controller: controller,
                itemCount: 30,
                itemBuilder: (context, index) => ListTile(
                  onTap: () {},
                  title: ElText('Item - \${index + 1}'),
                ),
              ),
            ),
          ),
        ).noScrollBehavior,
      ],
    );
  }
}''';
