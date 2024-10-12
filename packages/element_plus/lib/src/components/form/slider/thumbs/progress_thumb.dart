part of '../index.dart';

class ElProgressSlider extends ElBaseSlider {
  /// Element UI 进度滑块按钮，默认情况下会隐藏，当交互时将会显示，它一般适用于视频播放器
  const ElProgressSlider({
    super.key,
    super.thumbSize,
    this.color,
  }) : super(
          cursor: SystemMouseCursors.click,
          eventRange: ElSliderEventRange.slider,
        );

  /// 滑块颜色，默认主题色
  final Color? color;

  @override
  State<ElProgressSlider> createState() => ElProgressSliderState();
}

class ElProgressSliderState extends State<ElProgressSlider> {
  /// 显示滑块按钮条件
  bool get showThumb {
    final $data = widget.of(context);
    return $data.isHover || $data.isDrag;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 350),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: showThumb
          ? Container(
              width: widget.thumbSize,
              height: widget.thumbSize,
              decoration: BoxDecoration(
                color: widget.color ?? context.elTheme.primary,
                borderRadius: BorderRadius.circular(widget.thumbSize / 2),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 2.0,
                  ),
                ],
              ),
            )
          : const SizedBox(),
    );
  }
}
