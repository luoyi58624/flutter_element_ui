import 'package:flutter/widgets.dart';

part 'builder.dart';

/// 临时 ObsBuilder 小部件重建函数
VoidCallback? _tempBuilderNotifyFun;

/// ObsBuilder 内部允许存在多个 Obs 变量，
/// 此集合就是在 build 过程中收集多个响应式变量 builderFunList 对象
Set<Set<VoidCallback>> _tempBuilderObsList = {};

class Obs<T> extends ValueNotifier<T> {
  /// 创建一个响应式变量，[ObsBuilder] 会自动收集所有依赖，当变量更新时会自动重建 UI：
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
  /// [Obs] 继承 [ValueNotifier] 只是为了兼容以下小部件的用法：
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
  Obs(this._value) : super(_value);

  /// 响应式变量原始值
  T _value;

  /// 当你在 [ObsBuilder] 中通过 .value 访问响应式变量时，会进入 getter 方法绑定依赖
  @override
  T get value {
    bindBuilders();
    return _value;
  }

  /// 拦截 setter 方法，当响应式变量发生更改时触发所有 [ObsBuilder] 刷新
  @override
  set value(T value) {
    if (_value != value) {
      _value = value;
      notify();
    }
  }

  /// [ObsBuilder] 刷新函数集合
  @protected
  final Set<VoidCallback> builderFunList = {};

  /// 将响应式变量与 [ObsBuilder] 进行绑定，在 [ObsBuilder] build 方法中执行用户 builder 函数前，
  /// 会将 setState 函数设置到 [_tempBuilderNotifyFun]，然后执行 builder 函数时，
  /// 如果代码中存在 .value 的响应式变量，则会触发 getter 函数，而 getter 函数将会执行 [bindBuilders] 建立绑定关系。
  @protected
  void bindBuilders() {
    if (_tempBuilderNotifyFun != null) {
      final fun = _tempBuilderNotifyFun!;
      if (!builderFunList.contains(fun)) {
        builderFunList.add(fun);
        _tempBuilderObsList.add(builderFunList);
      }
    }
  }

  /// 执行所有副作用监听函数、包括 UI 页面刷新
  void notify() {
    notifyBuilders();
    notifyListeners();
  }

  /// 通知所有 [ObsBuilder] 小部件刷新
  @protected
  void notifyBuilders() {
    for (var fun in builderFunList) {
      fun();
    }
  }

  /// 提供子类直接访问 [_value] 的方法，避免触发副作用函数
  @protected
  T getValue() => _value;

  /// 提供子类直接修改 [_value] 的方法，避免触发副作用函数
  @protected
  void setValue(T value) {
    _value = value;
  }

  /// 释放所有监听器，只有当你将响应式变量作为局部变量时才可能需要用到它。
  ///
  /// 如果变量只有 [ObsBuilder] 的依赖，那么你不需要调用这个函数，因为当 [ObsBuilder] 被卸载时会自动移除监听函数，
  /// 但如果添加了副作用监听函数，那么建议你在 dispose 生命周期中销毁它，防止潜在的内存泄漏。
  @override
  void dispose() {
    builderFunList.clear();
    super.dispose();
  }

  /// 如果将响应式变量当字符串使用，你可以省略 .value
  @override
  String toString() {
    return value.toString();
  }
}
