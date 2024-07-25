import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_element_ui/src/components/others/divider.dart';
import 'package:flutter_element_ui/src/extensions/element.dart';
import 'package:flutter_element_ui/src/extensions/private.dart';

import '../../core.dart';
import '../../utils/icons.dart';
import '../../widgets/simple_widgets.dart';
import '../basic/icon.dart';
import '../others/hover.dart';

class _CollapseData extends InheritedWidget {
  const _CollapseData(
    this.modelValue,
    this.accordion,
    this.foldIcon,
    this.expandedIcon,
    this.onChanged, {
    required super.child,
  });

  final ValueNotifier<List> modelValue;
  final bool accordion;
  final Widget? foldIcon;
  final Widget? expandedIcon;
  final void Function(List value)? onChanged;

  static _CollapseData of(BuildContext context) {
    final _CollapseData? result =
        context.dependOnInheritedWidgetOfExactType<_CollapseData>();
    assert(result != null, 'No _CollapseData found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_CollapseData oldWidget) => true;
}

/// 折叠菜单
class ElCollapse extends StatelessWidget {
  const ElCollapse(
    this.modelValue, {
    super.key,
    required this.children,
    this.accordion = false,
    this.foldIcon,
    this.expandedIcon,
    this.onChanged,
  });

  /// 当前激活的面板
  final ValueNotifier<List> modelValue;

  /// 折叠菜单子项列表
  final List<ElCollapseItem> children;

  /// 是否手风琴模式，默认false
  final bool accordion;

  /// 折叠图标，默认下箭头
  final Widget? foldIcon;

  /// 展开图标，默认上箭头
  final Widget? expandedIcon;

  /// 更新事件
  final void Function(List value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return _CollapseData(
      modelValue,
      accordion,
      foldIcon,
      expandedIcon,
      onChanged,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: context.elTheme.borderColor),
          borderRadius: el.config.cardRadius,
        ),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: children.length,
          itemBuilder: (context, index) => ElChildIndexData(
            index: index,
            start: 0,
            end: children.length - 1,
            child: children[index],
          ),
          separatorBuilder: ElDivider.buildSeparatorWidget(context),
        ),
      ),
    );
  }
}

class ElCollapseItem extends StatelessWidget {
  const ElCollapseItem({
    super.key,
    required this.id,
    required this.title,
    required this.child,
  });

  /// 唯一标识符
  final dynamic id;

  /// 标题，如果是 [Widget] 则直接渲染，否则当做 [Text] 渲染
  final dynamic title;

  /// 收缩组件
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final $data = _CollapseData.of(context);
    final $indexData = ElChildIndexData.of(context);
    final elConfig = el.config;
    final $cardRadius = elConfig.cardRadius;
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElHover(
            onlyCursor: true,
            cursor: SystemMouseCursors.click,
            builder: (isHover) {
              return GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  final listData = [...$data.modelValue.value];
                  $data.modelValue.value.contains(id)
                      ? listData.remove(id)
                      : listData.add(id);
                  if ($data.accordion) {
                    listData.removeWhere((e) => e != id);
                  }
                  $data.modelValue.value = listData;
                },
                child: ValueListenableBuilder(
                  valueListenable: $data.modelValue,
                  builder: (context, value, _) {
                    bool isActive = value.contains(id);
                    return AnimatedContainer(
                      duration: elConfig.bgDuration,
                      height: elConfig.baseWidgetHeight,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: isActive
                            ? context.elTheme.primary
                            : context.elTheme.bgColor,
                        borderRadius: $indexData.index == $indexData.start
                            ? BorderRadius.only(
                                topLeft: $cardRadius.topLeft,
                                topRight: $cardRadius.topRight,
                              )
                            : $indexData.index == $indexData.end && !isActive
                                ? BorderRadius.only(
                                    bottomLeft: $cardRadius.bottomLeft,
                                    bottomRight: $cardRadius.bottomRight,
                                  )
                                : null,
                      ),
                      child: Row(
                        children: [
                          title is Widget
                              ? title
                              : DefaultTextStyle.merge(
                                  style: TextStyle(
                                    color: context.isDark
                                        ? context.elTheme.textColor
                                        : isActive
                                            ? el.darkTheme.textColor
                                            : el.lightTheme.textColor,
                                  ),
                                  child: Text('$title'),
                                ),
                          const Expanded(child: SizedBox()),
                          ElIconTheme(
                            color: context.isDark
                                ? context.elTheme.textColor
                                : isActive
                                    ? el.darkTheme.textColor
                                    : el.lightTheme.textColor,
                            child: isActive
                                ? $data.expandedIcon ??
                                    const ElIcon(ElIcons.arrowUp)
                                : $data.foldIcon ??
                                    const ElIcon(ElIcons.arrowDown),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
          ValueListenableBuilder(
            valueListenable: $data.modelValue,
            builder: (context, value, _) {
              return AnimatedCrossFade(
                firstChild: const SizedBox(width: double.infinity, height: 0),
                secondChild: child,
                firstCurve:
                    const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
                secondCurve:
                    const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
                sizeCurve: Curves.fastOutSlowIn,
                crossFadeState: value.contains(id)
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: el.config.collapseDuration,
              );
            },
          ),
        ],
      ),
    );
  }
}
