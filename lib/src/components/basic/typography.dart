import 'package:flutter/widgets.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import '../../styles/theme.dart';
import '../../theme.dart';

/// Element UI 文字排版继承小部件
class ElTypographyInheritedWidget extends InheritedWidget {
  const ElTypographyInheritedWidget({
    super.key,
    required super.child,
    required this.data,
  });

  final ElTypographyData data;

  static ElTypographyData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ElTypographyInheritedWidget>()?.data ?? ElTheme.of(context).typography;
  }

  @override
  bool updateShouldNotify(ElTypographyInheritedWidget oldWidget) => false;
}

/// 文本抽象类，其参数完全复刻 [Text] 小部件
abstract class ElTypography extends StatelessWidget {
  const ElTypography(
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
  ///
  /// 提示：构建富文本你可能会遇到对齐问题，默认情况下所有内容为底部对齐，如果你想垂直居中，
  /// 请传递[WidgetSpan]并设置 alignment 属性。
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

  /// 文本超出样式
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

  /// 构建文本
  Widget buildTypography(BuildContext context, [TextStyle? $style]) {
    return DefaultTextStyle.merge(
      style: $style,
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

  /// 构建富文本片段集合
  List<InlineSpan> _buildRichText(List children) {
    List<InlineSpan> richChildren = [];
    for (final child in children) {
      richChildren.add(_buildInlineSpan(child));
    }
    return richChildren;
  }

  /// 使用递归构建单个富文本片段
  InlineSpan _buildInlineSpan(dynamic data, [List<InlineSpan>? children]) {
    if (DartUtil.isBaseType(data)) return TextSpan(text: '$data');
    if (data is TextSpan || data is WidgetSpan) return data;
    if (data is ElTypography) {
      if (data.data is List) {
        final richTexts = data.data as List;
        List<InlineSpan> $children = [];
        if (richTexts.length > 1) {
          $children.addAll(
            _buildRichText(richTexts.sublist(1, richTexts.length)),
          );
        }
        return _buildInlineSpan(
          ElText(richTexts[0], style: data.style),
          $children,
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
}

/// Element UI 文本小部件，它是 [ElTypography] 抽象类的直接实现
class ElText extends ElTypography {
  const ElText(
    super.data, {
    super.key,
    super.style,
    super.strutStyle,
    super.textAlign,
    super.textDirection,
    super.locale,
    super.softWrap,
    super.overflow,
    super.textScaler,
    super.maxLines,
    super.semanticsLabel,
    super.textWidthBasis,
    super.textHeightBehavior,
    super.selectionColor,
  });

  @override
  Widget build(BuildContext context) {
    final $style = ElTypographyInheritedWidget.of(context).p.merge(style);
    return buildTypography(context, $style);
  }
}

// ======================================================================
// h1-h6 只提供 style 属性，如果需要更多参数请直接使用 [ElText]
// ======================================================================

class H1 extends ElTypography {
  const H1(super.data, {super.key, super.style}) : super(semanticsLabel: 'H1');

  @override
  Widget build(BuildContext context) {
    final $style = ElTypographyInheritedWidget.of(context).h1.merge(style);
    return buildTypography(context, $style);
  }
}

class H2 extends ElTypography {
  const H2(super.data, {super.key, super.style}) : super(semanticsLabel: 'H2');

  @override
  Widget build(BuildContext context) {
    final $style = ElTypographyInheritedWidget.of(context).h2.merge(style);
    return buildTypography(context, $style);
  }
}

class H3 extends ElTypography {
  const H3(super.data, {super.key, super.style}) : super(semanticsLabel: 'H3');

  @override
  Widget build(BuildContext context) {
    final $style = ElTypographyInheritedWidget.of(context).h3.merge(style);
    return buildTypography(context, $style);
  }
}

class H4 extends ElTypography {
  const H4(super.data, {super.key, super.style}) : super(semanticsLabel: 'H4');

  @override
  Widget build(BuildContext context) {
    final $style = ElTypographyInheritedWidget.of(context).h4.merge(style);
    return buildTypography(context, $style);
  }
}

class H5 extends ElTypography {
  const H5(super.data, {super.key, super.style}) : super(semanticsLabel: 'H5');

  @override
  Widget build(BuildContext context) {
    final $style = ElTypographyInheritedWidget.of(context).h5.merge(style);
    return buildTypography(context, $style);
  }
}

class H6 extends ElTypography {
  const H6(super.data, {super.key, super.style}) : super(semanticsLabel: 'H6');

  @override
  Widget build(BuildContext context) {
    final $style = ElTypographyInheritedWidget.of(context).h6.merge(style);
    return buildTypography(context, $style);
  }
}
