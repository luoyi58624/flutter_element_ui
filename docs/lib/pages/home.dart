import 'package:docs/global.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const H1(
                  'Element UI',
                  style: TextStyle(fontSize: 28),
                ),
                const Gap(8),
                const ElText(
                  '基于 Flutter，面向设计师和开发者的组件库',
                  textAlign: TextAlign.center,
                ),
                const Gap(16),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 640,
                  ),
                  child: const ElImage(src: 'assets/images/home/theme.png'),
                ),
                const Gap(16),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 960,
                  ),
                  child: context.sm
                      ? Column(children: cardWidgets)
                      : Row(children: cardWidgets),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> get cardWidgets => const [
        _CardWidget(
          'assets/images/home/1.png',
          '指南',
          '了解设计指南，帮助产品设计人员搭建逻辑清晰、结构合理且高效易用的产品。',
          '/guide/design',
        ),
        _CardWidget(
          'assets/images/home/2.png',
          '组件',
          '使用组件 Demo 快速体验交互细节；使用前端框架封装的代码帮助工程师快速开发。',
          '/component/overview',
        ),
        _CardWidget(
          'assets/images/home/3.png',
          '资源',
          '下载相关资源，用其快速搭建页面原型或高保真视觉稿，提升产品设计效率。',
          '/resource',
        ),
      ];
}

class _CardWidget extends StatelessWidget {
  const _CardWidget(this.image, this.title, this.content, this.path);

  final String image;
  final String title;
  final String content;
  final String path;

  @override
  Widget build(BuildContext context) {
    Widget result = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: context.elTheme.borderColor),
          borderRadius: context.elConfig.cardRadius,
        ),
        child: Column(
          children: [
            const Gap(32),
            SizedBox(
              width: 100,
              height: 100,
              child: Center(child: ElImage(src: image, width: 100)),
            ),
            const Gap(24),
            H4(title),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElText(
                content,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.blueGrey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Gap(24),
            const ElDivider(),
            SelectionContainer.disabled(
              child: ElHover(
                cursor: SystemMouseCursors.click,
                builder: (isHover) {
                  return GestureDetector(
                    onTap: () {
                      context.go(path);
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: isHover ? context.elTheme.primary : Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: context.elConfig.cardRadius.bottomLeft,
                          bottomRight: context.elConfig.cardRadius.bottomRight,
                        ),
                      ),
                      child: Center(
                        child: ElText(
                          '查看详情',
                          style: TextStyle(
                            color: isHover
                                ? Colors.white
                                : context.elTheme.primary,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
    return context.sm ? result : Expanded(child: result);
  }
}
