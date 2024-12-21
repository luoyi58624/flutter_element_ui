import 'package:element_flutter/element_flutter.dart';
import 'package:flutter/widgets.dart';

import 'obs.dart';

/// 响应式变量监听回调，接收 newValue、oldValue 参数
typedef WatchCallback<T> = void Function(T newValue, T oldValue);

class WatchObs<T> extends Obs<T> {
  /// 创建支持监听 newValue、oldValue 函数的响应式变量
  /// * watch 创建响应式变量时立即设置监听函数
  /// * immediate 是否立即运行一次监听函数
  WatchObs(
    super.value, {
    WatchCallback<T>? watch,
    bool immediate = false,
  }) {
    _initialValue = getValue();
    _oldValue = getValue();
    this._watchFun = watch;
    if (immediate) nextTick(_notifyWatch);
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

  /// [WatchObs] 不推荐手动通知监听，所以添加了 protected 注解，原因有以下 2 点：
  /// * 允许手动监听意味着 setter 方法不会被拦截，watch 监听函数的 oldValue 不会因此更新；
  /// * 直接操作对象会造成值引用问题，它会影响所有通过 = 赋值引起的潜在 bug；
  ///
  /// 你可以强制使用，dart 编译器只是将其屏蔽，或者通过继承覆写 [notify] 方法将其公开，
  /// 当然，前提是你得知晓并避免上面的陷阱：
  /// * 不要依赖 oldValue；
  /// * 不要使用类似与 [reset] 值引用方法，因为当你直接操作原始对象那一刻，对象已经被修改；
  ///
  /// 在 dart 中，拷贝一个对象十分艰难，List、Set、Map 很容易出现类型转换错误，
  /// 库没法动态地替你进行转换，而 Model 模型对象需要你自己实现 copyWith，通常它依赖代码生成器。
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
      _watchFun(getValue(), oldValue);
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
