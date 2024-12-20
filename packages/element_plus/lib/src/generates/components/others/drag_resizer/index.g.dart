// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../components/others/drag_resizer/index.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

/// 生成的全局默认实体类对象，此对象只用于代码生成器，不推荐用户引用它
final _ElDragResizerData __ElDragResizerData = _ElDragResizerData();

/// 生成 fromJson 方法，将 Map 对象转成实体类
_ElDragResizerData _fromJson(Map<String, dynamic>? json) {
  if (json == null) return __ElDragResizerData;
  return _ElDragResizerData(
    position: $$ElJsonUtil.$custom<Offset?>(
        json, 'position', const ElOffsetSerialize()),
    size: $$ElJsonUtil.$custom<Size?>(json, 'size', const ElSizeSerialize()),
  );
}

extension _ElDragResizerDataExtension on _ElDragResizerData {
  /// 生成 toJson 方法，将实体类转成 Map 对象
  Map<String, dynamic> _toJson() {
    return {
      'position': const ElOffsetSerialize().serialize(position),
      'size': const ElSizeSerialize().serialize(size),
    };
  }

  /// 接收一组可选参数，返回新的对象
  _ElDragResizerData copyWith({
    Offset? position,
    Size? size,
  }) {
    return _ElDragResizerData(
      position: position ?? this.position,
      size: size ?? this.size,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  _ElDragResizerData merge([_ElDragResizerData? other]) {
    if (other == null) return this;
    return copyWith(
      position: other.position,
      size: other.size,
    );
  }

  /// 生成 equals 对象比较方法
  bool _equals(Object other) =>
      identical(this, other) ||
      other is _ElDragResizerData &&
          runtimeType == other.runtimeType &&
          position == other.position &&
          size == other.size;

  /// 生成 hashCode 方法
  int get _hashCode => position.hashCode ^ size.hashCode;

  /// 生成 toString 方法
  String _toString() {
    return '_ElDragResizerData{\n  position: $position,\n  size: $size\n}';
  }
}

extension ElDragResizerThemeDataExtension on ElDragResizerThemeData {
  /// 接收一组可选参数，返回新的对象
  ElDragResizerThemeData copyWith({
    double? triggerSize,
  }) {
    return ElDragResizerThemeData(
      triggerSize: triggerSize ?? this.triggerSize,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElDragResizerThemeData merge([ElDragResizerThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      triggerSize: other.triggerSize,
    );
  }

  /// 生成 equals 对象比较方法
  bool _equals(Object other) =>
      identical(this, other) ||
      other is ElDragResizerThemeData &&
          runtimeType == other.runtimeType &&
          triggerSize == other.triggerSize;

  /// 生成 hashCode 方法
  int get _hashCode => triggerSize.hashCode;
}

// **************************************************************************
// ElThemeModelGenerator
// **************************************************************************

class ElDragResizerTheme extends StatelessWidget {
  /// 提供局部默认主题小部件，局部默认主题必须强制继承祖先提供的样式
  const ElDragResizerTheme({
    super.key,
    required this.child,
    required this.data,
  });

  final Widget child;
  final ElDragResizerThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElDragResizerThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ElDragResizerTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElDragResizerThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elTheme.dragResizerTheme;

  @override
  Widget build(BuildContext context) {
    final parent = ElDragResizerTheme.of(context);
    return _ElDragResizerTheme(
      data: parent.merge(data),
      child: child,
    );
  }
}

class _ElDragResizerTheme extends InheritedWidget {
  const _ElDragResizerTheme({
    required super.child,
    required this.data,
  });

  final ElDragResizerThemeData data;

  @override
  bool updateShouldNotify(_ElDragResizerTheme oldWidget) =>
      data != oldWidget.data;
}
