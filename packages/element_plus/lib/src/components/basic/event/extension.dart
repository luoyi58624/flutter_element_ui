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
  /// 通过上下文访问最近的 Hover 悬停状态，如果引用此变量，[ElEvent] 获得悬停事件时将会重建子组件
  bool get isHover => ElEvent.isHover(this);

  /// 通过当前上下文访问最近的 Tap 点击状态，如果引用此变量，[ElEvent] 获得点击事件时将会重建子组件
  bool get isTap => ElEvent.isTap(this);

  /// 阻止事件冒泡，在大部分情况下你只需嵌套 [ElStopPropagation] 小部件即可，它更简单，
  /// 你无需考虑 context 作用域问题，但如果你想要控制阻止事件冒泡的时机，例如：
  /// 只阻止 onTap 事件但希望父级 onTapDown 能正常触发，那么你可以在 onTap 中执行此函数。
  ///
  /// 它的原理就是运用 [InheritedWidget] 小部件，通过 context 不断向上查找，然后依次更新它们的冒泡标识（bool），
  /// 当上层事件执行时，由于冒泡标识被更改从而阻止逻辑执行，当指针抬起或者指针被取消，再重置冒泡标识。
  ///
  /// 提示：更改冒泡标识不会引起 UI 重建，查找 [InheritedWidget] 小部件的实例很便宜，时间复杂度为 O(1)。
  void stopPropagation() => ElEvent.stopPropagation(this);

  /// 重置事件冒泡，如果 [stopPropagation] 是手动触发的（鼠标点击、手指按下），
  /// 那么被阻止的事件在指针抬起时会自动重置冒泡标识，但你若是通过隐式方式调用 [stopPropagation]，
  /// 那么你必须在逻辑处理完后手动重置冒泡标识，否则上层事件将永远无法触发。
  void resetPropagation() => ElEvent.resetPropagation(this);
}
