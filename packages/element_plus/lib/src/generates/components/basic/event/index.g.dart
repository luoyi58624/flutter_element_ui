// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../components/basic/event/index.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElEventThemeDataExtension on ElEventThemeData {
  /// 接收一组可选参数，返回新的对象
  ElEventThemeData copyWith({
    bool? disabled,
    int? cancelScope,
    bool? prevent,
    int? doubleTapTimeout,
    bool? delayTapForDouble,
    int? longPressTimeout,
    bool? feedback,
    HitTestBehavior? hitTestBehavior,
    MouseCursor? cursor,
    void Function(PointerEnterEvent)? onEnter,
    void Function(PointerExitEvent)? onExit,
    void Function(PointerHoverEvent)? onHover,
    void Function()? onTap,
    void Function()? onContextMenu,
    void Function()? onDoubleTap,
    void Function()? onLongPress,
    void Function(PointerDownEvent)? onPointerDown,
    void Function(PointerUpEvent)? onPointerUp,
    void Function()? onPointerCancel,
    void Function(DragUpdateDetails)? onMove,
    void Function(DragEndDetails)? onMoveEnd,
    void Function(DragUpdateDetails)? onVerticalMove,
    void Function(DragEndDetails)? onVerticalMoveEnd,
    void Function(DragUpdateDetails)? onHorizontalMove,
    void Function(DragEndDetails)? onHorizontalMoveEnd,
    void Function(PointerSignalEvent)? onPointerSignal,
  }) {
    return ElEventThemeData(
      disabled: disabled ?? this.disabled,
      cancelScope: cancelScope ?? this.cancelScope,
      prevent: prevent ?? this.prevent,
      doubleTapTimeout: doubleTapTimeout ?? this.doubleTapTimeout,
      delayTapForDouble: delayTapForDouble ?? this.delayTapForDouble,
      longPressTimeout: longPressTimeout ?? this.longPressTimeout,
      feedback: feedback ?? this.feedback,
      hitTestBehavior: hitTestBehavior ?? this.hitTestBehavior,
      cursor: cursor ?? this.cursor,
      onEnter: onEnter ?? this.onEnter,
      onExit: onExit ?? this.onExit,
      onHover: onHover ?? this.onHover,
      onTap: onTap ?? this.onTap,
      onContextMenu: onContextMenu ?? this.onContextMenu,
      onDoubleTap: onDoubleTap ?? this.onDoubleTap,
      onLongPress: onLongPress ?? this.onLongPress,
      onPointerDown: onPointerDown ?? this.onPointerDown,
      onPointerUp: onPointerUp ?? this.onPointerUp,
      onPointerCancel: onPointerCancel ?? this.onPointerCancel,
      onMove: onMove ?? this.onMove,
      onMoveEnd: onMoveEnd ?? this.onMoveEnd,
      onVerticalMove: onVerticalMove ?? this.onVerticalMove,
      onVerticalMoveEnd: onVerticalMoveEnd ?? this.onVerticalMoveEnd,
      onHorizontalMove: onHorizontalMove ?? this.onHorizontalMove,
      onHorizontalMoveEnd: onHorizontalMoveEnd ?? this.onHorizontalMoveEnd,
      onPointerSignal: onPointerSignal ?? this.onPointerSignal,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElEventThemeData merge([ElEventThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      disabled: other.disabled,
      cancelScope: other.cancelScope,
      prevent: other.prevent,
      doubleTapTimeout: other.doubleTapTimeout,
      delayTapForDouble: other.delayTapForDouble,
      longPressTimeout: other.longPressTimeout,
      feedback: other.feedback,
      hitTestBehavior: other.hitTestBehavior,
      cursor: other.cursor,
      onEnter: other.onEnter,
      onExit: other.onExit,
      onHover: other.onHover,
      onTap: other.onTap,
      onContextMenu: other.onContextMenu,
      onDoubleTap: other.onDoubleTap,
      onLongPress: other.onLongPress,
      onPointerDown: other.onPointerDown,
      onPointerUp: other.onPointerUp,
      onPointerCancel: other.onPointerCancel,
      onMove: other.onMove,
      onMoveEnd: other.onMoveEnd,
      onVerticalMove: other.onVerticalMove,
      onVerticalMoveEnd: other.onVerticalMoveEnd,
      onHorizontalMove: other.onHorizontalMove,
      onHorizontalMoveEnd: other.onHorizontalMoveEnd,
      onPointerSignal: other.onPointerSignal,
    );
  }
}

// **************************************************************************
// ElThemeModelGenerator
// **************************************************************************

class ElEventTheme extends StatelessWidget {
  /// 提供局部默认主题小部件
  const ElEventTheme({
    super.key,
    required this.child,
    required this.data,
  });

  final Widget child;
  final ElEventThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElEventThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ElEventTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElEventThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elTheme.eventTheme;

  @override
  Widget build(BuildContext context) {
    final parent = ElEventTheme.of(context);
    return _ElEventTheme(
      data: parent.merge(data),
      child: child,
    );
  }
}

class _ElEventTheme extends InheritedWidget {
  const _ElEventTheme({
    required super.child,
    required this.data,
  });

  final ElEventThemeData data;

  @override
  bool updateShouldNotify(_ElEventTheme oldWidget) => true;
}