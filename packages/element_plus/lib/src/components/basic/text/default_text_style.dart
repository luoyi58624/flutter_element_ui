part of 'index.dart';

/// 之所以不使用 [DefaultTextStyle] 是因为与 [Material] 设计存在严重冲突，[Material] 小部件作为 Material UI 的基本小部件，
/// 其内部构建的默认文本样式没有 merge 祖先默认文本（这是 Flutter 官方有意这样设计的，因为他们在 [MaterialApp] 中创建了黄色双下划线的错误默认文本样式），
/// 这导致如果 [ElText] 使用 [DefaultTextStyle]，那么 Element UI 本身的文本主题将很容易被破坏。
class ElDefaultTextStyle extends DefaultTextStyle {
  /// 构建默认文本样式，注意：请尽量通过 [merge] 方法构建默认文本样式
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

  final Widget child;
  final TextStyle style;
  final Duration? duration;
  final Curve? curve;
  final VoidCallback? onEnd;

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
