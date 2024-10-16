import 'package:flutter/widgets.dart';

import '../../../themes/components/navigation/tabs.dart';
import 'index.dart';

class TabsInheritedWidget extends InheritedWidget {
  const TabsInheritedWidget({
    super.key,
    required super.child,
    required this.prop,
  });

  final TabsProp prop;

  static TabsInheritedWidget of(BuildContext context) {
    final TabsInheritedWidget? result =
        context.dependOnInheritedWidgetOfExactType<TabsInheritedWidget>();
    assert(result != null, 'No TabsInheritedWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TabsInheritedWidget oldWidget) => true;
}

/// [ElTabs] 提供的数据
class TabsProp {
  /// [ElTabs] 当前主题数据
  final ElTabsThemeData themeData;

  /// 激活的标签索引
  final int activeIndex;

  TabsProp({
    required this.themeData,
    required this.activeIndex,
  });
}
