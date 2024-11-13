part of 'index.dart';

extension ElEventExtension on BuildContext {
  /// 通过当前上下文访问最近的 Tap 点击状态，如果引用此变量，[ElEvent] 获得点击事件时将会重建子组件
  bool get isTap => ElTap.of(this);

  /// 通过上下文访问最近的 Hover 悬停状态，如果引用此变量，[ElEvent] 获得悬停事件时将会重建子组件
  bool get isHover => ElHover.of(this);

  /// 阻止事件冒泡，从当前上下文所在的节点开始，阻止上层所有目标事件执行
  void stopPropagation() {
    _Event.stopPropagation(this);
  }

  /// 重置事件冒泡
  void resetPropagation() {
    _Event.resetPropagation(this);
  }
}
