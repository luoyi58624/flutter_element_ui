part of 'index.dart';

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
  bool get isHover => ElEvent.isHover(this);

  bool get isTap => ElEvent.isTap(this);

  bool get isFocus => ElFocus.isFocus(this);

  bool get isFocusVisible => ElFocus.isFocusVisible(this);

  FocusNode? get focusNode => ElFocus.focusNode(this);

  void stopPropagation() => ElEvent.stopPropagation(this);

  void resetPropagation() => ElEvent.resetPropagation(this);
}
