import 'package:element_plus/src/global.dart';
import 'package:flutter/widgets.dart';

part 'state.dart';

part 'model.dart';

part 'theme.dart';

part '../../../generates/components/data/tree/index.g.dart';

/// 自定义 Map 数据结构 key 关键字
class ElTreeProps {
  /// 唯一标识
  final String key;

  /// 显示的名字
  final String label;

  /// 显示的图标
  final String icon;

  /// 嵌套 Map 数据
  final String children;

  const ElTreeProps({
    this.key = 'key',
    this.label = 'label',
    this.icon = 'icon',
    this.children = 'children',
  });
}

class ElTree extends StatefulWidget {
  /// Element UI 树形控件，请使用 [ElTreeTheme] 配置主题
  const ElTree({
    super.key,
    required this.data,
    this.props = const ElTreeProps(),
  });

  final List<Map<String, dynamic>> data;
  final ElTreeProps props;

  @override
  State<ElTree> createState() => _ElTreeState();
}
