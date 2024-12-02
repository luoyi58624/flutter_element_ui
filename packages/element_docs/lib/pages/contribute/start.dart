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
          '对于用户而言，我推荐你只使用 element_plus 包，其他包的 api 改动非常频繁，将它们分离出去的目的就是不希望用户使用它们。',
          '例如 element_generator，代码生成器是我第一次学习元编程时直接编写的，它们的实现很简陋，许多地方欠缺思考，'
              '但对于 element 主题生成来说，这已经足够了。',
          '其次是 flutter_obs，它的定位只是一个简单的状态管理，所以只适合用于小项目，'
              '在实际项目中我更推荐你使用比较成熟的状态管理库：Getx、Provider、Riverpod、Bloc、MobX...',
        ],
      ),
    ];
  }
}
