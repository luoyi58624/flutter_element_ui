import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/extensions/element.dart';
import 'package:flutter_element_ui/src/widgets/hover.dart';
import 'package:gap/gap.dart';

import '../../core.dart';
import '../../utils/icons.dart';
import '../../widgets/animation.dart';
import '../../widgets/tap.dart';
import '../basic/icon.dart';
import '../typography/text.dart';

class _TabInheritedWidget extends InheritedWidget {
  const _TabInheritedWidget(
    this.modelValue, {
    required super.child,
  });

  final ValueNotifier modelValue;

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

class ElTabs extends StatelessWidget {
  const ElTabs(
    this.modelValue, {
    super.key,
    required this.tabs,
    this.bgColor,
  });

  /// 选中的标签
  final ValueNotifier modelValue;

  /// 子标签集合
  final List<ElTab> tabs;

  /// 背景颜色
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return _TabInheritedWidget(
      modelValue,
      child: SizedBox(
        height: 50,
        child: AnimatedColoredBox(
          duration: el.config.bgDuration,
          color: bgColor ??
              (context.isDark ? Colors.grey.shade600 : Colors.grey.shade400),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: tabs,
            ),
          ),
        ),
      ),
    );
  }
}

class ElTab extends StatelessWidget {
  const ElTab({super.key, this.id});

  /// 唯一标识，用于识别 [ElTabs] 选中的值
  final dynamic id;

  @override
  Widget build(BuildContext context) {
    final $data = _TabInheritedWidget.of(context);
    return TapBuilder(builder: (context) {
      return HoverBuilder(builder: (context) {
        return ClipPath(
          clipper: _TabClipper(),
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 200,
            ),
            decoration: BoxDecoration(
              color: $data.modelValue.value == id ? Colors.white : null,
            ),
            child: const Row(
              children: [
                ElIcon(ElIcons.eleme),
                Gap(6),
                ElText('标签页'),
              ],
            ),
          ),
        );
      });
    });
  }
}

class _TabClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..addOval(Rect.fromLTWH(0, 0, size.width, size.height));
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<dynamic> oldClipper) {
    return false;
  }
}
