part of 'index.dart';

extension ElTapExtension on BuildContext {
  /// 通过当前上下文访问最近的 Tap 点击状态
  bool get isTap => ElTapBuilder.of(this);
}

class ElTapBuilder extends _EventBubbleWidget {
  /// 点击事件构建器，主要有两个功能：
  /// * 延迟更新点击状态，让依赖 tap 事件的元素状态更加明显
  /// * 默认触发事件冒泡，如果 [ElTapBuilder] 存在嵌套，内部触发事件上层事件也会触发
  ///
  /// 如果要阻止事件冒泡，请在嵌套小部件之间添加 [ElStopPropagation] 小部件
  const ElTapBuilder({
    super.key,
    required this.builder,
    this.delay = 100,
    this.disabled = false,
    this.hitTestBehavior = HitTestBehavior.deferToChild,
    this.onTap,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
  }) : assert(delay == 0 || delay >= 50);

  final WidgetBuilder builder;

  /// 延迟多少毫秒更新点击状态，默认100毫秒，设置一定的延迟时间可以让点击效果更加明显，
  /// 它适用于依赖 tap 事件而改变状态的元素，防止轻点时 tapDown -> tapUp 之间极短的时间间隔导致看不出任何效果。
  ///
  /// 提示：这个延迟属性只作用于 [onTapUp] 事件，[onTap] 事件逻辑不受影响，通常情况下保持默认值即可。
  final int delay;

  /// 是否禁用
  final bool disabled;

  /// 命中测试行为
  final HitTestBehavior hitTestBehavior;

  /// 点击事件
  final GestureTapCallback? onTap;

  /// 按下事件
  final GestureTapDownCallback? onTapDown;

  /// 是否手指事件
  final GestureTapUpCallback? onTapUp;

  /// 取消事件
  final GestureTapCancelCallback? onTapCancel;

  /// 根据上下文获取最近的点击状态
  static bool of(BuildContext context) =>
      _TapInheritedWidget.maybeOf(context)?.isTap ?? false;

  @override
  State<ElTapBuilder> createState() => _TapBuilderState();
}

class _TapBuilderState extends _EventBubbleWidgetState<ElTapBuilder> {
  /// 是否触发点击
  bool _isTap = false;

  /// 是否存在依赖，如果有那么会自动触发 setState
  bool hasDepend = false;

  /// 每次按下都会记录当前的按下时间
  int? _time;

  /// 延迟释放计时器
  Timer? _timer;

  void setDependFlag(bool value) {
    hasDepend = value;
  }

  void update(bool value) {
    if (hasDepend && _isTap != value) {
      setState(() {
        _isTap = value;
      });
    }
  }

  void _onTap() {
    if (widget.disabled == false && bubbleFlag) {
      widget.onTap?.call();
    }
  }

  void _onTapDown(TapDownDetails e) {
    if (!widget.disabled && bubbleFlag) {
      ElStopPropagation._of(context, _EventBubbleWidget.stopPropagation);
      _time = currentMilliseconds;
      if (_timer != null) {
        _timer!.cancel();
        _timer = null;
        setTimeout(() {
          if (mounted) {
            widget.onTapDown?.call(e);
            update(true);
          }
        }, 16);
      } else {
        widget.onTapDown?.call(e);
        update(true);
      }
    }
  }

  void _onTapUp(TapUpDetails e) {
    if (!widget.disabled && bubbleFlag) {
      reset();
      int delay = widget.delay;
      if (_time != null) {
        delay = max(delay - (currentMilliseconds - _time!), 0);
      }
      _timer = setTimeout(() {
        _timer = null;
        if (mounted) {
          widget.onTapUp?.call(e);
          update(false);
        }
      }, delay);
    }
  }

  void _onTapCancel() {
    reset();
    if (!widget.disabled && bubbleFlag) {
      _timer = setTimeout(() {
        _timer = null;
        if (mounted) {
          widget.onTapCancel?.call();
          update(false);
        }
      }, widget.delay);
    }
  }

  @override
  Widget builder(BuildContext context) {
    final Map<Type, GestureRecognizerFactory> gestures =
        <Type, GestureRecognizerFactory>{};

    gestures[_ClickGestureRecognizer] =
        GestureRecognizerFactoryWithHandlers<_ClickGestureRecognizer>(
      () => _ClickGestureRecognizer(),
      (instance) {
        instance
          ..onTapDown = _onTapDown
          ..onTap = _onTap
          ..onTapUp = _onTapUp
          ..onTapCancel = _onTapCancel;
      },
    );

    return _TapInheritedWidget(
      isTap: _isTap,
      setDependFlag: setDependFlag,
      child: RawGestureDetector(
        behavior: widget.hitTestBehavior,
        gestures: gestures,
        child: Builder(builder: (context) {
          return widget.builder(context);
        }),
      ),
    );
  }
}

class _ClickGestureRecognizer extends TapGestureRecognizer {
  /// 重写点击拒绝事件，将拒绝变为允许，这样将会触发事件冒泡
  @override
  void rejectGesture(int pointer) {
    acceptGesture(pointer);
    super.rejectGesture(pointer);
  }
}

class _TapInheritedWidget extends InheritedWidget {
  const _TapInheritedWidget({
    required super.child,
    required this.isTap,
    required this.setDependFlag,
  });

  final bool isTap;
  final ElBoolVoidCallback setDependFlag;

  static _TapInheritedWidget? maybeOf(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<_TapInheritedWidget>();
    if (result != null) {
      result.setDependFlag(true);
    }
    return result;
  }

  @override
  bool updateShouldNotify(_TapInheritedWidget oldWidget) {
    return isTap != oldWidget.isTap;
  }
}
