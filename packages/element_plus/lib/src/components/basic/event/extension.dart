part of 'index.dart';

extension ElPointerDownEventExtension on PointerDownEvent {
  /// 将 pointDown 原始指针事件转成 [TapDownDetails]
  TapDownDetails get toDetails => TapDownDetails(
        globalPosition: position,
        localPosition: localPosition,
        kind: kind,
      );
}

extension ElPointerUpEventExtension on PointerUpEvent {
  /// 将 pointUp 原始指针事件转成 [TapUpDetails]
  TapUpDetails get toDetails => TapUpDetails(
        globalPosition: position,
        localPosition: localPosition,
        kind: kind,
      );
}

extension ElEventExtension on BuildContext {
  /// 通过当前上下文访问最近的 Tap 点击状态，如果引用此变量，[ElEvent] 获得点击事件时将会重建子组件
  bool get isTap => ElEvent.isTap(this);

  /// 通过上下文访问最近的 Hover 悬停状态，如果引用此变量，[ElEvent] 获得悬停事件时将会重建子组件
  bool get isHover => ElEvent.isHover(this);

  /// 阻止事件冒泡
  void stopPropagation() => ElEvent.stopPropagation(this);

  /// 重置事件冒泡
  void resetPropagation() {
    // _Event.resetPropagation(this);
  }
}
