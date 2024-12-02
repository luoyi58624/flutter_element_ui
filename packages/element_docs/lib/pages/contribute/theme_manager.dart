import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

class ThemeManagerPage extends ResponsivePage {
  const ThemeManagerPage({super.key});

  @override
  String get title => '主题管理';

  @override
  List<Widget> buildPage(BuildContext context) {
    return [
      textGap,
      const SectionCard(
        title: 'Tip',
        content: [
          '在开始前请自行配置好 Flutter 的开发环境，然后在 GitHub 上 Fork 此项目，拉取到本地后使用 Android Studio 打开'
        ],
      ),
      const SectionTitle('1. 初始化项目'),
      const ElImage(src: 'assets/images/contribute/initialize.png'),
      const SectionTitle('2. 运行项目'),
      const ElImage(src: 'assets/images/contribute/run.png'),
    ];
  }
}
