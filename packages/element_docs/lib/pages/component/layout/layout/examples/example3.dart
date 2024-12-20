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
            data: ElSplitResizerThemeData(
              size: 1,
              activeColor: context.elTheme.primary,
            ),
            // 使用 Ring 在布局周围绘制边框
            child: ElRing(
              show: true,
              width: 1,
              offset: 0,
              color: context.elTheme.borderColor,
              child: ElLayout(
                key: layoutKey,
                cacheKey: 'layout_example3',
                navbar: ElNavbar(
                  enabledDrag: true,
                  minHeight: 56,
                  child: buildNavbar(context),
                ),
                sidebar: ElSidebar(
                  enabledDrag: true,
                  expandedBottom: true,
                  minWidth: 150,
                  child: buildSlider(context),
                ),
                rightSidebar: ElSidebar(
                  enabledDrag: true,
                  expandedTop: true,
                  minWidth: 150,
                  child: buildSlider(context),
                ),
                body: const ElBody(
                  minWidth: 320,
                ),
                footer: const ElFooter(enabledDrag: true),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildNavbar(BuildContext context) {
    // i(context.elLayout.navbarColor);
    return Container(
      color: context.elTheme.navbarColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Row(
          children: [
            buildIconButton(context, Icons.menu),
            const Gap(8),
            const ElText(
              'Title',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            buildIconButton(context, Icons.search),
            buildIconButton(context, Icons.favorite_border_outlined),
            buildIconButton(context, Icons.more_vert_outlined),
          ],
        ),
      ),
    );
  }

  Widget buildSlider(BuildContext context) => Material(
        color: context.elTheme.sidebarColor,
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) => CellWidget(
            onTap: () {},
            title: '列表-${index + 1}',
          ),
        ),
      );

  Widget buildIconButton(BuildContext context, IconData iconData) {
    final color = context.isDark ? Colors.white12 : Colors.black12;
    return IconButton(
      onPressed: () {},
      hoverColor: color,
      focusColor: color,
      highlightColor: color,
      splashColor: Colors.grey,
      constraints: BoxConstraints.tight(const Size(48, 48)),
      icon: Icon(
        iconData,
        color: context.isDark ? Colors.grey.shade200 : Colors.grey.shade800,
      ),
    );
  }
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
              color: context.elTheme.borderColor,
              child: ElLayout(
                key: layoutKey,
                cacheKey: 'layout_example3',
                navbar: ElNavbar(
                  enabledDrag: true,
                  minHeight: 56,
                  child: buildNavbar(context),
                ),
                sidebar: ElSidebar(
                  enabledDrag: true,
                  expandedBottom: true,
                  minWidth: 150,
                  child: buildSlider(context),
                ),
                rightSidebar: ElSidebar(
                  enabledDrag: true,
                  expandedTop: true,
                  minWidth: 150,
                  child: buildSlider(context),
                ),
                body: const ElBody(
                  minWidth: 320,
                ),
                footer: const ElFooter(enabledDrag: true),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildNavbar(BuildContext context) {
    // i(context.elLayout.navbarColor);
    return Container(
      color: context.elTheme.navbarColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Row(
          children: [
            buildIconButton(context, Icons.menu),
            const Gap(8),
            const ElText(
              'Title',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            buildIconButton(context, Icons.search),
            buildIconButton(context, Icons.favorite_border_outlined),
            buildIconButton(context, Icons.more_vert_outlined),
          ],
        ),
      ),
    );
  }

  Widget buildSlider(BuildContext context) => Material(
        color: context.elTheme.sidebarColor,
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) => CellWidget(
            onTap: () {},
            title: '列表-\${index + 1}',
          ),
        ),
      );

  Widget buildIconButton(BuildContext context, IconData iconData) {
    final color = context.isDark ? Colors.white12 : Colors.black12;
    return IconButton(
      onPressed: () {},
      hoverColor: color,
      focusColor: color,
      highlightColor: color,
      splashColor: Colors.grey,
      constraints: BoxConstraints.tight(const Size(48, 48)),
      icon: Icon(
        iconData,
        color: context.isDark ? Colors.grey.shade200 : Colors.grey.shade800,
      ),
    );
  }
}""";
