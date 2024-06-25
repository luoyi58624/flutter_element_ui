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

  /// * 如果是[List]，则当做富文本渲染，你可以插入任意类型的内容。
  /// * 否则统一渲染为[Text]，无论是字符串还是其他类型，都会自动转成String类型。
  final dynamic data;

  /// 文本样式
  final TextStyle? style;

  /// 文本基线对齐样式
  final StrutStyle? strutStyle;

  /// 文本水平对齐方式，默认左对齐
  final TextAlign? textAlign;

  /// 控制文本方向：ltr、rtl
  final TextDirection? textDirection;

  /// 指定语言
  final Locale? locale;

  /// 是否自动换行
  final bool? softWrap;

  /// 如果[softWrap]为false，控制文本超出样式
  final TextOverflow? overflow;

  /// 文本缩放倍数，如果要放大2倍，设置 TextScaler.linear(2) 即可
  final TextScaler? textScaler;

  /// 文本最大行数，即使你设置[softWrap]为false，该属性也能生效
  final int? maxLines;

  /// 语义化标签
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;

  /// 文本选中颜色
  final Color? selectionColor;

  List<InlineSpan> _buildRichText(List children) {
    List<InlineSpan> richChildren = [];
    for (final child in children) {
      richChildren.add(_buildInlineSpan(child));
    }
    return richChildren;
  }

  InlineSpan _buildInlineSpan(
    dynamic data, {
    List<InlineSpan>? children,
  }) {
    if (DartUtil.isBaseType(data)) return TextSpan(text: '$data');
    if (data is TextSpan || data is WidgetSpan) return data;
    if (data is ElText) {
      if (data.data is List) {
        final richTexts = data.data as List;
        List<InlineSpan> children = [];
        if (richTexts.length > 1) {
          children.addAll(
            _buildRichText(richTexts.sublist(1, richTexts.length)),
          );
        }
        return _buildInlineSpan(
          ElText(richTexts[0], style: data.style),
          children: children,
        );
      } else {
        if (DartUtil.isBaseType(data.data)) {
          return TextSpan(
            text: data.data,
            style: data.style,
            children: children != null && children.isNotEmpty ? children : null,
          );
        } else {
          return WidgetSpan(child: data);
        }
      }
    }
    return WidgetSpan(child: data);
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
                strutStyle: strutStyle,
                textDirection: textDirection,
                locale: locale,
                textScaler: textScaler ?? TextScaler.noScaling,
                textHeightBehavior: textHeightBehavior,
                selectionColor: selectionColor,
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: _buildRichText(data),
                ),
              );
            })
          : Text(
              '$data',
              strutStyle: strutStyle,
              textDirection: textDirection,
              locale: locale,
              textScaler: textScaler,
              semanticsLabel: semanticsLabel,
              textHeightBehavior: textHeightBehavior,
              selectionColor: selectionColor,
            ),
    );
  }
}
