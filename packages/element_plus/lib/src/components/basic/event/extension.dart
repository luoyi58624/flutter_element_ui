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

extension ElPointerMoveEventExtension on PointerMoveEvent {
  /// 将 pointUp 原始指针事件转成 [TapUpDetails]
  DragUpdateDetails get toDetails => DragUpdateDetails(
        sourceTimeStamp: timeStamp,
        delta: delta,
        globalPosition: position,
        localPosition: localPosition,
      );
}

extension ElEventExtension on BuildContext {
  /// 通过当前上下文访问最近的 Tap 点击状态，如果引用此变量，[ElEvent] 获得点击事件时将会重建子组件
  bool get isTap => ElEvent.isTap(this);

  /// 通过上下文访问最近的 Hover 悬停状态，如果引用此变量，[ElEvent] 获得悬停事件时将会重建子组件
  bool get isHover => ElEvent.isHover(this);

  /// 阻止事件冒泡，注意：你只能在手势事件函数中执行它，只有这样当指针抬起时才会重置冒泡状态。
  ///
  /// 原理就是运用 [InheritedWidget] 小部件，通过 context 不断向上查找，然后依次更新它们的冒泡标识（bool），
  /// 当上层事件执行时，由于冒泡标识被更改从而阻止逻辑执行，当指针抬起或者指针被取消，再重置冒泡标识。
  ///
  /// 提示：更改标识不会引起 UI 重建，[InheritedWidget] 小部件查找实例很便宜，时间复杂度为 O(1)。
  void stopPropagation() => ElEvent.stopPropagation(this);
}
