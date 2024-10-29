part of 'index.dart';

class ElTextState extends State<ElText> with SingleTickerProviderStateMixin {
  late ElTextThemeData _data;
  TextStyle? _tempStyle;
  bool isDidUpdate = false;

  late AnimationController controller = AnimationController(
    vsync: this,
    duration: widget.duration ?? context.elConfig.themeDuration,
  )
    ..addListener(() {
      _tempStyle = styleAnimate.value;
    })
    ..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _tempStyle = null;
      }
    });

  late Animation<TextStyle> styleAnimate = TextStyleTween(
    begin: widget.style ?? const TextStyle(),
  ).animate(CurvedAnimation(
    parent: controller,
    curve: Curves.linear,
  ));

  @override
  void didUpdateWidget(covariant ElText oldWidget) {
    super.didUpdateWidget(oldWidget);
    controller.duration =
        context.elDuration(widget.duration ?? context.elConfig.themeDuration);
    if (widget.style != oldWidget.style) {
      isDidUpdate = true;
      // i(ElTextTheme.maybeOf(context));
      _data = ElDefaultTextStyle.of(context);
      final textStyle = _data.style;
      final oldStyle = textStyle.merge(_tempStyle ?? oldWidget.style);
      final newStyle = textStyle.merge(widget.style);
      styleAnimate = TextStyleTween(
        begin: oldStyle,
        end: newStyle,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.linear));
      controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    late TextStyle style;
    if (isDidUpdate) {
      isDidUpdate = false;
    } else {
      _data = ElDefaultTextStyle.of(context);
    }
    return AnimatedBuilder(
      animation: controller.view,
      builder: (context, child) {
        if (_tempStyle == null) {
          style = _data.textStyle.merge(widget.style);
        } else {
          style = _data.textStyle.merge(styleAnimate.value);
        }
        return buildText(context, style);
      },
    );
  }

  Widget buildText(BuildContext context, TextStyle $style) {
    // 同步 Text 小部件的加粗文本逻辑
    if (MediaQuery.boldTextOf(context)) {
      $style.copyWith(fontWeight: FontWeight.bold);
    }
    final SelectionRegistrar? registrar = SelectionContainer.maybeOf(context);
    Widget result = RichText(
      text: TextSpan(
        style: $style,
        children: widget._buildRichText(
          context,
          widget.data is List ? widget.data : [widget.data],
        ),
      ),
      textAlign: widget.textAlign ?? _data.textAlign ?? TextAlign.start,
      softWrap: widget.softWrap ?? _data.softWrap ?? true,
      overflow: widget.overflow ?? _data.overflow ?? TextOverflow.clip,
      textDirection: widget.textDirection ?? _data.textDirection,
      textScaler: widget.textScaler ?? _data.textScaler ?? TextScaler.noScaling,
      maxLines: widget.maxLines ?? _data.maxLines,
      locale: widget.locale,
      strutStyle: widget.strutStyle,
      textWidthBasis: widget.textWidthBasis ??
          _data.textWidthBasis ??
          TextWidthBasis.parent,
      textHeightBehavior: widget.textHeightBehavior,
      selectionRegistrar: registrar,
      selectionColor: widget.selectionColor ??
          DefaultSelectionStyle.of(context).selectionColor ??
          DefaultSelectionStyle.defaultColor,
    );

    if (registrar == null) return result;
    return ElHoverBuilder(
        triggerBuild: false,
        cursor: DefaultSelectionStyle.of(context).mouseCursor ??
            ElHoverBuilder.mouseCursor(context) ??
            SystemMouseCursors.text,
        builder: (context) {
          return result;
        });
  }
}
