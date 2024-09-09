import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/global.dart';

import '../../../../utils/font.dart';
import '../../../basic/icon.dart';
import '../../../basic/text.dart';
import '../base.dart';
import '../inherited_data.dart';

part 'tab.dart';

typedef _TabLayoutType = (double offset, Size size);

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
  }) : super(type: ElTabType.google);

  @override
  State<ElGoogleTabs> createState() => _ElGoogleTabsState();
}

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
  EdgeInsetsGeometry get tabPadding =>
      const EdgeInsets.only(top: googleTabPaddingTop);

  @override
  Widget buildTabs(BuildContext context) {
    final $tabsData = TabsData.of(context);
    final layoutHeight = $tabsData.height - googleTabPaddingTop;
    final radius = layoutHeight / 4 * 3;
    final layoutWidth = widget.childMaxWidth +
        (widget.childMaxWidth - radius) * ($tabsData.children.value.length - 1);
    return GoogleTabsData(
      layoutHeight,
      radius,
      child: ValueListenableBuilder(
        valueListenable: widget.children,
        builder: (context, children, _) {
          return Stack(
            children: [
              CustomMultiChildLayoutWidget(
                width: layoutWidth,
                delegateBuilder: (updateSize, isReBuild) =>
                    _GoogleTabLayoutDelegate(
                  updateSize,
                  $tabsData.children.value.length,
                  widget.childMaxWidth,
                  radius,
                  setLayoutList,
                ),
                children: [
                  ...children.mapIndexed(
                    (i, e) => ChildIndexData(
                      index: i,
                      child: LayoutId(
                        id: i,
                        child: ClipPath(
                          clipper: _GoogleTabClipper(radius),
                          child: e,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ValueListenableBuilder(
                valueListenable: $tabsData.modelValue,
                builder: (context, activeIndex, _) {
                  if (tabLayoutList.isEmpty) return const SizedBox();
                  final tabLayout = tabLayoutList[activeIndex];
                  Widget result = ClipPath(
                    clipper: _GoogleTabClipper(radius),
                    child: _TabActiveLayer(
                      activeIndex,
                      tabLayout.$2,
                      $tabsData.children.value[activeIndex],
                    ),
                  );
                  return Positioned(
                    left: tabLayout.$1,
                    child: result,
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
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
  final UpdateCustomLayoutSize updateSize;

  /// 标签数量
  final int length;

  /// 子标签最大宽度
  final double maxWidth;

  /// 以标签页的圆角值作为每个标签的偏移值
  final double radius;

  final void Function(List<_TabLayoutType> list) setLayoutList;

  @override
  void performLayout(Size size) {
    // i('per');
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
