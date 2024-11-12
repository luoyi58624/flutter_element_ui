part of 'index.dart';

class ElTap extends _Event {
  /// 点击事件构建器，主要有两个功能：
  /// * 延迟更新点击状态，让依赖 tap 事件的元素状态更加明显
  /// * 默认触发事件冒泡，如果 [ElTap] 存在嵌套，内部触发事件上层事件也会触发
  ///
  /// 如果要阻止事件冒泡，请在嵌套小部件之间添加 [ElStopPropagation] 小部件
  const ElTap({
    super.key,
    this.child,
    this.builder,
    this.delay = 100,
    this.disabled = false,
    this.hitTestBehavior = HitTestBehavior.deferToChild,
    this.onTap,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onDoubleTap,
    this.onLongPress,
  })  : assert(delay == 0 || delay >= 50),
        assert(
            (child != null && builder == null) ||
                (child == null && builder != null),
            'ElTap child、builder 参数只能二选一');

  /// 子组件
  final Widget? child;

  /// 功能和 [child] 一样，只不过它会转发 context 对象，允许你通过 [of] 方法访问事件状态
  final WidgetBuilder? builder;

  /// 延迟多少毫秒更新点击状态，默认100毫秒，设置一定的延迟时间可以让点击效果更加明显，
  /// 它适用于依赖 tap 事件而改变状态的元素，防止轻点时 tapDown -> tapUp 之间极短的时间间隔导致看不出任何效果。
  ///
  /// 提示：这个延迟属性只作用于 [onTapUp] 事件，[onTap] 事件不受影响。
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

  /// 双击事件，如果注册那么 [onTap] 会存在 300 毫秒延迟，这是 flutter 手势竞技场的机制
  final GestureTapCallback? onDoubleTap;

  /// 长按事件
  final GestureLongPressCallback? onLongPress;

  /// 根据上下文获取最近的点击状态
  static bool of(BuildContext context) =>
      _TapInheritedWidget.maybeOf(context)?.isTap ?? false;

  @override
  State<ElTap> createState() => _ElTapState();
}

class _ElTapState extends _EventState<ElTap> {
  /// 是否触发点击
  bool _isTap = false;

  /// 是否存在依赖，如果有那么会自动触发 setState
  bool hasDepend = false;

  /// 每次按下都会记录当前的按下时间
  int? _time;

  /// 延迟释放计时器
  Timer? _timer;

  /// 双击计时器，如果启用了双击，如果在 [kDoubleTapTimeout] 延迟下再次点击，将不会触发 onTap 事件
  int? _doubleTapTime;

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
    if (widget.disabled == false && allowed) {
      if (widget.onDoubleTap == null) {
        widget.onTap?.call();
      } else {
        if (currentMilliseconds - _doubleTapTime! >
            kDoubleTapTimeout.inMilliseconds) {
          widget.onTap?.call();
          _doubleTapTime = null;
        }
      }
    }
  }

  void _onTapDown(TapDownDetails e) {
    if (!widget.disabled && allowed) {
      ElStopPropagation._of(context, _Event.stopPropagation);
      if (widget.onDoubleTap != null && _doubleTapTime == null) {
        _doubleTapTime = currentMilliseconds;
      }
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
    if (!widget.disabled && allowed) {
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
    if (!widget.disabled && allowed) {
      _timer = setTimeout(() {
        _timer = null;
        if (mounted) {
          widget.onTapCancel?.call();
          update(false);
        }
      }, widget.delay);
    }
  }

  void _onDoubleTap() {
    if (!widget.disabled && allowed) {
      _doubleTapTime = null;
      widget.onDoubleTap!();
    }
  }

  void _onLongPress() {
    if (!widget.disabled && allowed) {
      widget.onLongPress!();
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

    if (widget.onDoubleTap != null) {
      gestures[DoubleTapGestureRecognizer] =
          GestureRecognizerFactoryWithHandlers<DoubleTapGestureRecognizer>(
        () => DoubleTapGestureRecognizer(),
        (instance) {
          instance.onDoubleTap = _onDoubleTap;
        },
      );
    }

    if (widget.onLongPress != null) {
      gestures[LongPressGestureRecognizer] =
          GestureRecognizerFactoryWithHandlers<LongPressGestureRecognizer>(
        () => LongPressGestureRecognizer(),
        (instance) {
          instance.onLongPress = _onLongPress;
        },
      );
    }

    Widget result;
    if (widget.child != null) {
      result = widget.child!;
    } else {
      result = Builder(builder: (context) {
        return widget.builder!(context);
      });
    }

    return _TapInheritedWidget(
      isTap: _isTap,
      setDependFlag: setDependFlag,
      child: RawGestureDetector(
        behavior: widget.hitTestBehavior,
        gestures: gestures,
        child: result,
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
