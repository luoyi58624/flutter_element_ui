import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/extensions/element.dart';
import 'package:flutter_element_ui/src/extensions/private.dart';
import 'package:flutter_element_ui/src/widgets/hover.dart';

import '../../../core.dart';
import '../../../widgets/animation.dart';
import '../../../widgets/custom_layout.dart';
import '../../../widgets/simple_widgets.dart';
import '../../basic/scrollbar.dart';
import '../../typography/text.dart';

part 'tab.dart';

part 'types/google_tab.dart';

enum ElTabType {
  /// 传统卡片式标签
  card,

  /// 谷歌浏览器风格标签页
  google,
}

class ElTabs extends StatefulWidget {
  const ElTabs(
    this.modelValue, {
    super.key,
    required this.children,
    this.type,
    this.height = 36,
    this.fontSize = 13,
    this.maxWidth = 200,
    this.bgColor,
    this.expanded = false,
  });

  /// 选中的标签
  final ValueNotifier modelValue;

  /// 子标签集合
  final List<ElTab> children;

  /// 标签页风格类型
  final ElTabType? type;

  /// 标签页高度
  final double height;

  /// 标签字体大小
  final double fontSize;

  /// 每个子标签页的最大宽度
  final double maxWidth;

  /// 自定义标签页背景颜色
  final Color? bgColor;

  /// 子标签的宽度是否需要占据所有空间，此属性一般用于移动端场景，拥有已知数量的少量标签
  final bool expanded;

  @override
  State<ElTabs> createState() => _ElTabsState();
}

class _ElTabsState extends State<ElTabs> {
  final ScrollController scrollController = ScrollController();

  EdgeInsetsGeometry get tabPadding {
    if (widget.type == ElTabType.google) {
      return const EdgeInsets.only(top: _googleTabPadding);
    } else {
      return EdgeInsets.zero;
    }
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  Widget buildTab() {
    return Row(
      children: widget.children
          .mapIndexed((i, e) => ElChildIndexData(index: i, child: e))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color $bgColor = widget.bgColor ??
        (widget.type == null
            ? context.elTheme.bgColor
            : context.isDark
                ? Colors.grey.shade800
                : Colors.grey.shade300);
    late Widget result;

    if (widget.type == null || widget.type == ElTabType.card) {
      result = buildTab();
    } else {
      result = const _GoogleTabsWidget();
    }

    return _TabsInheritedWidget(
      widget.modelValue,
      widget.children,
      widget.type,
      widget.height,
      widget.fontSize,
      widget.maxWidth,
      widget.bgColor,
      child: SizedBox(
        width: double.infinity,
        height: widget.height,
        child: AnimatedColoredBox(
          duration: el.config.bgDuration,
          color: $bgColor,
          child: Padding(
            padding: tabPadding,
            child: Listener(
              onPointerSignal: (e) {
                if (e is PointerScrollEvent) {
                  scrollController.position.pointerScroll(e.scrollDelta.dy);
                }
              },
              child: ScrollConfiguration(
                behavior: const NoScrollBehavior(),
                child: SingleChildScrollView(
                  controller: scrollController,
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  child: result,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TabsInheritedWidget extends InheritedWidget {
  const _TabsInheritedWidget(
    this.modelValue,
    this.children,
    this.type,
    this.height,
    this.fontSize,
    this.maxWidth,
    this.bgColor, {
    required super.child,
  });

  final ValueNotifier modelValue;
  final List<ElTab> children;
  final ElTabType? type;
  final double height;
  final double fontSize;
  final double maxWidth;
  final Color? bgColor;

  static _TabsInheritedWidget of(BuildContext context) {
    final _TabsInheritedWidget? result =
        context.dependOnInheritedWidgetOfExactType<_TabsInheritedWidget>();
    assert(result != null, 'No _TabsInheritedWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_TabsInheritedWidget oldWidget) {
    return true;
  }
}
