// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../components/navigation/tabs/index.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElTabsThemeDataExtension on ElTabsThemeData {
  ElTabsThemeData copyWith({
    double? size,
  }) {
    return ElTabsThemeData(
      size: size ?? this.size,
    );
  }

  ElTabsThemeData merge([ElTabsThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      size: other.size,
    );
  }
}

// **************************************************************************
// ElThemeDataGenerator
// **************************************************************************

class ElTabsTheme extends InheritedWidget {
  const ElTabsTheme({super.key, required super.child, required this.data});

  final ElTabsThemeData data;

  static ElTabsThemeData? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ElTabsTheme>()?.data;
  }

  static ElTabsThemeData of(BuildContext context) {
    final result = maybeOf(context);
    assert(result != null, 'No ElTabsTheme found in context');
    return result!;
  }

  static Widget merge({
    Key? key,
    ElTabsThemeData? data,
    required Widget child,
  }) {
    return Builder(builder: (context) {
      final parent = ElTabsTheme.maybeOf(context) ?? context.elTheme.tabsTheme;
      return ElTabsTheme(
        data: parent.merge(data),
        child: child,
      );
    });
  }

  @override
  bool updateShouldNotify(ElTabsTheme oldWidget) => true;
}
