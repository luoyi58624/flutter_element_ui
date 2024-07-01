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
    this.maxWidth = 400,
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
  final double maxWidth;

  /// 指定布局 key，只有当你用到拖拽尺寸时才需要设置它，默认取当前的 [hashCode]，
  /// 除非你有一个简单的布局，否则你必须设置它。
  final String? layoutKey;

  /// 如果没有设置[layoutKey]，则取当前[hashCode]作为[layoutKey]
  String get getLayoutKey => layoutKey ?? hashCode.toString();

  /// 布局完成后拿到当前组件的位置，设置拖拽的偏移值
  void _setOffset(BuildContext context, _ElLayoutInheritedWidget data) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final RenderBox renderObject = context.findRenderObject() as RenderBox;
      final offset = renderObject.localToGlobal(
        Offset.zero,
        ancestor: data.layoutContext.findRenderObject(),
      );
      // i(offset);
      data.splitLayoutData?[layoutKey]?.offset.value = offset.dx;
    });
  }

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
          _setOffset(context, $data);
          return SizedBox(
            width: max(
              ($data.splitLayoutData?[getLayoutKey] as _RowSplitLayoutData?)
                      ?.width
                      .value ??
                  width,
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
