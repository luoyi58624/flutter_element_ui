import 'package:element_docs/global.dart';

import 'package:flutter/material.dart';

class Example3 extends StatelessWidget {
  const Example3({super.key, required this.title});

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
          height: 500,
          decoration: BoxDecoration(
            border: context.elBorder,
          ),
          child: TwoDimensionalScrollWidget(
            scrollbarMode: scrollbarMode,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...List.generate(
                  51,
                  (row) {
                    return Row(
                      children: List.generate(51, (int col) {
                        return Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text('row: $row; col: $col'),
                        );
                      }),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TwoDimensionalScrollWidget extends HookWidget {
  const TwoDimensionalScrollWidget({
    super.key,
    required this.child,
    required this.scrollbarMode,
  });

  final Widget child;
  final ElScrollbarMode scrollbarMode;

  @override
  Widget build(BuildContext context) {
    final verticalController = useScrollController();
    final horizontalController = useScrollController();
    return ElScrollbar(
      controller: verticalController,
      mode: scrollbarMode,
      child: ElScrollbar(
        controller: horizontalController,
        mode: scrollbarMode,
        notificationPredicate: (ScrollNotification notify) => notify.depth == 1,
        child: SingleChildScrollView(
          controller: verticalController,
          child: SingleChildScrollView(
            primary: false,
            controller: horizontalController,
            scrollDirection: Axis.horizontal,
            child: child,
          ),
        ),
      ),
    ).noScrollBehavior;
  }
}

String get code => '''
class _Example extends HookWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
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
          height: 500,
          decoration: BoxDecoration(
            border: context.elBorder,
          ),
          child: TwoDimensionalScrollWidget(
            scrollbarMode: scrollbarMode,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...List.generate(
                  51,
                  (row) {
                    return Row(
                      children: List.generate(51, (int col) {
                        return Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text('row: \$row; col: \$col'),
                        );
                      }),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TwoDimensionalScrollWidget extends HookWidget {
  const TwoDimensionalScrollWidget({
    super.key,
    required this.child,
    required this.scrollbarMode,
  });

  final Widget child;
  final ElScrollbarMode scrollbarMode;

  @override
  Widget build(BuildContext context) {
    final verticalController = useScrollController();
    final horizontalController = useScrollController();
    return ElScrollbar(
      controller: verticalController,
      mode: scrollbarMode,
      scrollbarOrientation: ScrollbarOrientation.right,
      child: ElScrollbar(
        controller: horizontalController,
        mode: scrollbarMode,
        scrollbarOrientation: ScrollbarOrientation.bottom,
        notificationPredicate: (ScrollNotification notify) => notify.depth == 1,
        child: SingleChildScrollView(
          controller: verticalController,
          child: SingleChildScrollView(
            primary: false,
            controller: horizontalController,
            scrollDirection: Axis.horizontal,
            child: child,
          ),
        ),
      ),
    ).noScrollBehavior;
  }
}
''';
