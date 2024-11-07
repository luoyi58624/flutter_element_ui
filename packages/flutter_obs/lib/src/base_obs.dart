import 'package:flutter/widgets.dart';

part 'builder.dart';

/// 临时 ObsBuilder 小部件重建函数
VoidCallback? _tempBuilderNotifyFun;

/// ObsBuilder 内部允许存在多个 Obs 变量，
/// 此集合就是在 build 过程中收集多个响应式变量 builderFunList 对象
Set<Set<VoidCallback>> _tempBuilderObsList = {};

class BaseObs<T> extends ValueNotifier<T> {
  /// 提供最基础的响应式变量实现，它只负责与 [ObsBuilder] 建立联系
  BaseObs(this._value) : super(_value) {
    this.initialValue = _value;
    this.oldValue = _value;
  }

  /// [_value] 初始值，当执行 [reset] 重置方法时应用它
  late T initialValue;

  /// 记录上一次 [_value] 值
  late T oldValue;

  /// 响应式变量原始值
  T _value;

  /// 当小部件被 [ObsBuilder] 包裹时，它会追踪内部的响应式变量
  @override
  T get value {
    bindBuilders();
    return _value;
  }

  /// 拦截 setter 方法，当响应式变量发生更改时触发所有 [ObsBuilder] 刷新
  @override
  set value(T value) {
    if (_value != value) {
      oldValue = _value;
      _value = value;
      notifyBuilders();
    }
  }

  /// [ObsBuilder] 刷新函数集合
  @protected
  final Set<VoidCallback> builderFunList = {};

  /// 提供子类直接访问 [_value] 的方法，避免触发副作用函数
  @protected
  T getValue() => _value;

  /// 提供子类直接修改 [_value] 的方法，避免触发副作用函数
  @protected
  void setValue(T value) {
    _value = value;
  }

  /// 将响应式变量与 [ObsBuilder] 进行绑定，在 [ObsBuilder] build 方法中，在执行用户 builder 函数前，
  /// 会将刷新页面函数设置到 [_tempBuilderNotifyFun]，执行用户的 builder 函数时，
  /// 如果代码中存在 .value 的响应式变量，则会触发 getter 函数，执行 [bindBuilders]。
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

  /// 通知响应式变量所有监听函数
  void notify() {
    notifyBuilders();
    notifyListeners();
  }

  /// 通知所有 [ObsBuilder] 小部件刷新
  void notifyBuilders() {
    for (var fun in builderFunList) {
      fun();
    }
  }

  /// 重置响应式变量到初始状态
  void reset() {
    value = initialValue;
  }

  @override
  void dispose() {
    builderFunList.clear();
    super.dispose();
  }
}