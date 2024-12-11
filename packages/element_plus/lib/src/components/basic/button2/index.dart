import 'package:element_plus/src/global.dart';
import 'package:flutter/material.dart';

import '../../feedback/loading/loading.dart';
import '../button/index.dart';

part 'raw_button.dart';

part 'button.dart';

part 'outline_button.dart';

part 'text_button.dart';

part 'link_button.dart';

class _AnimatedWidget extends ImplicitlyAnimatedWidget {
  const _AnimatedWidget({
    required super.duration,
    super.curve,
    required this.decoration,
    required this.textStyle,
    required this.iconThemeData,
    required this.child,
  });

  final BoxDecoration decoration;
  final TextStyle textStyle;
  final ElIconThemeData iconThemeData;
  final Widget child;

  @override
  AnimatedWidgetBaseState<_AnimatedWidget> createState() =>
      _AnimatedWidgetState();
}

class _AnimatedWidgetState extends AnimatedWidgetBaseState<_AnimatedWidget> {
  DecorationTween? _decoration;
  TextStyleTween? _textStyle;
  ElIconThemeDataTween? _iconThemeData;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: _decoration!.evaluate(animation),
      child: ElDefaultTextStyle(
        style: _textStyle!.evaluate(animation),
        child: ElIconTheme(
          data: _iconThemeData!.evaluate(animation),
          child: widget.child,
        ),
      ),
    );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _decoration = visitor(_decoration, widget.decoration,
            (dynamic value) => DecorationTween(begin: value as BoxDecoration))
        as DecorationTween;
    _textStyle = visitor(_textStyle, widget.textStyle,
            (dynamic value) => TextStyleTween(begin: value as TextStyle))
        as TextStyleTween;
    _iconThemeData = visitor(
            _iconThemeData,
            widget.iconThemeData,
            (dynamic value) =>
                ElIconThemeDataTween(begin: value as ElIconThemeData))
        as ElIconThemeDataTween;
  }
}
