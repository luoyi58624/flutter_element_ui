part of 'index.dart';

/// 之所以不使用 [DefaultTextStyle] 是因为与 [Material] 设计存在严重冲突，[Material] 小部件作为 Material UI 的基本小部件，
/// 其内部构建的默认文本样式没有 merge 祖先默认文本（这是 Flutter 官方有意这样设计的，为此在 [MaterialApp] 中创建了黄色双下划线的错误默认文本样式），
/// 这导致如果 [ElText] 使用 [DefaultTextStyle]，那么文本样式继承性将被破坏，甚至如果你使用 [MaterialApp] 构建应用，
/// 如果不在 [Material] 小部件中使用 Element UI 组件，那么组件中的文字就会出现黄色双下滑线错误。
///
/// 所以，并非是我不想使用 [DefaultTextStyle]，而是踩了很多坑后只能创建一个独立的默认文本样式来解决冲突问题。
class ElDefaultTextStyle extends DefaultTextStyle {
  /// 构建默认文本样式，注意：直接通过此构造函数构建默认文本样式会中断文本的继承性，请尽量通过 [merge] 方法构建默认文本样式
  const ElDefaultTextStyle({
    super.key,
    required super.style,
    super.textAlign,
    super.softWrap,
    super.overflow,
    super.maxLines,
    super.textWidthBasis,
    super.textHeightBehavior,
    required super.child,
  });

  /// 将祖先提供的默认文本样式与自定义样式进行合并
  static Widget merge({
    Key? key,
    required TextStyle style,
    TextAlign? textAlign,
    bool? softWrap,
    TextOverflow? overflow,
    int? maxLines,
    TextWidthBasis? textWidthBasis,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        final ElDefaultTextStyle parent = ElDefaultTextStyle.of(context);
        return ElDefaultTextStyle(
          key: key,
          style: parent.style.merge(style),
          textAlign: textAlign ?? parent.textAlign,
          softWrap: softWrap ?? parent.softWrap,
          overflow: overflow ?? parent.overflow,
          maxLines: maxLines ?? parent.maxLines,
          textWidthBasis: textWidthBasis ?? parent.textWidthBasis,
          child: child,
        );
      },
    );
  }

  static ElDefaultTextStyle? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ElDefaultTextStyle>();

  static ElDefaultTextStyle of(BuildContext context) {
    final ElDefaultTextStyle? result = maybeOf(context);
    assert(result != null, 'No ElDefaultTextStyle found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ElDefaultTextStyle oldWidget) => true;
}

class ElAnimatedDefaultTextStyle extends StatelessWidget {
  /// 默认文本动画样式
  const ElAnimatedDefaultTextStyle({
    super.key,
    required this.child,
    required this.style,
    this.duration,
    this.curve,
    this.onEnd,
  });

  final Duration? duration;
  final Curve? curve;
  final VoidCallback? onEnd;
  final Widget child;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return _ElAnimatedDefaultTextStyle(
      duration: duration ?? context.elDuration(),
      curve: curve ?? context.elCurve(),
      onEnd: onEnd,
      style: style,
      child: child,
    );
  }
}

class _ElAnimatedDefaultTextStyle extends ImplicitlyAnimatedWidget {
  const _ElAnimatedDefaultTextStyle({
    required this.child,
    required this.style,
    required super.duration,
    super.curve,
    super.onEnd,
  });

  final Widget child;
  final TextStyle style;

  @override
  AnimatedWidgetBaseState<_ElAnimatedDefaultTextStyle> createState() =>
      _ElAnimatedDefaultTextStyleState();
}

class _ElAnimatedDefaultTextStyleState
    extends AnimatedWidgetBaseState<_ElAnimatedDefaultTextStyle> {
  TextStyleTween? _style;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _style = visitor(_style, widget.style,
            (dynamic value) => TextStyleTween(begin: value as TextStyle))
        as TextStyleTween?;
  }

  @override
  Widget build(BuildContext context) {
    return ElDefaultTextStyle.merge(
      style: _style!.evaluate(animation),
      child: widget.child,
    );
  }
}
