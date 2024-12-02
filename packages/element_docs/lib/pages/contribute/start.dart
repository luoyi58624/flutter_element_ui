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
          ElText('element_dart - element dart 工具库，此库不对用户开放'),
          ElText('element_flutter - element flutter 工具库，此库不对用户开放'),
          ElText('element_annotation - 代码生成器注解包，此库不对用户开放'),
          ElText('element_generator - 代码生成器，此库不对用户开放'),
          ElText('flutter_obs - 简单的状态管理，此库不对用户开放'),
          ElText('flutter_base - 导出一些常用包、自定义公共 Api，此库不对用户开放'),
        ],
      ),
      textGap,
      const SectionCard(
        title: 'Tip',
        type: El.warning,
        content: [
          '对于用户而言，请只关注 element_plus 包，我不推荐你使用任何其他包，'
              '这是因为组件库本身就包含庞大的工作量，我没有更多精力去响应用户使用其他包带来的需求，'
              '其他包的任何功能都只服务于 element_plus 主包，它们的改动可能非常频繁，'
              '有些内容甚至只是我用于实验的功能。',
          '例如 element_generator，代码生成器是我第一次学习元编程时直接编写的，它们的实现很简陋，许多地方欠缺思考，'
              '但对于 element_plus 的主题生成来说，这已经足够了。',
          '其次是 flutter_obs，它的定位只是一个简单的状态管理，在 element_plus 中用于替代 ValueNotifier，'
              '我不会响应 flutter_obs 新功能需求，它只服务于 element_plus，所以我不推荐你在真实项目中使用它，'
              'Flutter 生态中已经拥有许多成熟的状态管理包：Getx、Provider、Riverpod、Bloc、MobX...',
        ],
      ),
    ];
  }
}
