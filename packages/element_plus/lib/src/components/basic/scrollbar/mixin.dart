part of 'index.dart';

const double _defaultThickness = 6.0;
const Radius _defaultRadius = Radius.circular(3.0);
const int _animationDuration = 200;

/// 延迟激活滚动条高亮时间，防止鼠标快速划过导致滚动条出现轻微闪动
const int _delayActiveDuration = 100;

/// Element UI 自定义滚动条实现
mixin _ElScrollbarMixin<T extends ElScrollbar>
    on SingleTickerProviderStateMixin<T> {
  late AnimationController animationController;
  late CurvedAnimation curvedAnimation;

  /// 对滚动条颜色变化进行线性插值，定义两个变量用于保存当前滚动条颜色和目标颜色
  Color? color1;
  Color? color2;

  /// 动画过程中保存的中间颜色，在短时间内快速更新动画时可以无缝衔接
  Color? lerpColor;

  /// 滚动条颜色
  Color get thumbColor => widget.thumbColor;

  /// 鼠标进入滚动范围显示的颜色
  Color get hoverColor => widget.thumbHoverColor ?? thumbColor;

  /// 鼠标悬停在滚动轨道的颜色
  Color get activeColor =>
      widget.thumbActiveColor ?? thumbColor.withOpacity(0.9);

  /// 默认情况下，滚动条是处于隐藏状态，但如果开启一直显示，则固定为悬停状态
  Color get hideThumbColor => thumbColor.withOpacity(0);

  /// 对滚动条颜色进行线性插值
  Color get scrollbarColor {
    if (color1 == null || color2 == null) return hideThumbColor;
    lerpColor = Color.lerp(color1, color2, curvedAnimation.value);
    assert(lerpColor != null);
    return lerpColor!;
  }

  /// 将滚动条的一个颜色以动画形式转变成另一个颜色
  void changeColor(Color color1, Color color2) {
    this.color1 = lerpColor ?? color1;
    this.color2 = color2;
    animationController.forward(from: 0);
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      value: 1.0,
      duration: const Duration(milliseconds: 200),
    );
    curvedAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    curvedAnimation.dispose();
    super.dispose();
  }
}
