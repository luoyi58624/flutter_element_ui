part of 'index.dart';

extension ElEventExtension on BuildContext {
  /// 通过当前上下文访问最近的 Tap 点击状态
  bool get isTap => ElTapBuilder.of(this);

  /// 通过上下文访问最近的 Hover 悬停状态
  bool get isHover => ElHoverBuilder.of(this);

  /// 阻止事件冒泡，从当前上下文所在的节点开始，阻止上层所有目标事件执行
  void stopPropagation() {
    ElEvent.stopPropagation(this);
  }

  /// 重置事件冒泡
  void resetPropagation() {
    ElEvent.resetPropagation(this);
  }
}
