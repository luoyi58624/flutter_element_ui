// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../styles/data/collapse.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElCollapseStyleExtension on ElCollapseStyle {
  ElCollapseStyle copyWith({
    bool? keepState,
    Duration? duration,
    Curve? curve,
  }) {
    return ElCollapseStyle(
      keepState: keepState ?? this.keepState,
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
    );
  }

  ElCollapseStyle merge([ElCollapseStyle? other]) {
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

  final ElCollapseStyle data;

  static ElCollapseStyle? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ElCollapseTheme>()?.data;
  }

  static ElCollapseStyle of(BuildContext context, ElCollapseStyle? data) {
    final result = maybeOf(context);
    assert(result != null, 'No ElCollapseTheme found in context');
    return result!;
  }

  static Widget merge({
    Key? key,
    ElCollapseStyle? data,
    required Widget child,
  }) {
    return Builder(builder: (context) {
      final parent =
          ElCollapseTheme.maybeOf(context) ?? const ElCollapseStyle();
      return ElCollapseTheme(
        data: parent.merge(data),
        child: child,
      );
    });
  }

  @override
  bool updateShouldNotify(ElCollapseTheme oldWidget) => true;
}
