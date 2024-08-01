import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/extensions/element.dart';
import 'package:flutter_element_ui/src/extensions/private.dart';
import 'package:gap/gap.dart';
import 'package:luoyi_dart_base/luoyi_dart_base.dart';

import '../../../core.dart';
import '../../../utils/font.dart';
import '../../../utils/icons.dart';
import '../../../widgets/animation.dart';
import '../../../widgets/custom_layout.dart';
import '../../../widgets/hover.dart';
import '../../../widgets/simple_widgets.dart';
import '../../basic/icon.dart';
import '../../typography/text.dart';
import 'base_tab.dart';

/// 谷歌风格标签页离顶部有4px的间距
const double _paddingTop = 4.0;

class ElGoogleTabs extends ElBaseTabs {
  /// 谷歌浏览器风格标签页
  const ElGoogleTabs(
    super.modelValue, {
    super.key,
    required super.children,
    super.height = 40,
    super.fontSize = 13,
    super.childMaxWidth = 200,
    super.bgColor,
    super.enabledAnimate,
    super.duration,
    super.curve,
  });

  @override
  State<ElGoogleTabs> createState() => _ElGoogleTabsState();
}

typedef _TabLayoutType = (double offset, Size size);

class _ElGoogleTabsState extends ElBaseTabsState<ElGoogleTabs> {
  /// 保存标签布局信息
  List<_TabLayoutType> tabLayoutList = [];

  void setLayoutList(List<_TabLayoutType> list) {
    tabLayoutList = list;
  }

  @override
  Color get bgColor =>
      widget.bgColor ??
      (context.isDark ? Colors.grey.shade800 : Colors.grey.shade300);

  @override
  EdgeInsetsGeometry get tabPadding => const EdgeInsets.only(top: _paddingTop);

  @override
  Widget buildTabs(BuildContext context) {
    final $tabsData = ElBaseTabsData.of(context);
    final layoutHeight = $tabsData.height - _paddingTop;
    final radius = layoutHeight / 4 * 3;
    final layoutWidth = widget.childMaxWidth +
        (widget.childMaxWidth - radius) * ($tabsData.children.length - 1);
    return _GoogleTabsData(
      layoutHeight,
      radius,
      child: Stack(
        children: [
          ElCustomMultiChildLayout(
            width: layoutWidth,
            delegateBuilder: (updateSize, isReBuild) =>
                _GoogleTabLayoutDelegate(
              updateSize,
              $tabsData.children.length,
              widget.childMaxWidth,
              radius,
              setLayoutList,
            ),
            children: [
              ...widget.children.mapIndexed(
                (i, e) => ElChildIndexData(
                  index: i,
                  child: LayoutId(
                      id: i,
                      child: ClipPath(
                        clipper: _GoogleTabClipper(radius),
                        child: e,
                      )),
                ),
              ),
            ],
          ),
          ValueListenableBuilder(
            valueListenable: $tabsData.modelValue,
            builder: (context, value, _) {
              if (tabLayoutList.isEmpty) return const SizedBox();
              final tabLayout = tabLayoutList[value];
              Widget result = ClipPath(
                clipper: _GoogleTabClipper(radius),
                child: _TabActiveLayer(tabLayout.$2),
              );
              if (widget.enabledAnimate) {
                return AnimatedPositioned(
                  duration: widget.duration ?? el.config.globalDuration,
                  curve: widget.curve,
                  left: tabLayout.$1,
                  child: result,
                );
              } else {
                return Positioned(
                  left: tabLayout.$1,
                  child: result,
                );
              }
            },
          )
        ],
      ),
    );
  }
}

class ElGoogleTab extends ElBaseTab {
  const ElGoogleTab({
    super.key,
    required super.title,
    super.disabled,
    super.closable,
  });

  @override
  Widget buildTab(BuildContext context) {
    final $tabsData = ElBaseTabsData.of(context);
    final $googleTabData = _GoogleTabsData.of(context);
    return ColoredBox(
      color: HoverBuilder.of(context)
          ? context.isDark
              ? context.elTheme.primary.light1(context)
              : Colors.grey.shade100
          : Colors.transparent,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 0,
          maxWidth: $tabsData.childMaxWidth,
        ),
        child: SizedBox(
          height: $googleTabData.height,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: $googleTabData.radius),
            child: Row(
              children: [
                Expanded(
                  child: ElText(
                    title,
                    style: TextStyle(
                      fontSize: $tabsData.fontSize,
                      fontWeight: ElFont.medium,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Gap(8),
                const ElIcon(Icons.close, size: 14),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 激活的标签页浮层
class _TabActiveLayer extends StatelessWidget {
  const _TabActiveLayer(this.size);

  final Size size;

  @override
  Widget build(BuildContext context) {
    final $tabsData = ElBaseTabsData.of(context);
    final $googleTabData = _GoogleTabsData.of(context);
    Widget result = Padding(
      padding: EdgeInsets.symmetric(horizontal: $googleTabData.radius),
      child: Row(
        children: [
          Expanded(
            child: ElText(
              $tabsData.children[$tabsData.modelValue.value].title,
              style: TextStyle(
                fontSize: $tabsData.fontSize,
                fontWeight: ElFont.medium,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Gap(8),
          const ElIcon(Icons.close, size: 14),
        ],
      ),
    );
    return AnimatedColoredBox(
      duration: el.config.colorDuration,
      color: context.isDark ? context.elTheme.primary : Colors.white,
      child: $tabsData.enabledAnimate
          ? AnimatedContainer(
              duration: $tabsData.duration ?? el.config.globalDuration,
              curve: $tabsData.curve,
              width: size.width,
              height: size.height,
              child: result,
            )
          : SizedBox(
              width: size.width,
              height: size.height,
              child: result,
            ),
    );
  }
}

class _GoogleTabsData extends InheritedWidget {
  const _GoogleTabsData(
    this.height,
    this.radius, {
    required super.child,
  });

  final double height;
  final double radius;

  static _GoogleTabsData of(BuildContext context) {
    final _GoogleTabsData? result =
        context.dependOnInheritedWidgetOfExactType<_GoogleTabsData>();
    assert(result != null, 'No _GoogleTabsData found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_GoogleTabsData oldWidget) => true;
}

class _GoogleTabLayoutDelegate extends MultiChildLayoutDelegate {
  _GoogleTabLayoutDelegate(
    this.updateSize,
    this.length,
    this.maxWidth,
    this.radius,
    this.setLayoutList,
  );

  /// 更新布局尺寸回调函数
  final ElUpdateCustomLayoutSize updateSize;

  /// 标签数量
  final int length;

  /// 子标签最大宽度
  final double maxWidth;

  /// 以标签页的圆角值作为每个标签的偏移值
  final double radius;

  final void Function(List<_TabLayoutType> list) setLayoutList;

  @override
  void performLayout(Size size) {
    if (length == 0) return;
    List<_TabLayoutType> tabLayoutList = [];
    final constraint = BoxConstraints(minWidth: 0, maxWidth: maxWidth);
    Size firstSize = layoutChild(0, constraint);
    double parentWidth = firstSize.width;
    tabLayoutList.add((0, firstSize));
    for (int i = 1; i < length; i++) {
      final currentSize = layoutChild(i, constraint);
      final offset = parentWidth - radius;
      positionChild(i, Offset(offset, 0));
      parentWidth += currentSize.width - radius;
      tabLayoutList.add((offset, currentSize));
    }
    setLayoutList(tabLayoutList);
    // 布局完成设置外围标签页容器的实际尺寸
    updateSize(Size(parentWidth, size.height));
  }

  @override
  bool shouldRelayout(_GoogleTabLayoutDelegate oldDelegate) {
    return true;
  }
}

class _GoogleTabClipper extends CustomClipper<Path> {
  final double r;

  _GoogleTabClipper(this.r);

  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;
    final path = Path()
      ..moveTo(0, h)
      ..cubicTo(r, h, 0, 0, r, 0)
      ..lineTo(w - r, 0)
      ..cubicTo(w, 0, w - r, h, w, h);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<dynamic> oldClipper) {
    return true;
  }
}
