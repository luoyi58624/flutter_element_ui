// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../components/layout/layout/index.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

/// 生成的全局默认实体类对象，此对象只用于代码生成器，不推荐用户引用它
final ElLayoutData _elLayoutData = ElLayoutData(
  navbar: 0.0,
  sidebar: 0.0,
  rightSidebar: 0.0,
  footer: 0.0,
);

/// 生成 fromJson 方法，将 Map 对象转成实体类
ElLayoutData _fromJson(Map<String, dynamic>? json) {
  if (json == null) return _elLayoutData;
  return ElLayoutData(
    navbar: $$ElJsonUtil.$double(json, 'navbar') ?? 0.0,
    sidebar: $$ElJsonUtil.$double(json, 'sidebar') ?? 0.0,
    rightSidebar: $$ElJsonUtil.$double(json, 'rightSidebar') ?? 0.0,
    footer: $$ElJsonUtil.$double(json, 'footer') ?? 0.0,
  );
}

extension ElLayoutDataExtension on ElLayoutData {
  /// 生成 toJson 方法，将实体类转成 Map 对象
  Map<String, dynamic> _toJson() {
    return {
      'navbar': navbar,
      'sidebar': sidebar,
      'rightSidebar': rightSidebar,
      'footer': footer,
    };
  }

  /// 接收一组可选参数，返回新的对象
  ElLayoutData copyWith({
    double? navbar,
    double? sidebar,
    double? rightSidebar,
    double? footer,
  }) {
    return ElLayoutData(
      navbar: navbar ?? this.navbar,
      sidebar: sidebar ?? this.sidebar,
      rightSidebar: rightSidebar ?? this.rightSidebar,
      footer: footer ?? this.footer,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElLayoutData merge([ElLayoutData? other]) {
    if (other == null) return this;
    return copyWith(
      navbar: other.navbar,
      sidebar: other.sidebar,
      rightSidebar: other.rightSidebar,
      footer: other.footer,
    );
  }

  /// 生成 equals 对象比较方法
  bool _equals(Object other) =>
      identical(this, other) ||
      other is ElLayoutData &&
          runtimeType == other.runtimeType &&
          navbar == other.navbar &&
          sidebar == other.sidebar &&
          rightSidebar == other.rightSidebar &&
          footer == other.footer;

  /// 生成 hashCode 方法
  int get _hashCode =>
      navbar.hashCode ^
      sidebar.hashCode ^
      rightSidebar.hashCode ^
      footer.hashCode;

  /// 生成 toString 方法
  String _toString() {
    return 'ElLayoutData{\n  navbar: $navbar,\n  sidebar: $sidebar,\n  rightSidebar: $rightSidebar,\n  footer: $footer\n}';
  }
}

extension ElLayoutThemeDataExtension on ElLayoutThemeData {
  /// 接收一组可选参数，返回新的对象
  ElLayoutThemeData copyWith({
    Color? bgColor,
    Color? borderColor,
    Color? navbarColor,
    Color? sidebarColor,
    Color? footerColor,
  }) {
    return ElLayoutThemeData(
      bgColor: bgColor ?? this.bgColor,
      borderColor: borderColor ?? this.borderColor,
      navbarColor: navbarColor ?? this.navbarColor,
      sidebarColor: sidebarColor ?? this.sidebarColor,
      footerColor: footerColor ?? this.footerColor,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElLayoutThemeData merge([ElLayoutThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      bgColor: other.bgColor,
      borderColor: other.borderColor,
      navbarColor: other.navbarColor,
      sidebarColor: other.sidebarColor,
      footerColor: other.footerColor,
    );
  }

  /// 生成 equals 对象比较方法
  bool _equals(Object other) =>
      identical(this, other) ||
      other is ElLayoutThemeData &&
          runtimeType == other.runtimeType &&
          bgColor == other.bgColor &&
          borderColor == other.borderColor &&
          navbarColor == other.navbarColor &&
          sidebarColor == other.sidebarColor &&
          footerColor == other.footerColor;

  /// 生成 hashCode 方法
  int get _hashCode =>
      bgColor.hashCode ^
      borderColor.hashCode ^
      navbarColor.hashCode ^
      sidebarColor.hashCode ^
      footerColor.hashCode;
}

// **************************************************************************
// ElThemeModelGenerator
// **************************************************************************

class ElLayoutTheme extends StatelessWidget {
  /// 提供局部默认主题小部件，局部默认主题必须强制继承祖先提供的样式
  const ElLayoutTheme({
    super.key,
    required this.child,
    required this.data,
  });

  final Widget child;
  final ElLayoutThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElLayoutThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ElLayoutTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElLayoutThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elTheme.layoutTheme;

  @override
  Widget build(BuildContext context) {
    final parent = ElLayoutTheme.of(context);
    return _ElLayoutTheme(
      data: parent.merge(data),
      child: child,
    );
  }
}

class _ElLayoutTheme extends InheritedWidget {
  const _ElLayoutTheme({
    required super.child,
    required this.data,
  });

  final ElLayoutThemeData data;

  @override
  bool updateShouldNotify(_ElLayoutTheme oldWidget) => data != oldWidget.data;
}
