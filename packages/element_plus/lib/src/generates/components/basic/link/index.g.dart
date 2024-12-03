// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../components/basic/link/index.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElLinkThemeDataExtension on ElLinkThemeData {
  /// 接收一组可选参数，返回新的对象
  ElLinkThemeData copyWith({
    Color? color,
    Color? activeColor,
    ElLinkDecoration? decoration,
    bool? allowDrag,
  }) {
    return ElLinkThemeData(
      color: color ?? this.color,
      activeColor: activeColor ?? this.activeColor,
      decoration: decoration ?? this.decoration,
      allowDrag: allowDrag ?? this.allowDrag,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElLinkThemeData merge([ElLinkThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      color: other.color,
      activeColor: other.activeColor,
      decoration: other.decoration,
      allowDrag: other.allowDrag,
    );
  }

  /// 生成 equals 对象比较方法
  bool _equals(Object other) =>
      identical(this, other) ||
      other is ElLinkThemeData &&
          runtimeType == other.runtimeType &&
          color == other.color &&
          activeColor == other.activeColor &&
          decoration == other.decoration &&
          allowDrag == other.allowDrag;

  /// 生成 hashCode 方法
  int get _hashCode =>
      color.hashCode ^
      activeColor.hashCode ^
      decoration.hashCode ^
      allowDrag.hashCode;
}

// **************************************************************************
// ElThemeModelGenerator
// **************************************************************************

class ElLinkTheme extends StatelessWidget {
  /// 提供局部默认主题小部件，局部默认主题必须强制继承祖先提供的样式
  const ElLinkTheme({
    super.key,
    required this.child,
    required this.data,
  });

  final Widget child;
  final ElLinkThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElLinkThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ElLinkTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElLinkThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elTheme.linkTheme;

  @override
  Widget build(BuildContext context) {
    final parent = ElLinkTheme.of(context);
    return _ElLinkTheme(
      data: parent.merge(data),
      child: child,
    );
  }
}

class _ElLinkTheme extends InheritedWidget {
  const _ElLinkTheme({
    required super.child,
    required this.data,
  });

  final ElLinkThemeData data;

  @override
  bool updateShouldNotify(_ElLinkTheme oldWidget) => data != oldWidget.data;
}
