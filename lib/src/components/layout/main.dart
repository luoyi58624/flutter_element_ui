part of 'layout.dart';

class ElMain extends _ElFlexLayoutWidget {
  /// Element UI 主页面布局组件，它会分配 [ElLayout] 内部所有的剩余空间，你可以设置多个[ElMain]，
  /// 通过 [flex] 属性设置它们之间的比例，当然，它们同样也支持 [ElLayoutSplit] 进行分割调整尺寸。
  const ElMain({
    super.key,
    required this.child,
    this.bgColor,
    super.flex,
    super.minFlex,
    super.layoutKey,
  });

  /// 子组件
  final Widget child;

  /// 自定义背景色
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    final $data = _ElLayoutInheritedWidget.of(context);
    if ($data.splitLayoutData?[getLayoutKey] == null) {}
    return ObsBuilder(builder: (context) {
      return Expanded(
        flex: ((($data.splitLayoutData?[getLayoutKey] as _FlexSplitLayoutData?)
                        ?.flex
                        .value ??
                    flex) *
                1000)
            .floor(),
        child: _buildColorBox(context, child),
      );
    });
    // return ObsBuilder(builder: (context) {
    //   ElLayout._setSplitOffset(context, getLayoutKey);
    //   final width =
    //       ($data.splitLayoutData?[getLayoutKey] as _RowSplitLayoutData?)
    //           ?.width
    //           .value;
    //   bool isDrag = (width ?? -1) > 0;
    //   if (isDrag) {
    //     i('xxx');
    //     return _buildColorBox(
    //       context,
    //       SizedBox(
    //         width: width,
    //         child: child,
    //       ),
    //     );
    //   } else {
    //     SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
    //       i(context.size?.width);
    //       ($data.splitLayoutData![getLayoutKey] as _RowSplitLayoutData?)!
    //           .width
    //           .value = context.size!.width;
    //     });
    //     return Expanded(
    //       flex: flex,
    //       child: _buildColorBox(context, child),
    //     );
    //   }
    // });
  }

  Widget _buildColorBox(BuildContext context, Widget child) {
    return AnimatedColoredBox(
      duration: Duration(milliseconds: el.config.bgTransition),
      color: bgColor ?? context.elTheme.bgColor,
      child: child,
    );
  }
}
