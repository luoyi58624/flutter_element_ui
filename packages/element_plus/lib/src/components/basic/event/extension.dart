part of 'event.dart';

extension ElPointerDownEventExtension on PointerDownEvent {
  TapDownDetails get toDetails => TapDownDetails(
        globalPosition: position,
        localPosition: localPosition,
        kind: kind,
      );
}

extension ElPointerUpEventExtension on PointerUpEvent {
  TapUpDetails get toDetails => TapUpDetails(
        globalPosition: position,
        localPosition: localPosition,
        kind: kind,
      );
}

extension ElPointerMoveEventExtension on PointerMoveEvent {
  DragUpdateDetails get toDetails => DragUpdateDetails(
        sourceTimeStamp: timeStamp,
        delta: delta,
        globalPosition: position,
        localPosition: localPosition,
      );
}

extension ElEventExtension on BuildContext {
  /// 是否激活了 hover 悬停状态，如果 [Widget] 依赖此变量，那么当鼠标悬停时将会重建小部件
  bool get hasHover => ElEvent.hasHover(this);

  /// 是否激活了 tap 点击状态，如果 [Widget] 依赖此变量，那么当点击时将会重建小部件
  bool get hasTap => ElEvent.hasTap(this);

  /// 是否激活了 focus 焦点状态，判断元素是否得到焦点不要通过 [Focus.of]，
  /// [Focus] 没有限制作用域，会导致你的小部件意外地得到焦点。
  bool get hasFocus => ElEvent.hasFocus(this);
}
