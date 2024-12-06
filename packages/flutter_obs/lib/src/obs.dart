import 'package:dart_serialize/dart_serialize.dart';
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
    WatchCallback<T>? watch,
    bool immediate = false,
  }) {
    _initialValue = _safeValue(getValue());
    _oldValue = _initialValue;
    this._watchFun = watch;
    if (immediate) notifyWatch();
  }

  late T _initialValue;

  /// [value] 初始值，当执行 [reset] 重置方法时应用它
  T get initialValue => _initialValue;

  late T _oldValue;

  /// 记录上一次 [value] 值
  T get oldValue => _oldValue;

  /// 更新 [oldValue] 断言变量
  bool _oldValueAssert = false;

  /// 设置 [oldValue]，默认使用当前值更新，如果不通过 .value 更新变量那么你要记得先执行此方法，
  /// 防止依赖 [oldValue] 的代码出现异常。
  void setOldValue([T? value]) {
    assert(() {
      _oldValueAssert = true;
      return true;
    }());
    _oldValue = _safeValue(value ?? getValue());
  }

  /// 触发 setter 拦截时应用的通知模式，有时候你可能进行某项操作时，不希望触发所有的副作用监听，
  /// 那么你可以在任意位置临时修改通知模式，
  List<ObsNotifyMode> notifyMode = [ObsNotifyMode.all];

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

  /// 通知所有副作用、包括 UI 刷新。
  ///
  /// 受 Dart 语言的限制，在操作 List、Map、自定义 Model 时，如果不进行完整对象赋值，
  /// 那么无法被 setter 方法拦截，在这种情况下你可以手动调用 [notify] 方法通知 UI 刷新，
  /// 但是，手动执行 [notify] 方法有 2 个注意事项：
  /// * 如果存在依赖 [oldValue] 的代码，请记得执行 [setOldValue]
  /// * 如果你在操作自定义 Model，你需要实现 [Cloneable] 对象克隆接口，否则 [oldValue]、[initialValue] 将出现值引用问题
  @override
  void notify() {
    assert(() {
      if (_oldValueAssert == true) {
        _oldValueAssert = false;
        return true;
      }
      throw '你正在手动执行 notify 副作用通知，在此之前请执行 setOldValue 方法';
    }());
    super.notify();
    notifyWatch();
    notifyWatchList();
  }

  /// 执行通过构造方法添加的监听函数
  @protected
  notifyWatch() {
    if (_watchFun != null) _watchFun!(getValue(), oldValue);
  }

  /// 执行所有通过 [addWatch] 方法添加的监听函数
  @protected
  notifyWatchList() {
    for (var fun in watchFunList) {
      fun(getValue(), oldValue);
    }
  }

  /// 重置响应式变量到初始状态
  void reset() {
    value = _safeValue(_initialValue);
  }

  @override
  void dispose() {
    watchFunList.clear();
    super.dispose();
  }

  /// 安全地进行赋值，防止操作对象时出现值引用问题
  T _safeValue(T value) {
    if (value is Cloneable) {
      return value.clone();
    } else {
      return value;
    }
    // if (value is List) {
    //   return List.from(value).cast<T>();
    // } else if (value is Set) {
    //   return {...value} as T;
    // } else if (value is Map) {
    //   return {...value} as T;
    // } else if (value is Cloneable) {
    //   return value.clone();
    // } else {
    //   return value;
    // }
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
