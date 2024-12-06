import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

class ContributeStartPage extends ResponsivePage {
  const ContributeStartPage({super.key});

  @override
  String get title => '开始';

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
      const SectionTitle('3. 代码结构'),
      const SectionCard(
        title: 'packages 目录',
        content: [
          ElText('element_plus - 组件库'),
          ElText('element_docs - 组件文档'),
          ElText('element_test - 组件测试'),
          ElText('element_dart - element dart 工具库'),
          ElText('element_flutter - element flutter 工具库'),
          ElText('element_annotation - 代码生成器注解包'),
          ElText('element_generator - 代码生成器'),
          ElText('flutter_obs - 简单的状态管理，它只是对官方实现的 ValueNotifier 进行略微增强'),
          ElText('flutter_base - 导出一些常用包、自定义公共 Api'),
        ],
      ),
      textGap,
      const SectionCard(
        title: 'Tip',
        type: El.warning,
        content: [
          '对于用户而言，我推荐你只使用 element_plus、flutter_obs 包，其他包请不要使用，'
              '如果有想要的 api 请 copy 到自己封装的存储库中，因为这些 api 可能随时会改动'
        ],
      ),
    ];
  }
}
