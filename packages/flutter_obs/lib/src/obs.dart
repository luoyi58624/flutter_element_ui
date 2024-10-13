import 'package:flutter/widgets.dart';

import 'base_obs.dart';

/// 响应式变量监听回调，接收 newValue、oldValue 参数
typedef WatchCallback<T> = void Function(T newValue, T oldValue);

/// 响应式变量通知模式
enum ObsNotifyMode {
  /// 触发所有通知
  all,

  /// 触发 [ObsBuilder] 自动重建
  builders,

  /// 触发构造方法绑定的 watch 监听函数
  watch,

  /// 触发通过 addWatch 添加的所有监听函数
  watchList,

  /// 触发 [ChangeNotifier] 中的所有监听函数
  listeners,
}

/// [Obs] 继承自 [ValueNotifier]，所以支持多种使用方式：
///
/// ```dart
/// const count = BaseObs(0);
///
/// ObsBuilder(
///   builder: (context){
///     return Text('${count.value}');
///   },
/// ),
/// ListenableBuilder(
///   listenable: count,
///   builder: (context, child){
///     return Text('${count.value}');
///   },
/// ),
/// ValueListenableBuilder(
///   valueListenable: count,
///   builder: (context, value, child){
///     return Text('$value');
///   },
/// ),
/// ```
class Obs<T> extends BaseObs<T> {
  /// 创建一个响应式变量，[ObsBuilder] 会收集内部所有响应式变量，当发生变更时会自动重建小部件。
  /// * watch 设置监听回调函数，接收 newValue、oldValue 回调
  /// * immediate 是否立即执行一次监听函数，默认false
  Obs(
    super.value, {
    this.notifyMode = const [ObsNotifyMode.all],
    WatchCallback<T>? watch,
    bool immediate = false,
  }) {
    this._watchFun = watch;
    if (immediate) notifyWatch();
  }

  /// 当响应式变量 setter 方法成功拦截时应用的通知模式，它接收一个数组，默认 [ObsNotifyMode.all]，
  /// 如果是空数组，那么修改响应式变量将不会触发任何通知。
  List<ObsNotifyMode> notifyMode;

  /// 构造方法添加的监听函数
  late final WatchCallback<T>? _watchFun;

  /// 用户手动添加的监听函数集合
  final List<WatchCallback<T>> _watchFunList = [];

  /// 拦截 setter 方法，根据通知策略触发监听函数
  @override
  set value(T newValue) {
    if (getValue() != newValue) {
      oldValue = getValue();
      setValue(newValue);
      if (notifyMode.isNotEmpty) {
        if (notifyMode.contains(ObsNotifyMode.all)) {
          notify();
        } else {
          if (notifyMode.contains(ObsNotifyMode.builders)) notifyBuilders();
          if (notifyMode.contains(ObsNotifyMode.watch)) notifyWatch();
          if (notifyMode.contains(ObsNotifyMode.watchList)) {
            notifyWatchList();
          }
          if (notifyMode.contains(ObsNotifyMode.listeners)) {
            notifyListeners();
          }
        }
      }
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

  /// 通知所有监听函数的执行、包括页面刷新
  @override
  void notify() {
    notifyBuilders();
    notifyWatch();
    notifyWatchList();
    notifyListeners();
  }

  /// 执行通过构造方法添加的监听函数
  notifyWatch() {
    if (_watchFun != null) _watchFun!(getValue(), oldValue);
  }

  /// 执行所有通过 [addWatch] 方法添加的监听函数
  notifyWatchList() {
    for (var fun in _watchFunList) {
      fun(getValue(), oldValue);
    }
  }

  /// 暴露 [ChangeNotifier] 中的通知方法，允许用户可以触发 [ChangeNotifier] 中的监听函数
  @override
  notifyListeners() {
    super.notifyListeners();
  }

  /// 释放所有监听器，一旦执行此变量将不可再次使用，不可使用的限制是来源于 [ChangeNotifier]。
  ///
  /// 如果响应式只有刷新小部件的依赖，你不需要手动调用这个函数，当小部件被卸载时会自动移除监听函数，
  /// 你唯一需要考虑的是手动添加的副作用：
  /// * addListener -> removeListener
  /// * addWatch -> removeWatch
  ///
  /// 你可以一个一个地手动移除监听，也可以直接调用 dispose 清除全部副作用。
  @override
  void dispose() {
    _watchFunList.clear();
    super.dispose();
  }

  /// 如果将响应式变量当字符串使用，你可以省略.value
  @override
  String toString() {
    return value.toString();
  }
}

/// 响应式变量测试工具类
class ObsTest extends Obs {
  ObsTest._(super.value);

  static int getBuilderFunLength<T>(BaseObs<T> obs) {
    return obs.builderFunList.length;
  }

  static int getWatchFunLength<T>(Obs<T> obs) {
    return obs._watchFunList.length;
  }
}
