import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_element_ui/src/extensions/element.dart';

import '../../../core.dart';
import '../../../widgets/animation.dart';
import '../../../widgets/hover.dart';
import '../../../widgets/simple_widgets.dart';
import '../../basic/scrollbar.dart';

abstract class ElBaseTabs extends StatefulWidget {
  const ElBaseTabs(
    this.modelValue, {
    super.key,
    required this.children,
    required this.height,
    required this.fontSize,
    this.bgColor,
  });

  /// 选中的标签索引
  final ValueNotifier<int> modelValue;

  /// 子标签集合
  final List<ElBaseTab> children;

  /// 标签页高度
  final double height;

  /// 标签字体大小
  final double fontSize;

  /// 自定义标签页背景颜色
  final Color? bgColor;
}

abstract class ElBaseTabsState<T extends ElBaseTabs> extends State<T> {
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  Widget buildTabs(BuildContext context);

  Color get bgColor => widget.bgColor ?? context.elTheme.bgColor;

  EdgeInsetsGeometry get tabPadding => EdgeInsets.zero;

  @override
  Widget build(BuildContext context) {
    return ElBaseTabsData(
      widget.modelValue,
      widget.children,
      widget.height,
      widget.fontSize,
      bgColor,
      child: SizedBox(
        width: double.infinity,
        height: widget.height,
        child: AnimatedColoredBox(
          duration: el.config.bgDuration,
          color: bgColor,
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
                  child: Builder(builder: (context) {
                    return buildTabs(context);
                  }),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

abstract class ElBaseTab extends StatelessWidget {
  const ElBaseTab({
    super.key,
    required this.title,
    this.disabled = false,
    this.closable = true,
  });

  /// 标签标题
  final String title;

  /// 是否禁用
  final bool disabled;

  /// 是否显示关闭按钮
  final bool closable;

  Widget buildTab(BuildContext context);

  @override
  Widget build(BuildContext context) {
    final $tabsData = ElBaseTabsData.of(context);
    final $indexData = ElChildIndexData.of(context);
    return ElBaseTabData(
      title,
      disabled,
      closable,
      child: GestureDetector(
        onTapDown: (e) {
          $tabsData.modelValue.value = $indexData.index;
        },
        child: HoverBuilder(builder: (context) {
          return buildTab(context);
        }),
      ),
    );
  }
}

class ElBaseTabsData extends InheritedWidget {
  const ElBaseTabsData(
    this.modelValue,
    this.children,
    this.height,
    this.fontSize,
    this.bgColor, {
    super.key,
    required super.child,
  });

  /// 选中的标签索引
  final ValueNotifier<int> modelValue;

  /// 子标签集合
  final List<ElBaseTab> children;

  /// 标签页高度
  final double height;

  /// 标签字体大小
  final double fontSize;

  final Color? bgColor;

  static ElBaseTabsData of(BuildContext context) {
    final ElBaseTabsData? result =
        context.dependOnInheritedWidgetOfExactType<ElBaseTabsData>();
    assert(result != null, 'No ElBaseTabsData found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ElBaseTabsData oldWidget) => true;
}

class ElBaseTabData extends InheritedWidget {
  const ElBaseTabData(
    this.title,
    this.disabled,
    this.closable, {
    super.key,
    required super.child,
  });

  final String title;
  final bool disabled;
  final bool closable;

  static ElBaseTabData of(BuildContext context) {
    final ElBaseTabData? result =
        context.dependOnInheritedWidgetOfExactType<ElBaseTabData>();
    assert(result != null, 'No ElBaseTabData found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ElBaseTabData oldWidget) => true;
}