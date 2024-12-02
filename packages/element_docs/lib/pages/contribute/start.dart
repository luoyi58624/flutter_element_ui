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
          '出于一些因素考虑，我推荐你只使用 element_plus 包，不要使用存储库中的其他包。',
          '例如 element_dart、element_flutter 这两个库封装的 api 就是不希望暴露给用户，'
              '我不喜欢一个库给用户塞太多乱七八糟的 api。',
          '而 element_annotation、element_generator 代码生成器是我第一次学习元编程时直接编写的，它们的实现很简陋，许多地方欠缺考虑，'
              '但对于 element 主题生成来说，这已经足够了。',
          '最后是 flutter_obs，它的定位只是一个简单的状态管理，'
              '在实际项目中我更推荐你使用成熟的状态管理库：Getx、Provider、Riverpod、Bloc、MobX...',
        ],
      ),
    ];
  }
}
