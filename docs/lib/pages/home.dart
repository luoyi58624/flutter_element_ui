import 'package:docs/global.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget buildHeader(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: [
            ElIcon(
              'assets/images/element-plus-logo.svg',
              color: context.elTheme.primary,
              size: 28,
              package: null,
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }

  Widget buildMain(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
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
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 640,
                ),
                child: const ElImage(src: 'assets/images/home/theme.png'),
              ),
              const Gap(16),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _CardWidget(
                    'assets/images/home/svg/guide.svg',
                    '指南',
                    '了解设计指南，帮助产品设计人员搭建逻辑清晰、结构合理且高效易用的产品。',
                  ),
                  _CardWidget(
                    'assets/images/home/svg/guide.svg',
                    '指南',
                    '了解设计指南，帮助产品设计人员搭建逻辑清晰、结构合理且高效易用的产品。',
                  ),
                  _CardWidget(
                    'assets/images/home/svg/guide.svg',
                    '指南',
                    '了解设计指南，帮助产品设计人员搭建逻辑清晰、结构合理且高效易用的产品。',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildHeader(context),
        const ElDivider(),
        buildMain(context),
      ],
    );
  }
}

class _CardWidget extends StatelessWidget {
  const _CardWidget(this.icon, this.title, this.content);

  final String icon;
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ElIcon(
            icon,
            color: context.elTheme.primary,
            size: 28,
            package: null,
          ),
        ],
      ),
    );
  }
}
