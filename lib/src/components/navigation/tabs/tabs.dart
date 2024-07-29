import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/extensions/element.dart';
import 'package:flutter_element_ui/src/widgets/hover.dart';
import 'package:gap/gap.dart';

import '../../../core.dart';
import '../../../utils/icons.dart';
import '../../../widgets/animation.dart';
import '../../../widgets/simple_widgets.dart';
import '../../../widgets/tap.dart';
import '../../basic/icon.dart';
import '../../basic/scrollbar.dart';
import '../../typography/text.dart';

part 'tab.dart';

const double _googleTabPadding = 4.0;

enum ElTabType {
  /// 传统卡片式标签
  card,

  /// 谷歌浏览器风格标签页
  google,
}

class _TabInheritedWidget extends InheritedWidget {
  const _TabInheritedWidget(
    this.modelValue,
    this.type,
    this.height,
    this.bgColor, {
    required super.child,
  });

  final ValueNotifier modelValue;
  final ElTabType? type;
  final double height;
  final Color? bgColor;

  static _TabInheritedWidget of(BuildContext context) {
    final _TabInheritedWidget? result =
        context.dependOnInheritedWidgetOfExactType<_TabInheritedWidget>();
    assert(result != null, 'No _TabInheritedWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_TabInheritedWidget oldWidget) {
    return false;
  }
}

class ElTabs extends StatefulWidget {
  const ElTabs(
    this.modelValue, {
    super.key,
    required this.children,
    this.type,
    this.height = 40,
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

  /// 自定义标签页背景颜色
  final Color? bgColor;

  /// 子标签的宽度是否需要占据所有空间，此属性一般用于移动端场景，拥有已知数量的少量标签
  final bool expanded;

  @override
  State<ElTabs> createState() => _ElTabsState();
}

class _ElTabsState extends State<ElTabs> {
  final ScrollController controller = ScrollController();

  EdgeInsetsGeometry get tabPadding {
    if (widget.type == ElTabType.google) {
      return const EdgeInsets.only(top: 4);
    } else {
      return EdgeInsets.zero;
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  Widget buildTab() {
    return Row(
      children: widget.children
          .mapIndexed((i, e) => ElChildIndexData(index: i, child: e))
          .toList(),
    );
  }

  Widget buildGoogleTab() {
    final $height = widget.height - _googleTabPadding;
    double radius = $height / 4 * 3;
    return CustomMultiChildLayout(
      delegate: _GoogleTabLayoutDelegate(widget.children.length, radius),
      children: [
        ...widget.children.mapIndexed(
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
      result = buildGoogleTab();
    }

    return _TabInheritedWidget(
      widget.modelValue,
      widget.type,
      widget.height,
      widget.bgColor,
      child: SizedBox(
        height: widget.height,
        child: AnimatedColoredBox(
          duration: el.config.bgDuration,
          color: $bgColor,
          child: Padding(
            padding: tabPadding,
            child: Listener(
              onPointerSignal: (e) {
                if (e is PointerScrollEvent) {
                  controller.position.pointerScroll(e.scrollDelta.dy);
                }
              },
              child: ScrollConfiguration(
                behavior: const NoScrollBehavior(),
                child: SingleChildScrollView(
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

class _GoogleTabLayoutDelegate extends MultiChildLayoutDelegate {
  final int length;
  final double r;

  _GoogleTabLayoutDelegate(this.length, this.r);

  @override
  void performLayout(Size size) {
    if (length == 0) return;
    Size preSize = layoutChild(0, BoxConstraints.loose(size));
    for (int i = 1; i < length; i++) {
      final currentSize = layoutChild(i, BoxConstraints.loose(size));
      positionChild(i, Offset((preSize.width - r) * i, 0));
      preSize = currentSize;
    }
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
    final path = Path();
    path.moveTo(0, h);
    path.cubicTo(r, h, 0, 0, r, 0);
    path.lineTo(w - r, 0);
    path.cubicTo(w, 0, w - r, h, w, h);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<dynamic> oldClipper) {
    return true;
  }
}
