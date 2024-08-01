import 'package:flutter/widgets.dart';
import 'package:flutter_obs/flutter_obs.dart';

import 'base.dart';

class TabsData extends InheritedWidget {
  const TabsData(
    this.modelValue,
    this.children,
    this.type,
    this.height,
    this.fontSize,
    this.childMaxWidth,
    this.bgColor,
    this.enabledAnimate,
    this.duration,
    this.curve, {
    super.key,
    required super.child,
  });

  final ValueNotifier<int> modelValue;
  final ValueNotifier<List<ElBaseTab>> children;
  final ElTabType? type;
  final double height;
  final double fontSize;
  final double childMaxWidth;
  final Color bgColor;
  final bool enabledAnimate;
  final Duration? duration;
  final Curve curve;

  static TabsData of(BuildContext context) {
    final TabsData? result =
        context.dependOnInheritedWidgetOfExactType<TabsData>();
    assert(result != null, 'No TabsData found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TabsData oldWidget) => true;
}

class GoogleTabsData extends InheritedWidget {
  const GoogleTabsData(
    this.height,
    this.radius, {
    super.key,
    required super.child,
  });

  final double height;
  final double radius;

  static GoogleTabsData of(BuildContext context) {
    final GoogleTabsData? result =
        context.dependOnInheritedWidgetOfExactType<GoogleTabsData>();
    assert(result != null, 'No GoogleTabsData found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(GoogleTabsData oldWidget) => true;
}
