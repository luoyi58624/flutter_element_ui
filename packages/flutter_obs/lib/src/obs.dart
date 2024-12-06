import 'package:flutter/widgets.dart';

import 'raw_obs.dart';

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

class Obs<T> extends RawObs<T> {
  /// 创建一个响应式变量，你可以在任意地方创建它，它既可以当做全局状态、也可以当做局部变量使用。
  /// * notifyMode 通知模式，如果你想手动更新 UI 那么请传递空数组
  /// * watch 设置监听回调函数，接收 newValue、oldValue 回调
  /// * immediate 是否立即执行一次监听函数，默认false
  ///
  /// 在 [ObsBuilder] 中使用时会自动收集所有依赖的响应式变量：
  /// ```dart
  /// const count = Obs(0);
  ///
  /// ObsBuilder(
  ///   builder: (context){
  ///     return Text('${count.value}');
  ///   },
  /// ),
  /// ```
  ///
  /// 由于 [RawObs] 继承自 [ValueNotifier]，所以它也兼容以下小部件：
  /// ```dart
  /// const count = Obs(0);
  ///
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
  /// 如果是空数组，那么修改响应式变量将不会触发任何通知
  List<ObsNotifyMode> notifyMode;

  /// 构造方法添加的监听函数
  late final WatchCallback<T>? _watchFun;

  /// 用户手动添加的监听函数集合
  @protected
  final List<WatchCallback<T>> watchFunList = [];

  /// 拦截 setter 方法，根据通知策略触发监听函数
  @override
  set value(T newValue) {
    if (getValue() != newValue) {
      setOldValue();
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
    if (watchFunList.contains(fun) == false) {
      watchFunList.add(fun);
    }
  }

  /// 移除监听函数
  void removeWatch(WatchCallback<T> fun) {
    watchFunList.remove(fun);
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
    for (var fun in watchFunList) {
      fun(getValue(), oldValue);
    }
  }

  /// 释放所有监听器，只有当你将响应式变量作为局部变量时才可能需要用到它。
  ///
  /// 但如果响应式只有刷新小部件的依赖，你完全不需要调用这个函数，因为当小部件被卸载时会自动移除监听函数，
  /// 但如果添加了副作用监听函数、或者说你重度使用了该变量，其他 [Widget] 可能会添加各种隐式依赖，
  /// 为了安全起见，建议你在 dispose 生命周期中明确销毁它，杜绝内存泄漏的风险。
  @override
  void dispose() {
    watchFunList.clear();
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

  static int getBuilderFunLength<T>(RawObs<T> obs) {
    return obs.builderFunList.length;
  }

  static int getWatchFunLength<T>(Obs<T> obs) {
    return obs.watchFunList.length;
  }
}
