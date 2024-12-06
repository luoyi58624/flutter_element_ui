import 'package:dart_serialize/dart_serialize.dart';
import 'package:flutter/widgets.dart';

part 'builder.dart';

/// 临时 ObsBuilder 小部件重建函数
VoidCallback? _tempBuilderNotifyFun;

/// ObsBuilder 内部允许存在多个 Obs 变量，
/// 此集合就是在 build 过程中收集多个响应式变量 builderFunList 对象
Set<Set<VoidCallback>> _tempBuilderObsList = {};

/// 响应式变量的核心实现，主要负责与 [ObsBuilder] 建立关联
class RawObs<T> extends ValueNotifier<T> {
  RawObs(this._value) : super(_value) {
    _initialValue = _safeValue(_value);
    setOldValue();
  }

  late T _initialValue;

  /// [value] 初始值，当执行 [reset] 重置方法时应用它
  T get initialValue => _initialValue;

  late T _oldValue;

  /// 记录上一次 [value] 值
  T get oldValue => _oldValue;

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
      setOldValue();
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

  /// 设置 [oldValue]，默认使用当前值更新，如果不通过 .value 更新变量那么你要记得先执行此方法，
  /// 防止依赖 [oldValue] 的代码出现异常。
  void setOldValue([T? value]) {
    _oldValue = _safeValue(value ?? _value);
  }

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

  /// 执行所有副作用监听函数、包括 UI 页面刷新，通过 .value 更新变量会进入 setter 方法拦截，
  /// 从而自动执行 [notify] 通知函数，无需用户手动通知。
  ///
  /// 但是受 Dart 语言的限制，在操作 List、Map、自定义 Model 时，如果不进行完整对象赋值，
  /// 那么无法被 setter 方法拦截，在这种情况下你可以手动调用 [notify] 方法通知 UI 刷新，
  /// 但是，手动执行 [notify] 方法有 2 个注意事项：
  /// * 如果存在依赖 [oldValue] 的代码，请记得执行 [setOldValue]
  /// * 如果你在操作自定义 Model，你需要实现 [Cloneable] 对象克隆接口，否则 [oldValue]、[initialValue] 将出现值引用问题
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

  /// 暴露 [ChangeNotifier] 中的通知方法，允许用户可以手动触发 [ChangeNotifier] 中的监听函数
  @override
  notifyListeners() {
    super.notifyListeners();
  }

  /// 重置响应式变量到初始状态
  void reset() {
    value = _safeValue(_initialValue);
  }

  @override
  void dispose() {
    builderFunList.clear();
    super.dispose();
  }

  /// 安全地进行赋值，防止操作对象时出现值引用问题
  T _safeValue(T value) {
    if (value is List) {
      return [...value] as T;
    } else if (value is Set) {
      return {...value} as T;
    } else if (value is Map) {
      return {...value} as T;
    } else if (value is Cloneable) {
      return value.clone();
    } else {
      return value;
    }
  }
}
