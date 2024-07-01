part of 'layout.dart';

class ElAside extends ElLayoutWidget {
  /// Element UI 侧边栏布局组件，一般用于左侧、右侧导航，具有固定的宽度，它不能和 [ElHeader]、
  /// [ElFooter]、[ElNavTab] 同时存在，你需要在它们外部再嵌套一个 [ElLayout] 才能正常布局。
  const ElAside({
    super.key,
    required this.child,
    this.bgColor,
    this.width = 240,
    this.minWidth = 100,
    this.maxWidth,
    this.layoutKey,
  }) : assert(minWidth >= 0, 'minWidth最小宽度不能小于0');

  /// 子组件
  final Widget child;

  /// 背景颜色，支持全局配置
  final Color? bgColor;

  /// 侧边栏默认宽度
  final double width;

  /// 侧边栏最小宽度，当使用拖拽控件时，限制其最小宽度
  final double minWidth;

  /// 侧边栏最大宽度，当使用拖拽控件时，限制其最大宽度
  final double? maxWidth;

  /// 指定布局 key，它可以持久化保存拖拽的尺寸，请确保唯一性
  final String? layoutKey;

  /// 如果没有设置[layoutKey]，则取当前[hashCode]作为[layoutKey]
  String get getLayoutKey => layoutKey ?? hashCode.toString();

  @override
  Widget build(BuildContext context) {
    final $data = _ElLayoutInheritedWidget.of(context);
    return SafeArea(
      bottom: false,
      left: false,
      right: false,
      child: AnimatedColoredBox(
        duration: Duration(milliseconds: context.elConfig.bgColorTransition),
        color: bgColor ?? context.elTheme.asideBgColor,
        child: ObsBuilder(builder: (context) {
          return SizedBox(
            width: max(
              $data.splitLayoutData?[getLayoutKey]?.offset.value ?? width,
              minWidth,
            ),
            height: double.infinity,
            child: child,
          );
        }),
      ),
    );
  }
}
