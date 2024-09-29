// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../components/data/collapse/index.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElCollapseThemeDataExtension on ElCollapseThemeData {
  ElCollapseThemeData copyWith({
    bool? keepState,
    Duration? duration,
    Curve? curve,
  }) {
    return ElCollapseThemeData(
      keepState: keepState ?? this.keepState,
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
    );
  }

  ElCollapseThemeData merge([ElCollapseThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      keepState: other.keepState,
      duration: other.duration,
      curve: other.curve,
    );
  }
}

class ElCollapseTheme extends InheritedWidget {
  /// 局部默认样式小部件，你可以用来定义某个小部件的默认样式
  const ElCollapseTheme({super.key, required super.child, required this.data});

  final ElCollapseThemeData data;

  static ElCollapseThemeData? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ElCollapseTheme>()?.data;
  }

  static ElCollapseThemeData of(
      BuildContext context, ElCollapseThemeData? data) {
    final result = maybeOf(context);
    assert(result != null, 'No ElCollapseTheme found in context');
    return result!;
  }

  static Widget merge({
    Key? key,
    ElCollapseThemeData? data,
    required Widget child,
  }) {
    return Builder(builder: (context) {
      final parent =
          ElCollapseTheme.maybeOf(context) ?? context.elTheme.collapseTheme;
      return ElCollapseTheme(
        data: parent.merge(data),
        child: child,
      );
    });
  }

  @override
  bool updateShouldNotify(ElCollapseTheme oldWidget) => true;
}
