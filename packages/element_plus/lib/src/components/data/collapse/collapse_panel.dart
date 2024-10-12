import 'package:element_plus/src/global.dart';
import 'package:flutter/widgets.dart';

import '../../others/divider.dart';

class _CollapseData extends InheritedWidget {
  const _CollapseData(
    this.modelValue,
    this.height,
    this.accordion,
    this.foldIcon,
    this.expandedIcon,
    this.onChanged, {
    required super.child,
  });

  final ValueNotifier<List> modelValue;
  final double height;
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
class ElCollapsePanel extends StatelessWidget {
  const ElCollapsePanel(
    this.modelValue, {
    super.key,
    required this.children,
    this.accordion = false,
    this.height = 50,
    this.foldIcon,
    this.expandedIcon,
    this.onChanged,
  });

  /// 当前激活的面板
  final ValueNotifier<List> modelValue;

  /// 折叠菜单子项列表
  final List<ElCollapseItem> children;

  /// 折叠菜单高度
  final double height;

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
      height,
      accordion,
      foldIcon,
      expandedIcon,
      onChanged,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: context.elTheme.colors.border),
          borderRadius: context.elTheme.cardTheme.radius,
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

    final $cardRadius = context.elTheme.cardTheme.radius;
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          HoverBuilder(
            onlyCursor: true,
            cursor: SystemMouseCursors.click,
            builder: (context) {
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
                      duration: context.elConfig.themeDuration,
                      height: $data.height,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: isActive
                            ? context.elTheme.primary
                            : context.elTheme.colors.bg,
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
                              : ElDefaultTextStyle.merge(
                                  style: TextStyle(
                                    color: context.isDark
                                        ? context.elTheme.colors.text
                                        : isActive
                                            ? context.darkTheme.colors.text
                                            : context.lightTheme.colors.text,
                                  ),
                                  child: Text('$title'),
                                ),
                          const Expanded(child: SizedBox()),
                          ElIconTheme(
                            color: context.isDark
                                ? context.elTheme.colors.text
                                : isActive
                                    ? context.darkTheme.colors.text
                                    : context.lightTheme.colors.text,
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
                duration: 250.ms,
              );
            },
          ),
        ],
      ),
    );
  }
}
