import 'package:flutter/widgets.dart';

import 'obs.dart';

/// 响应式变量监听回调，接收 newValue、oldValue 参数
typedef WatchCallback<T> = void Function(T newValue, T oldValue);

class WatchObs<T> extends Obs<T> {
  /// 创建支持监听 newValue、oldValue 函数的响应式变量
  WatchObs(
    super.value, {
    WatchCallback<T>? watch,
    bool immediate = false,
  }) {
    _initialValue = getValue();
    _oldValue = getValue();
    this._watchFun = watch;
    if (immediate) _notifyWatch();
  }

  late T _initialValue;

  /// [value] 初始值，当执行 [reset] 重置方法时应用它
  T get initialValue => _initialValue;

  late T _oldValue;

  /// 记录上一次 [value] 值
  T get oldValue => _oldValue;

  /// 构造方法添加的监听函数
  late final WatchCallback<T>? _watchFun;

  /// 用户手动添加的监听函数集合
  final List<WatchCallback<T>> _watchFunList = [];

  /// 拦截 setter 方法，根据通知策略触发监听函数
  @override
  set value(T newValue) {
    if (getValue() != newValue) {
      setOldValue();
      setValue(newValue);
      notify();
    }
  }

  /// 添加监听函数，接收 newValue、oldValue 两个参数
  void addWatch(WatchCallback<T> fun) {
    if (_watchFunList.contains(fun) == false) {
      _watchFunList.add(fun);
    }
  }

  /// 移除监听函数
  void removeWatch(WatchCallback<T> fun) {
    _watchFunList.remove(fun);
  }

  @protected
  void setOldValue([T? value]) {
    _oldValue = value ?? getValue();
  }

  /// [WatchObs] 不允许手动通知监听，原因如下：
  /// * [oldValue] 无法被 setter 拦截，导致无法更新
  /// * 直接操作对象会造成值引用问题，这点是最致命的问题，它会让程序出现各种难以预料的 bug
  @protected
  @override
  void notify() {
    super.notify();
    _notifyWatch();
    _notifyWatchList();
  }

  /// 执行通过构造方法添加的监听函数
  _notifyWatch() {
    if (_watchFun != null) {
      _watchFun!(getValue(), oldValue);
    }
  }

  /// 执行所有通过 [addWatch] 方法添加的监听函数
  _notifyWatchList() {
    for (var fun in _watchFunList) {
      fun(getValue(), oldValue);
    }
  }

  /// 重置响应式变量到初始状态
  void reset() {
    value = _initialValue;
  }

  @override
  void dispose() {
    _watchFunList.clear();
    super.dispose();
  }
}
