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
          ElText(
            [
              '传统 Flutter 的项目通常允许用户配置 global_theme，例如 Material 中的 ',
              LinkWidgets.themeData,
              '、Cupertino 中的 ',
              LinkWidgets.cupertinoThemeData,
              '，同时还提供了许多局部主题小部件：',
              LinkWidgets.buttonTheme,
              '、',
              LinkWidgets.sliderTheme,
              '，这些主题代码在 element_ui 中全部是自动生成，在开始之前请记住主题合并规则：'
                  'component_theme -> local_theme -> global_theme',
            ],
          ),
        ],
      ),
      const SectionTitle('1. 运行代码生成器'),
      const ElImage(src: 'assets/images/contribute/theme_build_runner.png'),
      const SectionTitle('2. 局部主题代码生成（ElButtonTheme）'),
      const SectionCard(
        title: 'Tip',
        content: [
          '下面 2 张截图列举了局部主题生成步骤，主要就是添加 ElModel、ElThemeModel 两个注解，'
              '当运行代码生成器时会在 generates 目录下生成代码。'
        ],
      ),
      textGap,
      const ElImage(src: 'assets/images/contribute/button_local_theme.png'),
      textGap,
      const ElImage(src: 'assets/images/contribute/button_generate_dir.png'),
      const SectionTitle('3. 全局主题'),
      const SectionCard(
        title: 'Tip',
        content: [
          'ElGlobalThemeModel 注解表示生成全局主题，这个注解的生成器会最后运行，'
              '每次扫描 ElThemeModel 注解时生成器会将当前主题 class 添加加 Set 集合中，'
              '最后运行全局主题代码生成器时，会根据 Set 集合中的主题类生成全局主题代码。'
        ],
      ),
      textGap,
      const ElImage(src: 'assets/images/contribute/global_theme_generate.png'),
      const SectionTitle('4. 代码生成器配置'),
      const SectionCard(
        title: 'Tip',
        content: ['最后贴上代码生成器配置 build.yaml'],
      ),
      textGap,
      const ElImage(src: 'assets/images/contribute/code_generate_build.png'),
    ];
  }
}
