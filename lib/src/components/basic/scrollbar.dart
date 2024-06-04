part of flutter_element_ui;

const double _defaultThickness = 6.0;
const Radius _defaultRadius = Radius.circular(3.0);

/// Element UI 滚动条
class ElScrollbar extends RawScrollbar {
  /// 构建 Element UI 风格的滚动条
  const ElScrollbar({
    super.key,
    required super.child,
    this.always = false,
    super.controller,
    super.thumbColor,
    super.thickness = _defaultThickness,
    super.radius = _defaultRadius,
    super.mainAxisMargin = 1.0,
    super.crossAxisMargin = 1.0,
    super.minThumbLength = 36.0,
  });

  /// 是否总是显示滚动条，默认情况下，当鼠标离开滚动区域时，滚动条将消失
  final bool always;

  @override
  RawScrollbarState<ElScrollbar> createState() => _ElScrollbarState();
}

class _ElScrollbarState extends RawScrollbarState<ElScrollbar> {
  /// 创建滚动条动画控制器
  late AnimationController scrollbarAnimationController;

  /// 对滚动条颜色变化进行线性插值，定义两个变量用于保存当前滚动条颜色和目标颜色
  Color? color1;
  Color? color2;

  /// 鼠标进入滚动区域
  bool isHover = false;

  /// 鼠标悬停在滚动条上
  bool isScrollbarHover = false;

  Color get thumbColor => widget.thumbColor ?? const Color.fromRGBO(144, 147, 153, 1.0);

  Color get hideThumbColor => PlatformUtil.isMobile || widget.always ? hoverThumbColor : thumbColor.withOpacity(0);

  Color get hoverThumbColor => thumbColor.withOpacity(0.5);

  Color get activeThumbColor => thumbColor.withOpacity(0.9);

  @override
  bool get showScrollbar => true;

  /// 计算滚动条颜色，根据[color1]、[color2]以及[scrollbarAnimationController]慢慢地改变滚动条颜色
  Color get scrollbarColor {
    if (color1 == null || color2 == null) return hideThumbColor;
    return Color.lerp(color1, color2, scrollbarAnimationController.value)!;
  }

  @override
  void initState() {
    super.initState();
    scrollbarAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(updateScrollbarPainter);
  }

  @override
  void dispose() {
    scrollbarAnimationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ElScrollbar oldWidget) {
    updateScrollbarPainter();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void updateScrollbarPainter() {
    scrollbarPainter
      ..color = scrollbarColor
      ..textDirection = Directionality.of(context)
      ..thickness = widget.thickness ?? _defaultThickness
      ..radius = widget.radius ?? _defaultRadius
      ..mainAxisMargin = widget.mainAxisMargin
      ..crossAxisMargin = widget.crossAxisMargin;
  }

  /// 开始拖动滚动条
  @override
  void handleThumbPressStart(Offset localPosition) {
    super.handleThumbPressStart(localPosition);
    DragScrollbarDisabledHover.setDisabled(context, true);
    // 处理直接从边缘处立即拖动滚动条，这只是一个细节处理
    if (isScrollbarHover == false) {
      color1 = isHover ? hoverThumbColor : hideThumbColor;
      color2 = activeThumbColor;
      scrollbarAnimationController.forward(from: 0);
    }
  }

  /// 结束拖动滚动条
  @override
  void handleThumbPressEnd(Offset localPosition, Velocity velocity) {
    super.handleThumbPressEnd(localPosition, velocity);
    DragScrollbarDisabledHover.setDisabled(context, false);
    // 结束滚动条拖动时如果鼠标已经处于页面之外，那么将隐藏滚动条，否则将滚动条状态设置为hover
    if (isHover == false) {
      isHover = false;
      isScrollbarHover = false;
      color1 = activeThumbColor;
      color2 = hideThumbColor;
      scrollbarAnimationController.forward(from: 0);
    } else {
      color1 = activeThumbColor;
      color2 = hoverThumbColor;
      scrollbarAnimationController.forward(from: 0);
    }
  }

  /// 延迟处理悬停滚动条，当用户快速从滚动条上划过时，不会对滚动条进行高亮
  Timer? _delayHandlerHover;

  void _cancelDelayHandlerHover() {
    if (_delayHandlerHover != null) {
      _delayHandlerHover!.cancel();
      _delayHandlerHover = null;
    }
  }

  /// 鼠标在滚动区域悬停事件
  @override
  void handleHover(PointerHoverEvent event) {
    super.handleHover(event);
    // 优先处理鼠标悬停在滚动条上的事件
    if (isPointerOverThumb(event.position, event.kind)) {
      // 防止重复设置动画
      if (isScrollbarHover == false) {
        isScrollbarHover = true;
        _cancelDelayHandlerHover();
        _delayHandlerHover = DartUtil.delay(() {
          if (isHover) {
            color1 = hoverThumbColor;
          } else {
            isHover = true;
            color1 = hideThumbColor;
          }
          color2 = activeThumbColor;
          scrollbarAnimationController.forward(from: 0);
        }, 150);
      }
    }
    // 如果是从滚动条上挪开，则将滚动条颜色从active变回hover
    else if (isScrollbarHover) {
      isScrollbarHover = false;
      if (_delayHandlerHover == null) {
        color1 = activeThumbColor;
        color2 = hoverThumbColor;
        scrollbarAnimationController.forward(from: 0);
      } else {
        _cancelDelayHandlerHover();
      }
    }
  }

  /// 鼠标离开滚动区域事件
  @override
  void handleHoverExit(PointerExitEvent event) {
    if (DragScrollbarDisabledHover.disabled(context)) {
      isHover = false;
      isScrollbarHover = false;
      return;
    }
    i('xxx');
    super.handleHoverExit(event);
    isHover = false;
    if (isScrollbarHover) {
      if (_delayHandlerHover == null) {
        color1 = activeThumbColor;
      } else {
        color1 = hoverThumbColor;
        _cancelDelayHandlerHover();
      }
    } else {
      color1 = hoverThumbColor;
    }
    color2 = hideThumbColor;
    scrollbarAnimationController.forward(from: 0);
    isScrollbarHover = false;
  }

  /// [RawScrollbar]内部没有监听[onEnter]事件，导致当鼠标离开滚动区域时，无法监听是否重新回到滚动区域，所以只能再套一层[MouseRegion]
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        isHover = true;
        if (DragScrollbarDisabledHover.disabled(context) == false) {
          color1 = hideThumbColor;
          color2 = hoverThumbColor;
          scrollbarAnimationController.forward(from: 0);
        }
      },
      child: super.build(context),
    );
  }
}
