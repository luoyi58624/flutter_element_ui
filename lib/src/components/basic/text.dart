import 'package:flutter/widgets.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

class ElText extends StatelessWidget {
  const ElText(
    this.data, {
    super.key,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaler,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
  });

  /// * 如果是[List]，则当做富文本渲染，针对
  /// * 否则自动渲染为[Text]
  final dynamic data;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final TextScaler? textScaler;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final Color? selectionColor;

  List<InlineSpan> _buildRichText(BuildContext context, List children) {
    List<InlineSpan> richChildren = [];
    for (final child in children) {
      if (DartUtil.isBaseType(child)) {
        richChildren.add(TextSpan(text: '$child'));
      } else if (child is TextSpan || child is WidgetSpan) {
        richChildren.add(child);
      } else {
        richChildren.add(WidgetSpan(
          // alignment: PlaceholderAlignment.bottom,
          child: child,
        ));
      }
    }
    return richChildren;
  }

  Widget _buildText() {
    return Text(
      '$data',
      strutStyle: strutStyle,
      textDirection: textDirection,
      locale: locale,
      textScaler: textScaler,
      semanticsLabel: semanticsLabel,
      textHeightBehavior: textHeightBehavior,
      selectionColor: selectionColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: style,
      textAlign: textAlign,
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
      textWidthBasis: textWidthBasis,
      child: data is List
          ? Builder(builder: (context) {
              return RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: _buildRichText(context, data),
                ),
              );
            })
          : _buildText(),
    );
  }
}
