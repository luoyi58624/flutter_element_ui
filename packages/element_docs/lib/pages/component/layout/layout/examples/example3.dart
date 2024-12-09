import 'package:element_docs/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class Example3 extends StatelessWidget {
  const Example3({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title),
        const CodeExample(
          code: code,
          children: [
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
    // 创建 GlobalKey 访问 ElLayoutState 内部方法
    final layoutKey = useGlobalKey<ElLayoutState>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElButton(
          onPressed: () {
            layoutKey.currentState!.resetLayout();
          },
          type: El.primary,
          child: '重置布局',
        ),
        const Gap(8),
        SizedBox(
          height: 500,
          child: ElSplitResizerTheme(
            // 定义拖拽分割器主题样式
            data: const ElSplitResizerThemeData(size: 1),
            // 使用 Ring 在布局周围绘制边框
            child: ElRing(
              show: true,
              width: 1,
              offset: 0,
              color: context.elLayout.borderColor,
              child: ElLayout(
                key: layoutKey,
                cacheKey: 'layout_example3',
                navbar: const ElNavbar(enabledDrag: true),
                sidebar: const ElSidebar(
                  enabledDrag: true,
                  expandedBottom: true,
                ),
                rightSidebar: const ElSidebar(
                  enabledDrag: true,
                  expandedTop: true,
                  expandedBottom: true,
                ),
                body: const ElBody(),
                footer: const ElFooter(enabledDrag: true),
              ),
            ),
          ),
        ),
      ],
    );
  }

// Widget get list => Material(
//       child: ListView.builder(
//         itemCount: 20,
//         itemBuilder: (context, index) => CellWidget(
//           onTap: () {},
//           title: '列表-${index + 1}',
//         ),
//       ),
//     );
}

const String code = """
class _Example extends HookWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    // 创建 GlobalKey 访问 ElLayoutState 内部方法
    final layoutKey = useGlobalKey<ElLayoutState>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElButton(
          onPressed: () {
            layoutKey.currentState!.resetLayout();
          },
          type: El.primary,
          child: '重置布局',
        ),
        const Gap(8),
        SizedBox(
          height: 500,
          child: ElSplitResizerTheme(
            // 定义拖拽分割器主题样式
            data: ElSplitResizerThemeData(
              size: 1,
              activeColor: context.elTheme.primary,
            ),
            // 使用 Ring 在布局周围绘制边框
            child: ElRing(
              show: true,
              width: 1,
              offset: 0,
              color: context.elLayout.borderColor,
              child: ElLayout(
                key: layoutKey,
                cacheKey: 'layout_example3',
                navbar: const ElNavbar(enabledDrag: true),
                sidebar: const ElSidebar(
                  enabledDrag: true,
                  expandedBottom: true,
                ),
                rightSidebar: const ElSidebar(
                  enabledDrag: true,
                  expandedTop: true,
                  expandedBottom: true,
                ),
                body: const ElBody(),
                footer: const ElFooter(enabledDrag: true),
              ),
            ),
          ),
        ),
      ],
    );
  }
}""";
