import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_obs/flutter_obs.dart';

import '../animation.dart';

class AnimateObs<T> extends RawObs<T> {
  /// 动画响应式变量
  /// * duration 动画持续时间
  /// * curve 动画曲线
  /// * tween 动画值区间，如果 value 不是 double 类型，你必须手动设置 Tween，例如 [ColorTween]
  ///
  /// 注意：如果是局部变量，你必须在 dispose 生命周期中销毁它，因为 [AnimationController] 必须释放。
  AnimateObs(
    super.value, {
    Duration duration = const Duration(milliseconds: 250),
    Curve curve = Curves.linear,
    Tween<T>? tween,
  }) {
    this._targetValue = value;
    this._controller = AnimationController(vsync: vsync)
      ..addListener(_animationListener);
    this.duration = duration;
    this._curve = curve;
    _setTween(tween);
    _setAnimation();
  }

  late T _targetValue;

  /// 每次更新 [value] 时的目标值
  T get targetValue => _targetValue;

  /// 动画控制器
  late final AnimationController _controller;

  /// 应用了 [_tween] 和 [curve] 的动画值对象
  late Animation<T> _animation;

  late Duration _duration;

  /// 更新动画时间
  set duration(Duration value) {
    _duration = value;
    _controller.duration = _duration;
  }

  late Curve _curve;

  /// 更新动画曲线
  set curve(Curve value) {
    _curve = value;
    _setAnimation();
  }

  late Tween<T> _tween;

  /// 更新动画值区间
  set tween(Tween<T>? tween) {
    _setTween(tween);
    _setAnimation();
  }

  /// 更新响应式变量值，它会对旧值和新值进行线性插值，你可以在更新前设置 [duration]、[curve] 以调整接下来的过渡变化，
  /// 例如临时取消动画：
  /// ```dart
  /// final width = AnimateObs(100.0);
  /// width.duration = Duration.zero;
  /// width.value = 300.0;
  /// ```
  @override
  set value(T value) {
    if (_targetValue != value) {
      setOldValue(_targetValue);
      _targetValue = value;
      _tween.begin = getValue();
      _tween.end = value;
      curve = _curve;
      _controller.forward(from: 0);
    }
  }

  void _animationListener() {
    setValue(_animation.value);
    super.notify();
  }

  void _setAnimation() {
    _animation = _tween.animate(
      CurvedAnimation(
        parent: _controller,
        curve: _curve,
      ),
    );
  }

  void _setTween(Tween<T>? tween) {
    if (tween == null) {
      assert(value is double,
          'AnimateObs value is not double type, Please set custom Tween');
      this._tween = Tween(begin: getValue(), end: getValue());
    } else {
      this._tween = tween;
      this._tween.begin = getValue();
      this._tween.end = getValue();
    }
  }

  /// 当移除小部件时必须执行 dispose 回收动画控制器，执行 dispose 的时机必须在 super.dispose 之前
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
