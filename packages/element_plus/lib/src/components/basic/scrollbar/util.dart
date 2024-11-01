part of 'index.dart';

Offset _getLocalOffset(GlobalKey scrollbarPainterKey, Offset position) {
  final RenderBox renderBox =
      scrollbarPainterKey.currentContext!.findRenderObject()! as RenderBox;
  return renderBox.globalToLocal(position);
}
