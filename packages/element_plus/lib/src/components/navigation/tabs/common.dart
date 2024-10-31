import 'package:flutter/widgets.dart';

import '../../../themes/components/navigation/tabs.dart';
import '../tab/index.dart';
import 'index.dart';

class ElTabsInheritedWidget extends InheritedWidget {
  const ElTabsInheritedWidget({
    super.key,
    required super.child,
    required this.data,
  });

  final ElTabsData data;

  static ElTabsInheritedWidget of(BuildContext context) {
    final ElTabsInheritedWidget? result =
        context.dependOnInheritedWidgetOfExactType<ElTabsInheritedWidget>();
    assert(result != null, 'No ElTabsInheritedWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ElTabsInheritedWidget oldWidget) => true;
}

/// [ElTabs] 提供的数据
class ElTabsData {
  /// 激活的标签索引
  final int activeIndex;
  final ElTabsThemeData theme;
  final double size;
  final AxisDirection direction;
  final Axis axis;
  final Color bgColor;
  final List<ElTab> tabs;
  final void Function(List<ElTab> tabs)? onDragChanged;

  ElTabsData({
    required this.activeIndex,
    required this.theme,
    required this.size,
    required this.direction,
    required this.axis,
    required this.bgColor,
    required this.tabs,
    required this.onDragChanged,
  });
}
