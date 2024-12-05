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
    return SizedBox(
      height: 500,
      child: ElSplitResizerTheme(
        // 定义拖拽分割器主题样式
        data: ElSplitResizerThemeData(
          size: 1,
          activeColor: context.elTheme.primary,
        ),
        // 因为布局处于示例代码中，所以在整体布局周围绘制边框更好看一些，
        // 用轮廓环当做边框使用，好处是它的层级比子组件高，不会被子组件背景颜色遮挡
        child: ElRing(
          show: true,
          width: 1,
          offset: 0,
          color: context.elLayout.borderColor,
          child: const ElLayout(
            cacheKey: 'layout_example3',
            navbar: ElNavbar(enabledDrag: true),
            sidebar: ElSidebar(enabledDrag: true),
            rightSidebar: ElSidebar(enabledDrag: true),
            body: ElBody(),
            // footer: ElFooter(),
          ),
        ),
      ),
    );
  }
}

const String code = """
class _Example extends HookWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: ElSplitResizerTheme(
        // 定义拖拽分割器主题样式
        data: ElSplitResizerThemeData(
          size: 1,
          activeColor: context.elTheme.primary,
        ),
        // 因为布局处于示例代码中，所以在整体布局周围绘制边框更好看一些，
        // 用轮廓环当做边框使用，好处是它的层级比子组件高，不会被子组件背景颜色遮挡
        child: ElRing(
          show: true,
          width: 1,
          offset: 0,
          color: context.elLayout.borderColor,
          child: const ElLayout(
            cacheKey: 'layout_example3',
            navbar: ElNavbar(enabledDrag: true),
            sidebar: ElSidebar(enabledDrag: true),
            rightSidebar: ElSidebar(enabledDrag: true),
            body: ElBody(),
          ),
        ),
      ),
    );
  }
}""";
