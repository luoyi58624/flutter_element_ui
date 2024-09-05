import 'package:docs/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const Gap(32),
              H1('Element UI',
                  style: context.sm ? null : const TextStyle(fontSize: 48)),
              const Gap(16),
              const ElText('基于 Flutter，面向设计师和开发者的组件库'),
              const Gap(32),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 640,
                ),
                child: const AspectRatio(
                  aspectRatio: 1 / 0.6,
                  child: ElImage(src: 'assets/images/home/theme.png'),
                ),
              ),
              const Gap(32),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 1024,
                ),
                child: context.sm
                    ? Column(children: cardWidgets)
                    : Row(children: cardWidgets),
              ),
            ],
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
          '/component/element',
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
  const _CardWidget(this.image, this.title, this.content, this.href);

  final String image;
  final String title;
  final String content;
  final String href;

  @override
  Widget build(BuildContext context) {
    Widget result = Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedContainer(
        duration: el.themeDuration,
        decoration: BoxDecoration(
          color: context.elTheme.cardColor,
          border: Border.all(color: context.elTheme.borderColor),
          borderRadius: el.config.cardRadius,
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
            Container(
              height: 120,
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: ElText(
                content,
                style: TextStyle(
                  fontSize: 14,
                  color:
                      context.isDark ? Colors.grey.shade300 : Colors.blueGrey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const ElDivider(),
            TapBuilder(builder: (context) {
              return ElLink(
                href: href,
                child: Builder(builder: (context) {
                  return GestureDetector(
                    onTapDown: (e) {
                      HapticFeedback.mediumImpact();
                    },
                    onTap: () {
                      context.go(href);
                    },
                    child: AnimatedContainer(
                      duration: el.themeDuration,
                      height: 50,
                      decoration: BoxDecoration(
                        color:
                            TapBuilder.of(context) || HoverBuilder.of(context)
                                ? context.elTheme.primary
                                : context.elTheme.cardColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: el.config.cardRadius.bottomLeft,
                          bottomRight: el.config.cardRadius.bottomRight,
                        ),
                      ),
                      child: Center(
                        child: ElText(
                          '查看详情',
                          style: TextStyle(
                            color: TapBuilder.of(context) ||
                                    HoverBuilder.of(context)
                                ? Colors.white
                                : context.elTheme.primary,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              );
            }),
          ],
        ),
      ),
    );
    return context.sm ? result : Expanded(child: result);
  }
}
