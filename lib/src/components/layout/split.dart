part of 'layout.dart';

/// Element UI 页面分割组件
class ElSplit extends ElLayoutWidget {
  /// 创建可拖拽控件，通过它调整周围的布局组件的尺寸大小
  const ElSplit({
    super.key,
    this.size = 0,
    this.triggerSize = 10,
    this.builder,
  });

  /// 控件本身占据的空间，默认0
  final double size;

  /// 可拖拽控件触发范围，默认10
  final double triggerSize;

  /// 自定义构建拖拽控件
  final WidgetBuilder? builder;

  @override
  Widget build(BuildContext context) {
    final $data = _ElLayoutInheritedWidget.of(context);
    final $isColumn = $data.isColumn;
    final triggerPosition = triggerSize / 2;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          width: $isColumn ? double.infinity : size,
          height: $isColumn ? size : double.infinity,
        ),
        Positioned(
          // left: $isColumn ? 0 : -triggerPosition,
          // right: $isColumn ? 0 : triggerPosition,
          // top: $isColumn ? -triggerPosition : 0,
          // bottom: $isColumn ? triggerPosition : 0,
          left: 0,
          right: 0,
          top: 0,
          bottom: 0,
          child: GestureDetector(
            onTap: () {
              i('dian');
            },
            child: HoverBuilder(
              cursor: $isColumn
                  ? SystemMouseCursors.resizeRow
                  : SystemMouseCursors.resizeColumn,
              builder: (isHover) => Container(
                width: $isColumn ? double.infinity : triggerSize,
                height: $isColumn ? triggerSize : double.infinity,
                color: context.elTheme.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
