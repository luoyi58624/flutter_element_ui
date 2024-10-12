// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../components/basic/link/index.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElLinkThemeDataExtension on ElLinkThemeData {
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

  ElLinkThemeData merge([ElLinkThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      color: other.color,
      activeColor: other.activeColor,
      decoration: other.decoration,
      allowDrag: other.allowDrag,
    );
  }
}

// **************************************************************************
// ElThemeDataGenerator
// **************************************************************************

class ElLinkTheme extends InheritedWidget {
  const ElLinkTheme({super.key, required super.child, required this.data});

  final ElLinkThemeData data;

  static ElLinkThemeData? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ElLinkTheme>()?.data;
  }

  static ElLinkThemeData of(BuildContext context) {
    final result = maybeOf(context);
    assert(result != null, 'No ElLinkTheme found in context');
    return result!;
  }

  static Widget merge({
    Key? key,
    ElLinkThemeData? data,
    required Widget child,
  }) {
    return Builder(builder: (context) {
      final parent = ElLinkTheme.maybeOf(context) ?? context.elTheme.linkTheme;
      return ElLinkTheme(
        data: parent.merge(data),
        child: child,
      );
    });
  }

  @override
  bool updateShouldNotify(ElLinkTheme oldWidget) => true;
}
