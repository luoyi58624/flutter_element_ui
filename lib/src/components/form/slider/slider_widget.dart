part of 'index.dart';

abstract class ElBaseSlider extends StatelessWidget {
  /// Slider 滑块抽象类
  const ElBaseSlider({
    super.key,
    required this.size,
  });

  /// 滑块尺寸
  final double size;

  /// 通过上下文访问 Slider 状态
  ElSliderState of(BuildContext context) =>
      _SlideInheritedWidget.of(context).state;
}

class ElDefaultSlider extends ElBaseSlider {
  /// Element UI 默认样式 slider 滑块
  const ElDefaultSlider({
    super.key,
    super.size = 20,
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
  Widget build(BuildContext context) {
    final $data = of(context);
    return AnimatedScale(
      duration: const Duration(milliseconds: 100),
      scale: $data.isDrag || context.isHover ? 1.2 : 1.0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(size / 2),
          border: Border.all(
            width: ringSize,
            color: ringColor ?? context.elTheme.primary,
          ),
        ),
      ),
    );
  }
}
