part of 'index.dart';

const double _defaultThickness = 6.0;
const Radius _defaultRadius = Radius.circular(3.0);
const int _animationDuration = 200;

/// 延迟激活滚动条高亮时间，防止鼠标快速划过导致滚动条出现轻微闪动
const int _delayActiveDuration = 100;

class _ElScrollbarState extends RawScrollbarState<ElScrollbar> {
  /// 创建滚动条动画控制器
  late AnimationController controller;

  /// 对滚动条颜色变化进行线性插值，定义两个变量用于保存当前滚动条颜色和目标颜色
  Color? color1;
  Color? color2;

  /// 动画过程中保存的中间颜色，在短时间内快速更新动画时可以无缝衔接
  Color? lerpColor;

  /// 当鼠标进入滚动区域时立即显示滚动条
  bool isHover = false;

  /// 鼠标悬停在滚动条上
  bool isScrollbarHover = false;

  /// 是否处于拖拽滚动条状态
  bool isDragScroll = false;

  /// 覆写 [RawScrollbar] 显示滚动默认逻辑，如何显示滚动条由自己做决定
  @override
  bool get showScrollbar => true;

  /// 滚动条颜色
  Color get thumbColor =>
      widget.thumbColor ?? const Color.fromRGBO(144, 147, 153, 1.0);

  /// 鼠标进入滚动范围显示的颜色
  Color get hoverColor => widget.hidden
      ? thumbColor.withOpacity(0)
      : widget.hoverThumbColor ?? thumbColor.withOpacity(0.45);

  /// 鼠标悬停在滚动轨道的颜色
  Color get activeColor => widget.hidden
      ? thumbColor.withOpacity(0)
      : widget.activeThumbColor ?? thumbColor.withOpacity(0.9);

  /// 默认情况下，滚动条是处于隐藏状态，但如果开启一直显示，则固定为悬停状态
  Color get hideThumbColor =>
      widget.always ? hoverColor : thumbColor.withOpacity(0);

  /// 对滚动条颜色进行线性插值
  Color get scrollbarColor {
    if (color1 == null || color2 == null) return hideThumbColor;
    lerpColor = Color.lerp(color1, color2, controller.value);
    assert(lerpColor != null);
    return lerpColor!;
  }

  /// 将滚动条的一个颜色以动画形式转变成另一个颜色
  void changeColor(Color color1, Color color2) {
    // lerpColor是后来加入的，color1应该可以抛弃，但目前滚动条工作的很好，就不处理了
    this.color1 = lerpColor ?? color1;
    this.color2 = color2;
    controller.forward(from: 0);
  }

  /// 延迟激活悬停滚动条，用户必须在滚动条上悬停一段时间，才激活滚动条高亮状态
  Timer? _delayActiveHover;

  void _cancelDelayActiveHover() {
    if (_delayActiveHover != null) {
      _delayActiveHover!.cancel();
      _delayActiveHover = null;
    }
  }

  /// 隐藏滚动中的滚动条，如果滚动停止超过一段时间，将隐藏它
  Timer? _hideScrollingTimer;

  void _cancelHideScrollingTimer() {
    if (_hideScrollingTimer != null) {
      _hideScrollingTimer!.cancel();
      _hideScrollingTimer = null;
    }
  }

  /// 延迟清除 [color1]、[color2]
  Timer? _delayCleanColor;

  void _cancelDelayCleanColor() {
    if (_delayCleanColor != null) {
      _delayCleanColor!.cancel();
      _delayCleanColor = null;
    }
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: _animationDuration.ms,
    )..addListener(updateScrollbarPainter);
  }

  @override
  void dispose() {
    controller.dispose();
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
    // 拖拽滚动时设置全局默认光标，这样可以杜绝鼠标在拖拽过程中触发页面元素的 hover 事件
    el.cursor.add();
    isDragScroll = true;
    // 处理直接从边缘处立即拖动滚动条
    if (isScrollbarHover == false) {
      isScrollbarHover = true;
      changeColor(isHover ? hoverColor : hideThumbColor, activeColor);
    }
  }

  /// 结束拖动滚动条
  @override
  void handleThumbPressEnd(Offset localPosition, Velocity velocity) {
    super.handleThumbPressEnd(localPosition, velocity);
    el.cursor.remove();
    // 短暂延迟一段时间执行结束逻辑，因为受到 cursor 的影响会导致悬停状态丢失,
    // isScrollbarHover 状态需要在 onEnter 中判断鼠标是否在滚动条上
    setTimeout(() {
      isDragScroll = false;
      if (isScrollbarHover == false) {
        if (isHover) {
          changeColor(activeColor, hoverColor);
        } else {
          changeColor(activeColor, hideThumbColor);
        }
      }
    }, 16);
  }

  /// 鼠标在滚动区域悬停事件
  @override
  void handleHover(PointerHoverEvent event) {
    super.handleHover(event);
    if (widget.onlyScrolling) return;
    // 优先处理鼠标悬停在滚动条上的事件
    if (isPointerOverThumb(event.position, event.kind)) {
      if (isScrollbarHover == false) {
        _cancelDelayActiveHover();
        _delayActiveHover = setTimeout(() {
          isScrollbarHover = true;
          changeColor(hoverColor, activeColor);
        }, _delayActiveDuration);
      }
    }
    // 如果是从滚动条上挪开，则将滚动条颜色从active变回hover
    else if (isScrollbarHover) {
      isScrollbarHover = false;
      changeColor(activeColor, hoverColor);
    } else {
      _cancelDelayActiveHover();
    }
  }

  /// 鼠标离开滚动区域事件，有两种事件会触发这段逻辑：
  /// 1. 开始拖拽滚动条，因为设置 cursor 会在页面上创建全屏透明遮罩层
  /// 2. 鼠标直接离开滚动容器
  @override
  void handleHoverExit(PointerExitEvent event) {
    if (widget.onlyScrolling) return;
    // 离开时一定要先取消延迟激活动画，防止快速将鼠标悬停在滚动条时，又快速离开产生状态bug
    _cancelDelayActiveHover();
    // 将这两种状态重置是必须的，后续的逻辑判断依赖它们
    isHover = false;
    isScrollbarHover = false;
    super.handleHoverExit(event);
    // 如果是处于拖拽状态便离开滚动区域，那么保存滚动条当前颜色状态，否则隐藏滚动条
    if (isDragScroll) return;
    if (color2 != null) {
      changeColor(color2!, hideThumbColor);
    }
  }

  /// [RawScrollbar]没有提供监听[onEnter]事件，导致当鼠标离开滚动区域时，
  /// 无法监听是否重新回到滚动区域，所以只能再套一层[MouseRegion]
  @override
  Widget build(BuildContext context) {
    Widget result = super.build(context);
    if (widget.onlyScrolling) {
      result = NotificationListener<ScrollNotification>(
        onNotification: (e) {
          _cancelHideScrollingTimer();
          _cancelDelayCleanColor();
          _hideScrollingTimer = setTimeout(
            () {
              _hideScrollingTimer = null;
              changeColor(activeColor, hideThumbColor);
              _delayCleanColor = setTimeout(() {
                _delayCleanColor = null;
                color1 = null;
                color2 = null;
              }, _animationDuration);
            },
            widget.timeToFade.inMilliseconds,
          );
          if (color1 == null && color2 == null) {
            changeColor(hideThumbColor, activeColor);
          }
          return false;
        },
        child: result,
      );
    }
    return MouseRegion(
      onEnter: (event) {
        if (widget.onlyScrolling == false && isHover == false) {
          isHover = true;
          // 如果是在拖拽状态下鼠标重新进入滚动区域，需要重新判断是否处于
          if (isDragScroll) {
            if (isPointerOverThumb(event.position, event.kind)) {
              isScrollbarHover = true;
            }
          } else {
            changeColor(hideThumbColor, hoverColor);
          }
        }
      },
      child: result,
    );
  }
}
