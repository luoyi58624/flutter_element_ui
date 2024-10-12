import 'package:element_plus/src/components/navigation/tabs/common.dart';
import 'package:element_plus/src/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../models/tab.dart';
import '../tab/index.dart';
import 'theme/default.dart';
import 'theme/material.dart';

part 'state.dart';

part 'style.dart';

part '../../../generates/components/navigation/tabs/index.g.dart';

class ElTabs extends ElModelValue<int> {
  const ElTabs(
    super.modelValue, {
    super.key,
    super.onChanged,
    this.controller,
    this.child = const ElDefaultTabs(),
    required this.children,
  });

  final TabController? controller;

  final Widget child;

  /// [ElTab] 子标签集合
  final List<ElTabModel> children;

  static TabsProp of(BuildContext context) =>
      TabsInheritedWidget.of(context).prop;

  @override
  State<ElTabs> createState() => _ElTabsState();
}
