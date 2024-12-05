import 'dart:convert';
import 'dart:math';

import 'package:element_plus/element_plus.dart';
import 'package:element_plus/src/global.dart';
import 'package:flutter/material.dart';

part 'state.dart';

part 'theme.dart';

part '../../../generates/components/layout/layout/index.g.dart';

class ElLayout extends StatefulWidget {
  const ElLayout({
    super.key,
    this.navbar,
    this.body,
    this.sidebar,
    this.rightSidebar,
    this.footer,
    this.topToolbar,
    this.leftToolbar,
    this.rightToolbar,
    this.bottomToolbar,
    this.cacheKey,
  });

  /// 顶部导航栏
  final ElNavbar? navbar;

  /// 布局的主要内容区域
  final ElBody? body;

  /// 左边侧边栏，当窗口为移动端尺寸时，会自动收起
  final ElSidebar? sidebar;

  /// 右边侧边栏
  final ElSidebar? rightSidebar;

  /// 底部区域栏
  final ElFooter? footer;

  /// 顶部工具栏，它位于 [navbar] 下方
  final ElToolbar? topToolbar;

  /// 左侧工具栏，它位于 [sidebar] 左边
  final ElToolbar? leftToolbar;

  /// 右侧工具栏，它位于 [rightSidebar] 右边
  final ElToolbar? rightToolbar;

  /// 底部工具栏，它位于 [footer] 下方
  final ElToolbar? bottomToolbar;

  /// 持久化缓存 key
  final String? cacheKey;

  /// 访问 [ElLayout] 布局信息
  static ElLayoutData of(BuildContext context) =>
      _LayoutInheritedWidget.of(context);

  @override
  State<ElLayout> createState() => ElLayoutState();
}

@ElModel.all()
class ElLayoutData implements ElSerializeModel<ElLayoutData> {
  /// 导航头位置
  double navbar;

  /// 侧边栏位置
  double sidebar;

  /// 右边侧边栏位置
  double rightSidebar;

  /// 底部区域栏位置
  double footer;

  ElLayoutData({
    required this.navbar,
    required this.sidebar,
    required this.rightSidebar,
    required this.footer,
  });

  factory ElLayoutData.fromJson(Map<String, dynamic>? json) => _fromJson(json);

  @override
  ElLayoutData fromJson(Map<String, dynamic>? json) => _fromJson(json);

  @override
  Map<String, dynamic> toJson() => _toJson();

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

class _LayoutInheritedWidget extends InheritedWidget {
  const _LayoutInheritedWidget(
    this.layoutData, {
    required super.child,
  });

  final ElLayoutData layoutData;

  static ElLayoutData of(BuildContext context) {
    final _LayoutInheritedWidget? result =
        context.dependOnInheritedWidgetOfExactType<_LayoutInheritedWidget>();
    assert(result != null, 'No _LayoutInheritedWidget found in context');
    return result!.layoutData;
  }

  @override
  bool updateShouldNotify(_LayoutInheritedWidget oldWidget) => true;
}
