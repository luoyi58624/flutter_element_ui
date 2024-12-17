// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../components/basic/button2/theme.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElButton2ThemeDataExtension on ElButton2ThemeData {
  /// 接收一组可选参数，返回新的对象
  ElButton2ThemeData copyWith({
    Duration? duration,
    Curve? curve,
    String? type,
    Color? bgColor,
    double? width,
    double? height,
    Widget? leftIcon,
    Widget? rightIcon,
    bool? round,
    EdgeInsets? padding,
    double? iconSize,
    bool? block,
    Widget? loadingWidget,
    Widget Function(BuildContext)? loadingBuilder,
  }) {
    return ElButton2ThemeData(
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
      type: type ?? this.type,
      bgColor: bgColor ?? this.bgColor,
      width: width ?? this.width,
      height: height ?? this.height,
      leftIcon: leftIcon ?? this.leftIcon,
      rightIcon: rightIcon ?? this.rightIcon,
      round: round ?? this.round,
      padding: padding ?? this.padding,
      iconSize: iconSize ?? this.iconSize,
      block: block ?? this.block,
      loadingWidget: loadingWidget ?? this.loadingWidget,
      loadingBuilder: loadingBuilder ?? this.loadingBuilder,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElButton2ThemeData merge([ElButton2ThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      duration: other.duration,
      curve: other.curve,
      type: other.type,
      bgColor: other.bgColor,
      width: other.width,
      height: other.height,
      leftIcon: other.leftIcon,
      rightIcon: other.rightIcon,
      round: other.round,
      padding: other.padding,
      iconSize: other.iconSize,
      block: other.block,
      loadingWidget: other.loadingWidget,
      loadingBuilder: other.loadingBuilder,
    );
  }

  /// 生成 equals 对象比较方法
  bool _equals(Object other) =>
      identical(this, other) ||
      other is ElButton2ThemeData &&
          runtimeType == other.runtimeType &&
          duration == other.duration &&
          curve == other.curve &&
          type == other.type &&
          bgColor == other.bgColor &&
          width == other.width &&
          height == other.height &&
          leftIcon == other.leftIcon &&
          rightIcon == other.rightIcon &&
          round == other.round &&
          padding == other.padding &&
          iconSize == other.iconSize &&
          block == other.block &&
          loadingWidget == other.loadingWidget &&
          loadingBuilder == other.loadingBuilder;

  /// 生成 hashCode 方法
  int get _hashCode =>
      duration.hashCode ^
      curve.hashCode ^
      type.hashCode ^
      bgColor.hashCode ^
      width.hashCode ^
      height.hashCode ^
      leftIcon.hashCode ^
      rightIcon.hashCode ^
      round.hashCode ^
      padding.hashCode ^
      iconSize.hashCode ^
      block.hashCode ^
      loadingWidget.hashCode ^
      loadingBuilder.hashCode;
}

extension ElOutlineButtonThemeDataExtension on ElOutlineButtonThemeData {
  /// 接收一组可选参数，返回新的对象
  ElOutlineButtonThemeData copyWith({
    bool? plain,
    bool? onlyActiveBorder,
    double? borderWidth,
    Duration? duration,
    Curve? curve,
    String? type,
    Color? bgColor,
    double? width,
    double? height,
    double? iconSize,
    bool? block,
    bool? round,
    EdgeInsets? padding,
    Widget? leftIcon,
    Widget? rightIcon,
    Widget? loadingWidget,
    Widget Function(BuildContext)? loadingBuilder,
  }) {
    return ElOutlineButtonThemeData(
      plain: plain ?? this.plain,
      onlyActiveBorder: onlyActiveBorder ?? this.onlyActiveBorder,
      borderWidth: borderWidth ?? this.borderWidth,
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
      type: type ?? this.type,
      bgColor: bgColor ?? this.bgColor,
      width: width ?? this.width,
      height: height ?? this.height,
      iconSize: iconSize ?? this.iconSize,
      block: block ?? this.block,
      round: round ?? this.round,
      padding: padding ?? this.padding,
      leftIcon: leftIcon ?? this.leftIcon,
      rightIcon: rightIcon ?? this.rightIcon,
      loadingWidget: loadingWidget ?? this.loadingWidget,
      loadingBuilder: loadingBuilder ?? this.loadingBuilder,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElOutlineButtonThemeData merge([ElOutlineButtonThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      plain: other.plain,
      onlyActiveBorder: other.onlyActiveBorder,
      borderWidth: other.borderWidth,
      duration: other.duration,
      curve: other.curve,
      type: other.type,
      bgColor: other.bgColor,
      width: other.width,
      height: other.height,
      iconSize: other.iconSize,
      block: other.block,
      round: other.round,
      padding: other.padding,
      leftIcon: other.leftIcon,
      rightIcon: other.rightIcon,
      loadingWidget: other.loadingWidget,
      loadingBuilder: other.loadingBuilder,
    );
  }

  /// 生成 equals 对象比较方法
  bool _equals(Object other) =>
      identical(this, other) ||
      other is ElOutlineButtonThemeData &&
          runtimeType == other.runtimeType &&
          plain == other.plain &&
          onlyActiveBorder == other.onlyActiveBorder &&
          borderWidth == other.borderWidth &&
          duration == other.duration &&
          curve == other.curve &&
          type == other.type &&
          bgColor == other.bgColor &&
          width == other.width &&
          height == other.height &&
          iconSize == other.iconSize &&
          block == other.block &&
          round == other.round &&
          padding == other.padding &&
          leftIcon == other.leftIcon &&
          rightIcon == other.rightIcon &&
          loadingWidget == other.loadingWidget &&
          loadingBuilder == other.loadingBuilder;

  /// 生成 hashCode 方法
  int get _hashCode =>
      plain.hashCode ^
      onlyActiveBorder.hashCode ^
      borderWidth.hashCode ^
      duration.hashCode ^
      curve.hashCode ^
      type.hashCode ^
      bgColor.hashCode ^
      width.hashCode ^
      height.hashCode ^
      iconSize.hashCode ^
      block.hashCode ^
      round.hashCode ^
      padding.hashCode ^
      leftIcon.hashCode ^
      rightIcon.hashCode ^
      loadingWidget.hashCode ^
      loadingBuilder.hashCode;
}

extension ElTextButtonThemeDataExtension on ElTextButtonThemeData {
  /// 接收一组可选参数，返回新的对象
  ElTextButtonThemeData copyWith({
    Color? color,
    bool? bg,
    double? iconScale,
    Duration? duration,
    Curve? curve,
    String? type,
    bool? round,
    EdgeInsets? padding,
    Widget? leftIcon,
    Widget? rightIcon,
    Widget? loadingWidget,
    Widget Function(BuildContext)? loadingBuilder,
  }) {
    return ElTextButtonThemeData(
      color: color ?? this.color,
      bg: bg ?? this.bg,
      iconScale: iconScale ?? this.iconScale,
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
      type: type ?? this.type,
      round: round ?? this.round,
      padding: padding ?? this.padding,
      leftIcon: leftIcon ?? this.leftIcon,
      rightIcon: rightIcon ?? this.rightIcon,
      loadingWidget: loadingWidget ?? this.loadingWidget,
      loadingBuilder: loadingBuilder ?? this.loadingBuilder,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElTextButtonThemeData merge([ElTextButtonThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      color: other.color,
      bg: other.bg,
      iconScale: other.iconScale,
      duration: other.duration,
      curve: other.curve,
      type: other.type,
      round: other.round,
      padding: other.padding,
      leftIcon: other.leftIcon,
      rightIcon: other.rightIcon,
      loadingWidget: other.loadingWidget,
      loadingBuilder: other.loadingBuilder,
    );
  }

  /// 生成 equals 对象比较方法
  bool _equals(Object other) =>
      identical(this, other) ||
      other is ElTextButtonThemeData &&
          runtimeType == other.runtimeType &&
          color == other.color &&
          bg == other.bg &&
          iconScale == other.iconScale &&
          duration == other.duration &&
          curve == other.curve &&
          type == other.type &&
          round == other.round &&
          padding == other.padding &&
          leftIcon == other.leftIcon &&
          rightIcon == other.rightIcon &&
          loadingWidget == other.loadingWidget &&
          loadingBuilder == other.loadingBuilder;

  /// 生成 hashCode 方法
  int get _hashCode =>
      color.hashCode ^
      bg.hashCode ^
      iconScale.hashCode ^
      duration.hashCode ^
      curve.hashCode ^
      type.hashCode ^
      round.hashCode ^
      padding.hashCode ^
      leftIcon.hashCode ^
      rightIcon.hashCode ^
      loadingWidget.hashCode ^
      loadingBuilder.hashCode;
}

extension ElLinkButtonThemeDataExtension on ElLinkButtonThemeData {
  /// 接收一组可选参数，返回新的对象
  ElLinkButtonThemeData copyWith({
    Duration? duration,
    Curve? curve,
    String? type,
    Color? color,
    Widget Function(BuildContext)? loadingBuilder,
  }) {
    return ElLinkButtonThemeData(
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
      type: type ?? this.type,
      color: color ?? this.color,
      loadingBuilder: loadingBuilder ?? this.loadingBuilder,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElLinkButtonThemeData merge([ElLinkButtonThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      duration: other.duration,
      curve: other.curve,
      type: other.type,
      color: other.color,
      loadingBuilder: other.loadingBuilder,
    );
  }

  /// 生成 equals 对象比较方法
  bool _equals(Object other) =>
      identical(this, other) ||
      other is ElLinkButtonThemeData &&
          runtimeType == other.runtimeType &&
          duration == other.duration &&
          curve == other.curve &&
          type == other.type &&
          color == other.color &&
          loadingBuilder == other.loadingBuilder;

  /// 生成 hashCode 方法
  int get _hashCode =>
      duration.hashCode ^
      curve.hashCode ^
      type.hashCode ^
      color.hashCode ^
      loadingBuilder.hashCode;
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

class ElOutlineButtonTheme extends StatelessWidget {
  /// 提供局部默认主题小部件，局部默认主题必须强制继承祖先提供的样式
  const ElOutlineButtonTheme({
    super.key,
    required this.child,
    required this.data,
  });

  final Widget child;
  final ElOutlineButtonThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElOutlineButtonThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ElOutlineButtonTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElOutlineButtonThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elTheme.outlineButtonTheme;

  @override
  Widget build(BuildContext context) {
    final parent = ElOutlineButtonTheme.of(context);
    return _ElOutlineButtonTheme(
      data: parent.merge(data),
      child: child,
    );
  }
}

class _ElOutlineButtonTheme extends InheritedWidget {
  const _ElOutlineButtonTheme({
    required super.child,
    required this.data,
  });

  final ElOutlineButtonThemeData data;

  @override
  bool updateShouldNotify(_ElOutlineButtonTheme oldWidget) =>
      data != oldWidget.data;
}

class ElTextButtonTheme extends StatelessWidget {
  /// 提供局部默认主题小部件，局部默认主题必须强制继承祖先提供的样式
  const ElTextButtonTheme({
    super.key,
    required this.child,
    required this.data,
  });

  final Widget child;
  final ElTextButtonThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElTextButtonThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ElTextButtonTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElTextButtonThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elTheme.textButtonTheme;

  @override
  Widget build(BuildContext context) {
    final parent = ElTextButtonTheme.of(context);
    return _ElTextButtonTheme(
      data: parent.merge(data),
      child: child,
    );
  }
}

class _ElTextButtonTheme extends InheritedWidget {
  const _ElTextButtonTheme({
    required super.child,
    required this.data,
  });

  final ElTextButtonThemeData data;

  @override
  bool updateShouldNotify(_ElTextButtonTheme oldWidget) =>
      data != oldWidget.data;
}

class ElLinkButtonTheme extends StatelessWidget {
  /// 提供局部默认主题小部件，局部默认主题必须强制继承祖先提供的样式
  const ElLinkButtonTheme({
    super.key,
    required this.child,
    required this.data,
  });

  final Widget child;
  final ElLinkButtonThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElLinkButtonThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ElLinkButtonTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElLinkButtonThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elTheme.linkButtonTheme;

  @override
  Widget build(BuildContext context) {
    final parent = ElLinkButtonTheme.of(context);
    return _ElLinkButtonTheme(
      data: parent.merge(data),
      child: child,
    );
  }
}

class _ElLinkButtonTheme extends InheritedWidget {
  const _ElLinkButtonTheme({
    required super.child,
    required this.data,
  });

  final ElLinkButtonThemeData data;

  @override
  bool updateShouldNotify(_ElLinkButtonTheme oldWidget) =>
      data != oldWidget.data;
}
