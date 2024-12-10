// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../components/basic/button2/index.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElButton2ThemeDataExtension on ElButton2ThemeData {
  /// 接收一组可选参数，返回新的对象
  ElButton2ThemeData copyWith({
    String? type,
    Color? bgColor,
    double? width,
    double? height,
    bool? round,
    bool? block,
  }) {
    return ElButton2ThemeData(
      type: type ?? this.type,
      bgColor: bgColor ?? this.bgColor,
      width: width ?? this.width,
      height: height ?? this.height,
      round: round ?? this.round,
      block: block ?? this.block,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElButton2ThemeData merge([ElButton2ThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      type: other.type,
      bgColor: other.bgColor,
      width: other.width,
      height: other.height,
      round: other.round,
      block: other.block,
    );
  }

  /// 生成 equals 对象比较方法
  bool _equals(Object other) =>
      identical(this, other) ||
      other is ElButton2ThemeData &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          bgColor == other.bgColor &&
          width == other.width &&
          height == other.height &&
          round == other.round &&
          block == other.block;

  /// 生成 hashCode 方法
  int get _hashCode =>
      type.hashCode ^
      bgColor.hashCode ^
      width.hashCode ^
      height.hashCode ^
      round.hashCode ^
      block.hashCode;
}

// **************************************************************************
// ElThemeModelGenerator
// **************************************************************************

class ElButton2Theme extends StatelessWidget {
  /// 提供局部默认主题小部件，局部默认主题必须强制继承祖先提供的样式
  const ElButton2Theme({
    super.key,
    required this.child,
    required this.data,
  });

  final Widget child;
  final ElButton2ThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElButton2ThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ElButton2Theme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElButton2ThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elTheme.button2Theme;

  @override
  Widget build(BuildContext context) {
    final parent = ElButton2Theme.of(context);
    return _ElButton2Theme(
      data: parent.merge(data),
      child: child,
    );
  }
}

class _ElButton2Theme extends InheritedWidget {
  const _ElButton2Theme({
    required super.child,
    required this.data,
  });

  final ElButton2ThemeData data;

  @override
  bool updateShouldNotify(_ElButton2Theme oldWidget) => data != oldWidget.data;
}
