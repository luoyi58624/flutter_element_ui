import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_element_ui/src/extensions/element.dart';

import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import '../../../service.dart';
import 'inherited_data.dart';

enum ElTabType {
  /// 传统卡片式标签
  card,

  /// 谷歌浏览器风格标签页
  google,
}

abstract class ElBaseTabs extends StatefulWidget {
  const ElBaseTabs(
    this.modelValue, {
    super.key,
    required this.children, this.type,
    required this.height,
    required this.fontSize,
    required this.childMaxWidth,
    this.bgColor,
    this.enabledAnimate = true,
    this.duration,
    this.curve = Curves.easeOut,
  });

  /// 选中的标签索引
  final ValueNotifier<int> modelValue;

  /// 子标签集合
  final ValueNotifier<List<ElBaseTab>> children;

  /// 标签类型
  final ElTabType? type;

  /// 标签页高度
  final double height;

  /// 每个子标签页的最大宽度
  final double childMaxWidth;

  /// 标签字体大小
  final double fontSize;

  /// 自定义标签页背景颜色
  final Color? bgColor;

  /// 是否启用标签切换动画
  final bool enabledAnimate;

  /// 动画持续时间，默认全局
  final Duration? duration;

  /// 动画曲线
  final Curve curve;
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
    return TabsData(
      widget.modelValue,
      widget.children,
      widget.type,
      widget.height,
      widget.fontSize,
      widget.childMaxWidth,
      bgColor,
      widget.enabledAnimate,
      widget.duration,
      widget.curve,
      child: SizedBox(
        width: double.infinity,
        height: widget.height,
        child: AnimatedColoredBox(
          duration: el.config.colorDuration,
          color: bgColor,
          child: Padding(
            padding: tabPadding,
            child: Listener(
              onPointerSignal: (e) {
                if (e is PointerScrollEvent) {
                  scrollController.position.pointerScroll(e.scrollDelta.dy);
                }
              },
              child: SingleChildScrollView(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                physics: const ClampingScrollPhysics(),
                child: RepaintBoundary(
                  child: Builder(builder: (context) {
                    return buildTabs(context);
                  }),
                ),
              ).noScrollBehavior,
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
}
