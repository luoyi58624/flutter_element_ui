import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/extensions/element.dart';
import 'package:flutter_element_ui/src/extensions/private.dart';
import 'package:luoyi_dart_base/luoyi_dart_base.dart';

import '../../../widgets/custom_layout.dart';
import '../../../widgets/hover.dart';
import '../../../widgets/simple_widgets.dart';
import '../../typography/text.dart';
import 'base_tab.dart';

/// 谷歌风格标签页离顶部有4px的间距
const double _paddingTop = 4.0;

class ElGoogleTabs extends ElBaseTabs {
  const ElGoogleTabs(
    super.modelValue, {
    super.key,
    required super.children,
    super.height = 36,
    super.fontSize = 13,
    super.bgColor,
    this.maxWidth = 200,
  });

  /// 每个子标签页的最大宽度
  final double maxWidth;

  @override
  State<ElGoogleTabs> createState() => _ElGoogleTabsState();
}

class _ElGoogleTabsState extends ElBaseTabsState<ElGoogleTabs> {
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
    final layoutWidth = widget.maxWidth +
        (widget.maxWidth - radius) * ($tabsData.children.length - 1);
    return _GoogleTabsData(
      layoutHeight,
      radius,
      child: ElCustomMultiChildLayout(
        width: layoutWidth,
        delegateBuilder: (updateSize, isSecondBuild) =>
            _GoogleTabLayoutDelegate(
          updateSize,
          $tabsData.modelValue.value,
          $tabsData.children.length,
          widget.maxWidth,
          radius,
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
    final $indexData = ElChildIndexData.of(context);
    final $googleTabData = _GoogleTabsData.of(context);
    return ColoredBox(
      color: $tabsData.modelValue.value == $indexData.index
          ? context.isDark
              ? context.elTheme.primary
              : Colors.white
          : HoverBuilder.of(context)
              ? context.isDark
                  ? context.elTheme.primary.light1(context)
                  : Colors.grey.shade100
              : Colors.transparent,
      child: UnconstrainedBox(
        child: SizedBox(
          height: $googleTabData.height,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: $googleTabData.radius),
            child: Row(
              children: [
                ElText(
                  title,
                  style: TextStyle(fontSize: $tabsData.fontSize),
                ),
              ],
            ),
          ),
        ),
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
    this.activeIndex,
    this.length,
    this.maxWidth,
    this.radius,
  );

  /// 更新布局尺寸回调函数
  final ElUpdateCustomLayoutSize updateSize;

  /// 标签数量
  final int length;

  /// 激活的下标
  final int activeIndex;

  /// 子标签最大宽度
  final double maxWidth;

  /// 以标签页的圆角值作为每个标签的偏移值
  final double radius;

  @override
  void performLayout(Size size) {
    if (length == 0) return;
    final constraint = BoxConstraints(minWidth: 0, maxWidth: maxWidth);
    Size firstSize = layoutChild(0, constraint);
    double parentWidth = firstSize.width;
    for (int i = 1; i < length; i++) {
      final currentSize = layoutChild(i, constraint);
      positionChild(i, Offset(parentWidth - radius, 0));
      parentWidth += currentSize.width - radius;
    }
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
