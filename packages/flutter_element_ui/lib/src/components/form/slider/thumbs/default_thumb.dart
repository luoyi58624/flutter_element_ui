part of '../index.dart';

class ElDefaultSlider extends ElBaseSlider {
  /// Element UI 默认滑块按钮
  const ElDefaultSlider({
    super.key,
    super.thumbSize,
    super.eventRange,
    this.color = Colors.white,
    this.ringSize = 2.0,
    this.ringColor,
  });

  /// 滑块颜色，默认白色
  final Color color;

  /// 圆环尺寸，默认 2
  final double ringSize;

  /// 滑块圆环颜色，默认跟随主题
  final Color? ringColor;

  @override
  State<ElDefaultSlider> createState() => _ElDefaultSliderState();
}

class _ElDefaultSliderState extends State<ElDefaultSlider> {
  @override
  Widget build(BuildContext context) {
    final $data = widget.of(context);
    return AnimatedScale(
      duration: const Duration(milliseconds: 100),
      scale: $data.isDrag || context.isHover ? 1.2 : 1.0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: widget.thumbSize,
        height: widget.thumbSize,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(widget.thumbSize / 2),
          border: Border.all(
            width: widget.ringSize,
            color: widget.ringColor ?? context.elTheme.primary,
          ),
        ),
      ),
    );
  }
}
