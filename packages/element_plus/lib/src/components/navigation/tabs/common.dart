import 'package:flutter/widgets.dart';

import '../../../models/tab.dart';
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

class TabsProp {
  /// [ElTabs] 当前主题数据
  final ElTabsThemeData themeData;

  /// [ElTabs] 子标签集合
  final List<ElTabModel> children;

  TabsProp({
    required this.themeData,
    required this.children,
  });
}
