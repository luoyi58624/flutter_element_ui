import 'package:element_docs/global.dart';

import 'package:flutter/material.dart';

class Example1 extends StatelessWidget {
  const Example1({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title),
        const SectionCard(
          title: 'Tip',
          content: [
            'ElScrollbar 是 Element UI 风格的滚动条，默认样式为当鼠标进入滚动区域将立即显示滚动条，'
                '离开滚动区域则立即隐藏滚动条，同时，它还支持多种显示模式'
          ],
        ),
        textGap,
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
    final scrollbarType = useState(0);

    late ElScrollbarMode scrollbarMode;
    switch (scrollbarType.value) {
      case 0:
        scrollbarMode = ElScrollbarMode.hover;
        break;
      case 1:
        scrollbarMode = ElScrollbarMode.always;
        break;
      case 2:
        scrollbarMode = ElScrollbarMode.onlyScrolling;
        break;
      case 3:
        scrollbarMode = ElScrollbarMode.hidden;
        break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElButtonGroup.single(
          scrollbarType,
          mandatory: true,
          children: const [
            ElButtonGroupItem(child: '悬停显示'),
            ElButtonGroupItem(child: '一直显示'),
            ElButtonGroupItem(child: '滚动显示'),
            ElButtonGroupItem(child: '不显示'),
          ],
        ),
        const Gap(8),
        Container(
          height: 300,
          decoration: BoxDecoration(
            border: context.elBorder,
          ),
          child: Material(
            color: context.elLayout.bgColor,
            child: ElScrollbar(
              controller: controller,
              mode: scrollbarMode,
              child: ListView.builder(
                controller: controller,
                itemCount: 10,
                itemBuilder: (context, index) => ListTile(
                  onTap: () {},
                  title: ElText('Item - ${index + 1}'),
                ),
              ),
            ),
          ),
        ).noScrollBehavior, // 添加此扩展屏蔽祖先提供的默认滚动条，防止重叠
      ],
    );
  }
}

String get code => '''
class _Example extends HookWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    final scrollbarType = useState(0);
    final controller = useScrollController();

    late ElScrollbarMode scrollbarMode;
    switch (scrollbarType.value) {
      case 0:
        scrollbarMode = ElScrollbarMode.hover;
        break;
      case 1:
        scrollbarMode = ElScrollbarMode.always;
        break;
      case 2:
        scrollbarMode = ElScrollbarMode.onlyScrolling;
        break;
      case 3:
        scrollbarMode = ElScrollbarMode.hidden;
        break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElButtonTheme(
          data: const ElButtonThemeData(type: El.primary),
          child: ElButtonGroup.single(
            scrollbarType,
            mandatory: true,
            children: const [
              ElButton(child: '悬停显示'),
              ElButton(child: '一直显示'),
              ElButton(child: '滚动显示'),
              ElButton(child: '不显示'),
            ],
          ),
        ),
        const Gap(8),
        Container(
          height: 300,
          decoration: BoxDecoration(
            border: context.elBorder,
          ),
          child: Material(
            color: context.elLayout.bgColor,
            child: ElScrollbar(
              controller: controller,
              mode: scrollbarMode,
              child: ListView.builder(
                controller: controller,
                itemCount: 10,
                itemBuilder: (context, index) => ListTile(
                  onTap: () {},
                  title: ElText('Item - \${index + 1}'),
                ),
              ),
            ),
          ),
        ).noScrollBehavior, // 添加此扩展屏蔽祖先提供的默认滚动条，防止重叠
      ],
    );
  }
}''';
