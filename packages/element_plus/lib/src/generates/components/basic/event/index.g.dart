// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../components/basic/event/index.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElEventThemeDataExtension on ElEventThemeData {
  /// 接收一组可选参数，返回新的对象
  ElEventThemeData copyWith({
    bool? disabled,
    HitTestBehavior? hitTestBehavior,
    MouseCursor? cursor,
    void Function(PointerEnterEvent)? onEnter,
    void Function(PointerExitEvent)? onExit,
    void Function(PointerHoverEvent)? onHover,
    void Function(PointerDownEvent)? onTapDown,
    void Function(PointerUpEvent)? onTapUp,
    int? tapUpDelay,
    void Function()? onTapCancel,
    int? cancelScope,
    void Function()? onTap,
    void Function()? onContextMenu,
    bool? prevent,
    void Function()? onDoubleTap,
    int? doubleTapTimeout,
    bool? delayTapForDouble,
    void Function()? onLongPress,
    int? longPressTimeout,
    bool? feedback,
  }) {
    return ElEventThemeData(
      disabled: disabled ?? this.disabled,
      hitTestBehavior: hitTestBehavior ?? this.hitTestBehavior,
      cursor: cursor ?? this.cursor,
      onEnter: onEnter ?? this.onEnter,
      onExit: onExit ?? this.onExit,
      onHover: onHover ?? this.onHover,
      onTapDown: onTapDown ?? this.onTapDown,
      onTapUp: onTapUp ?? this.onTapUp,
      onTapCancel: onTapCancel ?? this.onTapCancel,
      cancelScope: cancelScope ?? this.cancelScope,
      onTap: onTap ?? this.onTap,
      onContextMenu: onContextMenu ?? this.onContextMenu,
      prevent: prevent ?? this.prevent,
      onDoubleTap: onDoubleTap ?? this.onDoubleTap,
      doubleTapTimeout: doubleTapTimeout ?? this.doubleTapTimeout,
      delayTapForDouble: delayTapForDouble ?? this.delayTapForDouble,
      onLongPress: onLongPress ?? this.onLongPress,
      longPressTimeout: longPressTimeout ?? this.longPressTimeout,
      feedback: feedback ?? this.feedback,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElEventThemeData merge([ElEventThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      disabled: other.disabled,
      hitTestBehavior: other.hitTestBehavior,
      cursor: other.cursor,
      onEnter: other.onEnter,
      onExit: other.onExit,
      onHover: other.onHover,
      onTapDown: other.onTapDown,
      onTapUp: other.onTapUp,
      onTapCancel: other.onTapCancel,
      cancelScope: other.cancelScope,
      onTap: other.onTap,
      onContextMenu: other.onContextMenu,
      prevent: other.prevent,
      onDoubleTap: other.onDoubleTap,
      doubleTapTimeout: other.doubleTapTimeout,
      delayTapForDouble: other.delayTapForDouble,
      onLongPress: other.onLongPress,
      longPressTimeout: other.longPressTimeout,
      feedback: other.feedback,
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
