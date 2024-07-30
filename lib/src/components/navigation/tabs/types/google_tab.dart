part of '../tabs.dart';

/// 谷歌风格标签页离顶部有4px的间距
const double _googleTabPadding = 4.0;

/// 构建标签页外围容器
class _GoogleTabsWidget extends StatelessWidget {
  const _GoogleTabsWidget();

  @override
  Widget build(BuildContext context) {
    final $data = _TabsInheritedWidget.of(context);
    final $width = $data.maxWidth;
    final $height = $data.height - _googleTabPadding;
    double radius = $height / 4 * 3;
    return _GoogleTabsInheritedWidget(
      radius,
      $height,
      child: ElCustomMultiChildLayout(
        width: $width + ($width - radius) * ($data.children.length - 1),
        delegateBuilder: (updateSize) =>
            _GoogleTabLayoutDelegate(updateSize, $data.children.length, radius),
        children: [
          ...$data.children.mapIndexed(
            (i, e) => ElChildIndexData(
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
    );
  }
}

/// 具体标签子项
class _GoogleTab extends StatelessWidget {
  const _GoogleTab();

  @override
  Widget build(BuildContext context) {
    final $tabsData = _TabsInheritedWidget.of(context);
    final $tabData = _TabInheritedWidget.of(context);
    final $googleTabData = _GoogleTabsInheritedWidget.of(context);
    final $indexData = ElChildIndexData.of(context);
    return UnconstrainedBox(
      child: Container(
        height: $googleTabData.height,
        padding: EdgeInsets.symmetric(horizontal: $googleTabData.radius),
        color: $tabsData.modelValue.value == $indexData.index
            ? context.isDark
                ? context.elTheme.primary
                : Colors.white
            : HoverBuilder.of(context)
                ? context.isDark
                    ? context.elTheme.primary.light1(context)
                    : Colors.grey.shade100
                : null,
        child: Row(
          children: [
            ElText(
              $tabData.title,
              style: TextStyle(fontSize: $tabsData.fontSize),
            ),
          ],
        ),
      ),
    );
  }
}

class _GoogleTabsInheritedWidget extends InheritedWidget {
  const _GoogleTabsInheritedWidget(
    this.radius,
    this.height, {
    required super.child,
  });

  /// google风格标签页的圆角值
  final double radius;
  final double height;

  static _GoogleTabsInheritedWidget of(BuildContext context) {
    final _GoogleTabsInheritedWidget? result = context
        .dependOnInheritedWidgetOfExactType<_GoogleTabsInheritedWidget>();
    assert(result != null, 'No _GoogleTabsInheritedWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_GoogleTabsInheritedWidget oldWidget) => true;
}

class _GoogleTabLayoutDelegate extends MultiChildLayoutDelegate {
  final ElUpdateSizeCallback updateSize;
  final int length;

  /// 以标签页的圆角值作为每个标签的偏移值
  final double radius;

  _GoogleTabLayoutDelegate(this.updateSize, this.length, this.radius);

  @override
  void performLayout(Size size) {
    if (length == 0) return;

    Size firstSize = layoutChild(0, BoxConstraints.loose(size));
    double parentWidth = firstSize.width;
    for (int i = 1; i < length; i++) {
      final currentSize = layoutChild(i, BoxConstraints.loose(size));
      positionChild(i, Offset(parentWidth - radius, 0));
      parentWidth += currentSize.width - radius;
    }
    // 布局完成设置外围标签页容器的实际尺寸
    updateSize(Size(parentWidth, size.height));
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
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
