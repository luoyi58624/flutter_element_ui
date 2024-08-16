import 'package:flutter/widgets.dart';

import '../widgets/slide.dart';

class GuideLayoutPage extends StatelessWidget {
  const GuideLayoutPage({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SlideWidget([
          (
            '基础',
            [
              ('设计', '/guide/design'),
              ('导航', '/guide/nav'),
              ('安装', '/guide/install'),
              ('快速开始', '/guide/quickstart'),
            ],
          ),
          (
            '进阶',
            [
              ('国际化', '/guide/i18n'),
              ('主题', '/guide/theme'),
              ('更新日志', '/guide/changelog'),
            ],
          ),
          (
            '开发',
            [
              ('开发指南', '/guide/dev-guide'),
              ('开发常见问题', '/guide/dev-faq'),
              ('提交示例', '/guide/commit-examples'),
              ('翻译', '/guide/translation'),
            ],
          ),
        ]),
        Expanded(child: child),
      ],
    );
  }
}
