part of 'index.dart';

class ElDefaultTextStyle extends StatelessWidget {
  /// [ElText] 默认文本样式小部件，此小部件强制继承祖先文本样式。
  const ElDefaultTextStyle({
    super.key,
    required this.style,
    required this.child,
    this.textAlign,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.textWidthBasis,
    this.textHeightBehavior,
  });

  final Widget child;
  final TextStyle style;
  final TextAlign? textAlign;
  final bool? softWrap;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;

  /// 通过当前上下文 context 访问祖先默认文本样式
  static ElTextInheritedWidget of(BuildContext context) {
    final ElTextInheritedWidget? result =
        context.dependOnInheritedWidgetOfExactType<ElTextInheritedWidget>();
    if (result == null) {
      return ElTextInheritedWidget(
        style: context.elTheme.textTheme.textStyle,
        child: const ElNullWidget(),
      );
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final parent = ElDefaultTextStyle.of(context);
    return ElTextInheritedWidget(
      style: parent.style.merge(style),
      textAlign: textAlign ?? parent.textAlign,
      softWrap: softWrap ?? parent.softWrap,
      overflow: overflow ?? parent.overflow,
      maxLines: maxLines ?? parent.maxLines,
      textWidthBasis: textWidthBasis ?? parent.textWidthBasis,
      child: child,
    );
  }
}

class ElAnimatedDefaultTextStyle extends StatelessWidget {
  /// 默认文本动画样式
  const ElAnimatedDefaultTextStyle({
    super.key,
    required this.child,
    required this.style,
    this.textAlign,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.duration,
    this.curve = Curves.linear,
    this.onEnd,
  });

  final Widget child;
  final TextStyle style;
  final TextAlign? textAlign;
  final bool? softWrap;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final Duration? duration;
  final Curve curve;
  final VoidCallback? onEnd;

  @override
  Widget build(BuildContext context) {
    return _ElAnimatedDefaultTextStyle(
      duration: duration ?? context.elDuration(),
      curve: curve,
      onEnd: onEnd,
      style: style,
      textAlign: textAlign,
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      child: child,
    );
  }
}

class _ElAnimatedDefaultTextStyle extends ImplicitlyAnimatedWidget {
  const _ElAnimatedDefaultTextStyle({
    required this.child,
    required this.style,
    this.textAlign,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.textWidthBasis,
    this.textHeightBehavior,
    required super.duration,
    super.curve,
    super.onEnd,
  });

  final Widget child;
  final TextStyle style;
  final TextAlign? textAlign;
  final bool? softWrap;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;

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
    return ElDefaultTextStyle(
      style: _style!.evaluate(animation),
      textAlign: widget.textAlign,
      softWrap: widget.softWrap,
      overflow: widget.overflow,
      maxLines: widget.maxLines,
      textWidthBasis: widget.textWidthBasis,
      textHeightBehavior: widget.textHeightBehavior,
      child: widget.child,
    );
  }
}

/// Element UI 的所有主题都强制遵循 global_theme -> local_theme -> component_theme 的继承机制，
/// 而 MaterialApp 会往后代注入黄色双下划线的文本样式，以引导用户在 [Material] 小部件中使用文本，
/// 所以我重新创建一个新的组件而不是使用 [DefaultTextStyle]。
class ElTextInheritedWidget extends InheritedWidget {
  const ElTextInheritedWidget({
    super.key,
    required this.style,
    this.textAlign,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.textWidthBasis,
    this.textHeightBehavior,
    required super.child,
  });

  final TextStyle style;
  final TextAlign? textAlign;
  final bool? softWrap;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;

  @override
  bool updateShouldNotify(ElTextInheritedWidget oldWidget) => true;
}
