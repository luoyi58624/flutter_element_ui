// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../components/others/resizer/index.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElResizerThemeDataExtension on ElResizerThemeData {
  /// 接收一组可选参数，返回新的对象
  ElResizerThemeData copyWith({
    double? triggerSize,
  }) {
    return ElResizerThemeData(
      triggerSize: triggerSize ?? this.triggerSize,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElResizerThemeData merge([ElResizerThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      triggerSize: other.triggerSize,
    );
  }

  /// 生成 equals 对象比较方法
  bool _equals(Object other) =>
      identical(this, other) ||
      other is ElResizerThemeData &&
          runtimeType == other.runtimeType &&
          triggerSize == other.triggerSize;

  /// 生成 hashCode 方法
  int get _hashCode => triggerSize.hashCode;
}

// **************************************************************************
// ElThemeModelGenerator
// **************************************************************************

class ElResizerTheme extends StatelessWidget {
  /// 提供局部默认主题小部件，局部默认主题必须强制继承祖先提供的样式
  const ElResizerTheme({
    super.key,
    required this.child,
    required this.data,
  });

  final Widget child;
  final ElResizerThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElResizerThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ElResizerTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElResizerThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elTheme.resizerTheme;

  @override
  Widget build(BuildContext context) {
    final parent = ElResizerTheme.of(context);
    return _ElResizerTheme(
      data: parent.merge(data),
      child: child,
    );
  }
}

class _ElResizerTheme extends InheritedWidget {
  const _ElResizerTheme({
    required super.child,
    required this.data,
  });

  final ElResizerThemeData data;

  @override
  bool updateShouldNotify(_ElResizerTheme oldWidget) => data != oldWidget.data;
}
