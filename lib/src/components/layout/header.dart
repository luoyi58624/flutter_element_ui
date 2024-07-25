part of 'layout.dart';

/// Element UI 头部布局组件
class ElHeader extends ElLayoutWidget {
  const ElHeader({
    super.key,
    required this.child,
    this.bgColor,
    this.height = 56,
    this.minHeight = 0,
    this.maxHeight,
    this.layoutKey,
  }) : assert(minHeight >= 0, 'minHeight最小高度不能小于0');

  /// 子组件
  final Widget child;

  /// 背景颜色，支持全局配置
  final Color? bgColor;

  /// 头部默认高度
  final double height;

  /// 头部最小高度，当使用拖拽控件时，限制其最小高度
  final double minHeight;

  /// 头部最大高度，当使用拖拽控件时，限制其最大高度
  final double? maxHeight;

  /// 指定布局 key，它可以持久化保存拖拽的尺寸，请确保唯一性
  final String? layoutKey;

  /// 如果没有设置[layoutKey]，则取当前[hashCode]作为[layoutKey]
  String get getLayoutKey => layoutKey ?? hashCode.toString();

  @override
  Widget build(BuildContext context) {
    final $data = _ElLayoutInheritedWidget.of(context);
    return SafeArea(
      bottom: false,
      child: AnimatedColoredBox(
        duration: Duration(milliseconds: el.config.bgTransition),
        color: bgColor ?? context.elTheme.headerColor,
        child: ObsBuilder(builder: (context) {
          return SizedBox(
            height: max(
              $data.splitLayoutData?[getLayoutKey]?.offset.value ?? height,
              minHeight,
            ),
            width: double.infinity,
            child: child,
          );
        }),
      ),
    );
  }
}
