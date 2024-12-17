// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../components/basic/event/event.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElEventThemeDataExtension on ElEventThemeData {
  /// 接收一组可选参数，返回新的对象
  ElEventThemeData copyWith({
    bool? disabled,
    bool? autofocus,
    bool? canRequestFocus,
    int? cancelScope,
    bool? prevent,
    int? tapUpDelay,
    int? doubleTapTimeout,
    bool? delayTapForDouble,
    int? longPressTimeout,
    bool? feedback,
    int? triggerDragScope,
    double? minVelocity,
    double? maxVelocity,
    HitTestBehavior? behavior,
    MouseCursor? cursor,
    void Function(PointerEnterEvent)? onEnter,
    void Function(PointerExitEvent)? onExit,
    void Function(PointerHoverEvent)? onHover,
    void Function()? onTap,
    void Function(TapDownDetails)? onTapDown,
    void Function(TapUpDetails)? onTapUp,
    void Function()? onSecondaryTap,
    void Function(TapDownDetails)? onSecondaryTapDown,
    void Function(TapUpDetails)? onSecondaryTapUp,
    void Function()? onTertiaryTap,
    void Function(TapDownDetails)? onTertiaryTapDown,
    void Function(TapUpDetails)? onTertiaryTapUp,
    void Function(PointerDownEvent)? onTapOutside,
    void Function()? onDoubleTap,
    void Function()? onLongPress,
    void Function(DragStartDetails)? onDragStart,
    void Function(DragUpdateDetails)? onDragUpdate,
    void Function(DragEndDetails)? onDragEnd,
    void Function(DragStartDetails)? onVerticalDragStart,
    void Function(DragUpdateDetails)? onVerticalDragUpdate,
    void Function(DragEndDetails)? onVerticalDragEnd,
    void Function(DragStartDetails)? onHorizontalDragStart,
    void Function(DragUpdateDetails)? onHorizontalDragUpdate,
    void Function(DragEndDetails)? onHorizontalDragEnd,
    void Function(PointerDownEvent)? onPointerDown,
    void Function(PointerUpEvent)? onPointerUp,
    void Function(PointerMoveEvent)? onPointerMove,
    void Function(PointerPanZoomStartEvent)? onPointerPanZoomStart,
    void Function(PointerPanZoomUpdateEvent)? onPointerPanZoomUpdate,
    void Function(PointerPanZoomEndEvent)? onPointerPanZoomEnd,
    void Function(PointerSignalEvent)? onPointerSignal,
    void Function()? onCancel,
  }) {
    return ElEventThemeData(
      disabled: disabled ?? this.disabled,
      autofocus: autofocus ?? this.autofocus,
      canRequestFocus: canRequestFocus ?? this.canRequestFocus,
      cancelScope: cancelScope ?? this.cancelScope,
      prevent: prevent ?? this.prevent,
      tapUpDelay: tapUpDelay ?? this.tapUpDelay,
      doubleTapTimeout: doubleTapTimeout ?? this.doubleTapTimeout,
      delayTapForDouble: delayTapForDouble ?? this.delayTapForDouble,
      longPressTimeout: longPressTimeout ?? this.longPressTimeout,
      feedback: feedback ?? this.feedback,
      triggerDragScope: triggerDragScope ?? this.triggerDragScope,
      minVelocity: minVelocity ?? this.minVelocity,
      maxVelocity: maxVelocity ?? this.maxVelocity,
      behavior: behavior ?? this.behavior,
      cursor: cursor ?? this.cursor,
      onEnter: onEnter ?? this.onEnter,
      onExit: onExit ?? this.onExit,
      onHover: onHover ?? this.onHover,
      onTap: onTap ?? this.onTap,
      onTapDown: onTapDown ?? this.onTapDown,
      onTapUp: onTapUp ?? this.onTapUp,
      onSecondaryTap: onSecondaryTap ?? this.onSecondaryTap,
      onSecondaryTapDown: onSecondaryTapDown ?? this.onSecondaryTapDown,
      onSecondaryTapUp: onSecondaryTapUp ?? this.onSecondaryTapUp,
      onTertiaryTap: onTertiaryTap ?? this.onTertiaryTap,
      onTertiaryTapDown: onTertiaryTapDown ?? this.onTertiaryTapDown,
      onTertiaryTapUp: onTertiaryTapUp ?? this.onTertiaryTapUp,
      onTapOutside: onTapOutside ?? this.onTapOutside,
      onDoubleTap: onDoubleTap ?? this.onDoubleTap,
      onLongPress: onLongPress ?? this.onLongPress,
      onDragStart: onDragStart ?? this.onDragStart,
      onDragUpdate: onDragUpdate ?? this.onDragUpdate,
      onDragEnd: onDragEnd ?? this.onDragEnd,
      onVerticalDragStart: onVerticalDragStart ?? this.onVerticalDragStart,
      onVerticalDragUpdate: onVerticalDragUpdate ?? this.onVerticalDragUpdate,
      onVerticalDragEnd: onVerticalDragEnd ?? this.onVerticalDragEnd,
      onHorizontalDragStart:
          onHorizontalDragStart ?? this.onHorizontalDragStart,
      onHorizontalDragUpdate:
          onHorizontalDragUpdate ?? this.onHorizontalDragUpdate,
      onHorizontalDragEnd: onHorizontalDragEnd ?? this.onHorizontalDragEnd,
      onPointerDown: onPointerDown ?? this.onPointerDown,
      onPointerUp: onPointerUp ?? this.onPointerUp,
      onPointerMove: onPointerMove ?? this.onPointerMove,
      onPointerPanZoomStart:
          onPointerPanZoomStart ?? this.onPointerPanZoomStart,
      onPointerPanZoomUpdate:
          onPointerPanZoomUpdate ?? this.onPointerPanZoomUpdate,
      onPointerPanZoomEnd: onPointerPanZoomEnd ?? this.onPointerPanZoomEnd,
      onPointerSignal: onPointerSignal ?? this.onPointerSignal,
      onCancel: onCancel ?? this.onCancel,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElEventThemeData merge([ElEventThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      disabled: other.disabled,
      autofocus: other.autofocus,
      canRequestFocus: other.canRequestFocus,
      cancelScope: other.cancelScope,
      prevent: other.prevent,
      tapUpDelay: other.tapUpDelay,
      doubleTapTimeout: other.doubleTapTimeout,
      delayTapForDouble: other.delayTapForDouble,
      longPressTimeout: other.longPressTimeout,
      feedback: other.feedback,
      triggerDragScope: other.triggerDragScope,
      minVelocity: other.minVelocity,
      maxVelocity: other.maxVelocity,
      behavior: other.behavior,
      cursor: other.cursor,
      onEnter: other.onEnter,
      onExit: other.onExit,
      onHover: other.onHover,
      onTap: other.onTap,
      onTapDown: other.onTapDown,
      onTapUp: other.onTapUp,
      onSecondaryTap: other.onSecondaryTap,
      onSecondaryTapDown: other.onSecondaryTapDown,
      onSecondaryTapUp: other.onSecondaryTapUp,
      onTertiaryTap: other.onTertiaryTap,
      onTertiaryTapDown: other.onTertiaryTapDown,
      onTertiaryTapUp: other.onTertiaryTapUp,
      onTapOutside: other.onTapOutside,
      onDoubleTap: other.onDoubleTap,
      onLongPress: other.onLongPress,
      onDragStart: other.onDragStart,
      onDragUpdate: other.onDragUpdate,
      onDragEnd: other.onDragEnd,
      onVerticalDragStart: other.onVerticalDragStart,
      onVerticalDragUpdate: other.onVerticalDragUpdate,
      onVerticalDragEnd: other.onVerticalDragEnd,
      onHorizontalDragStart: other.onHorizontalDragStart,
      onHorizontalDragUpdate: other.onHorizontalDragUpdate,
      onHorizontalDragEnd: other.onHorizontalDragEnd,
      onPointerDown: other.onPointerDown,
      onPointerUp: other.onPointerUp,
      onPointerMove: other.onPointerMove,
      onPointerPanZoomStart: other.onPointerPanZoomStart,
      onPointerPanZoomUpdate: other.onPointerPanZoomUpdate,
      onPointerPanZoomEnd: other.onPointerPanZoomEnd,
      onPointerSignal: other.onPointerSignal,
      onCancel: other.onCancel,
    );
  }

  /// 生成 equals 对象比较方法
  bool _equals(Object other) =>
      identical(this, other) ||
      other is ElEventThemeData &&
          runtimeType == other.runtimeType &&
          disabled == other.disabled &&
          autofocus == other.autofocus &&
          canRequestFocus == other.canRequestFocus &&
          cancelScope == other.cancelScope &&
          prevent == other.prevent &&
          tapUpDelay == other.tapUpDelay &&
          doubleTapTimeout == other.doubleTapTimeout &&
          delayTapForDouble == other.delayTapForDouble &&
          longPressTimeout == other.longPressTimeout &&
          feedback == other.feedback &&
          triggerDragScope == other.triggerDragScope &&
          minVelocity == other.minVelocity &&
          maxVelocity == other.maxVelocity &&
          behavior == other.behavior &&
          cursor == other.cursor &&
          onEnter == other.onEnter &&
          onExit == other.onExit &&
          onHover == other.onHover &&
          onTap == other.onTap &&
          onTapDown == other.onTapDown &&
          onTapUp == other.onTapUp &&
          onSecondaryTap == other.onSecondaryTap &&
          onSecondaryTapDown == other.onSecondaryTapDown &&
          onSecondaryTapUp == other.onSecondaryTapUp &&
          onTertiaryTap == other.onTertiaryTap &&
          onTertiaryTapDown == other.onTertiaryTapDown &&
          onTertiaryTapUp == other.onTertiaryTapUp &&
          onTapOutside == other.onTapOutside &&
          onDoubleTap == other.onDoubleTap &&
          onLongPress == other.onLongPress &&
          onDragStart == other.onDragStart &&
          onDragUpdate == other.onDragUpdate &&
          onDragEnd == other.onDragEnd &&
          onVerticalDragStart == other.onVerticalDragStart &&
          onVerticalDragUpdate == other.onVerticalDragUpdate &&
          onVerticalDragEnd == other.onVerticalDragEnd &&
          onHorizontalDragStart == other.onHorizontalDragStart &&
          onHorizontalDragUpdate == other.onHorizontalDragUpdate &&
          onHorizontalDragEnd == other.onHorizontalDragEnd &&
          onPointerDown == other.onPointerDown &&
          onPointerUp == other.onPointerUp &&
          onPointerMove == other.onPointerMove &&
          onPointerPanZoomStart == other.onPointerPanZoomStart &&
          onPointerPanZoomUpdate == other.onPointerPanZoomUpdate &&
          onPointerPanZoomEnd == other.onPointerPanZoomEnd &&
          onPointerSignal == other.onPointerSignal &&
          onCancel == other.onCancel;

  /// 生成 hashCode 方法
  int get _hashCode =>
      disabled.hashCode ^
      autofocus.hashCode ^
      canRequestFocus.hashCode ^
      cancelScope.hashCode ^
      prevent.hashCode ^
      tapUpDelay.hashCode ^
      doubleTapTimeout.hashCode ^
      delayTapForDouble.hashCode ^
      longPressTimeout.hashCode ^
      feedback.hashCode ^
      triggerDragScope.hashCode ^
      minVelocity.hashCode ^
      maxVelocity.hashCode ^
      behavior.hashCode ^
      cursor.hashCode ^
      onEnter.hashCode ^
      onExit.hashCode ^
      onHover.hashCode ^
      onTap.hashCode ^
      onTapDown.hashCode ^
      onTapUp.hashCode ^
      onSecondaryTap.hashCode ^
      onSecondaryTapDown.hashCode ^
      onSecondaryTapUp.hashCode ^
      onTertiaryTap.hashCode ^
      onTertiaryTapDown.hashCode ^
      onTertiaryTapUp.hashCode ^
      onTapOutside.hashCode ^
      onDoubleTap.hashCode ^
      onLongPress.hashCode ^
      onDragStart.hashCode ^
      onDragUpdate.hashCode ^
      onDragEnd.hashCode ^
      onVerticalDragStart.hashCode ^
      onVerticalDragUpdate.hashCode ^
      onVerticalDragEnd.hashCode ^
      onHorizontalDragStart.hashCode ^
      onHorizontalDragUpdate.hashCode ^
      onHorizontalDragEnd.hashCode ^
      onPointerDown.hashCode ^
      onPointerUp.hashCode ^
      onPointerMove.hashCode ^
      onPointerPanZoomStart.hashCode ^
      onPointerPanZoomUpdate.hashCode ^
      onPointerPanZoomEnd.hashCode ^
      onPointerSignal.hashCode ^
      onCancel.hashCode;
}

// **************************************************************************
// ElThemeModelGenerator
// **************************************************************************

class ElEventTheme extends StatelessWidget {
  /// 提供局部默认主题小部件，局部默认主题必须强制继承祖先提供的样式
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
  bool updateShouldNotify(_ElEventTheme oldWidget) => data != oldWidget.data;
}
