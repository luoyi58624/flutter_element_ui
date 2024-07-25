import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:luoyi_dart_base/luoyi_dart_base.dart';

import '../../core.dart';
import '../../utils/font.dart';

/// Element UI 文本小部件，和 [Text] 小部件一样，都是基于 [RichText] 进行的封装
class ElText extends StatelessWidget {
  const ElText(
    this.data, {
    super.key,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap = true,
    this.overflow,
    this.textScaler,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
    this.mouseCursor,
    this.onTap,
  });

  /// 渲染的文本内容，支持传递任意小部件，如果是[List]集合，则会渲染成富文本
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
  final bool softWrap;

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

  /// 鼠标悬停样式
  final MouseCursor? mouseCursor;

  /// 点击事件
  final GestureTapCallback? onTap;

  /// 悬停时默认禁止重建小部件
  bool get disabledHoverBuilder => true;

  /// 构建当前文本样式
  TextStyle buildTextStyle(BuildContext context) {
    return DefaultTextStyle.of(context).style.merge(style);
  }

  /// 构建事件指示器
  GestureRecognizer? buildRecognizer() {
    if (onTap == null) return null;
    return TapGestureRecognizer()
      ..onTap = () {
        onTap!();
      };
  }

  /// 构建文本小部件
  @override
  Widget build(BuildContext context) {
    var $style = el.globalTextStyle.merge(buildTextStyle(context));
    // 同步 Text 小部件的加粗文本逻辑
    if (MediaQuery.boldTextOf(context)) {
      $style.copyWith(fontWeight: FontWeight.bold);
    }
    final SelectionRegistrar? registrar = SelectionContainer.maybeOf(context);
    Widget result = DefaultTextStyle.merge(
      style: $style,
      textAlign: textAlign,
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
      child: Builder(builder: (context) {
        final $defaultStyle = DefaultTextStyle.of(context);
        return RichText(
          text: TextSpan(
            style: $defaultStyle.style,
            children: _buildRichText(context, data is List ? data : [data]),
          ),
          textAlign: $defaultStyle.textAlign ?? TextAlign.start,
          textDirection: textDirection,
          softWrap: $defaultStyle.softWrap,
          overflow: $defaultStyle.overflow,
          textScaler: textScaler ?? TextScaler.noScaling,
          maxLines: $defaultStyle.maxLines,
          locale: locale,
          strutStyle: strutStyle,
          textWidthBasis: $defaultStyle.textWidthBasis,
          textHeightBehavior: textHeightBehavior,
          selectionRegistrar: registrar,
          selectionColor: selectionColor ??
              DefaultSelectionStyle.of(context).selectionColor ??
              DefaultSelectionStyle.defaultColor,
        );
      }),
    );
    if (registrar != null) {
      result = MouseRegion(
        onHover: (e) {
          el.setCursor(DefaultSelectionStyle.of(context).mouseCursor ??
              SystemMouseCursors.text);
        },
        onExit: (e) {
          el.resetCursor();
        },
        child: result,
      );
      // result = HoverBuilder(
      //   cursor: DefaultSelectionStyle.of(context).mouseCursor ??
      //       SystemMouseCursors.text,
      //   builder: (isHover) => result,
      // );
    }
    return result;
  }

  /// 构建富文本片段集合
  List<InlineSpan> _buildRichText(BuildContext context, List children) {
    List<InlineSpan> richChildren = [];
    for (final child in children) {
      richChildren.add(_buildInlineSpan(context, child));
    }
    return richChildren;
  }

  /// 使用递归构建富文本片段
  InlineSpan _buildInlineSpan(BuildContext context, dynamic data,
      [List<InlineSpan>? children]) {
    if (DartUtil.isBaseType(data)) {
      return TextSpan(
        text: '$data',
        recognizer: buildRecognizer(),
        semanticsLabel: semanticsLabel,
        mouseCursor: mouseCursor,
      );
    }
    if (data is TextSpan || data is WidgetSpan) return data;
    if (data is ElText) {
      if (data.data is List) {
        final richTexts = data.data as List;
        List<InlineSpan> $children = [];
        if (richTexts.length > 1) {
          $children.addAll(
            _buildRichText(context, richTexts.sublist(1, richTexts.length)),
          );
        }
        return _buildInlineSpan(
          context,
          ElText(richTexts[0], style: data.buildTextStyle(context)),
          $children,
        );
      } else {
        if (DartUtil.isBaseType(data.data)) {
          var recognizer = data.buildRecognizer();
          return TextSpan(
            text: data.data,
            style: data.buildTextStyle(context),
            recognizer: recognizer,
            mouseCursor: data.mouseCursor,
            semanticsLabel: data.semanticsLabel,
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

// ============================================================================
// 除了ElText，其他文本小部件不会提供大量的额外配置，如果发现参数不能满足，请直接使用ElText
// ============================================================================

class H1 extends ElText {
  /// 一级标题
  const H1(super.data, {super.key, super.style}) : super(semanticsLabel: 'H1');

  @override
  TextStyle buildTextStyle(BuildContext context) {
    return DefaultTextStyle.of(context)
        .style
        .copyWith(
          fontSize: el.typography.h1,
          fontWeight: ElFont.bold,
        )
        .merge(style);
  }
}

class H2 extends ElText {
  /// 二级标题
  const H2(super.data, {super.key, super.style}) : super(semanticsLabel: 'H2');

  @override
  TextStyle buildTextStyle(BuildContext context) {
    return DefaultTextStyle.of(context)
        .style
        .copyWith(
          fontSize: el.typography.h2,
          fontWeight: ElFont.bold,
        )
        .merge(style);
  }
}

class H3 extends ElText {
  /// 三级标题
  const H3(super.data, {super.key, super.style}) : super(semanticsLabel: 'H3');

  @override
  TextStyle buildTextStyle(BuildContext context) {
    return DefaultTextStyle.of(context)
        .style
        .copyWith(
          fontSize: el.typography.h3,
          fontWeight: ElFont.bold,
        )
        .merge(style);
  }
}

class H4 extends ElText {
  /// 四级标题
  const H4(super.data, {super.key, super.style}) : super(semanticsLabel: 'H4');

  @override
  TextStyle buildTextStyle(BuildContext context) {
    return DefaultTextStyle.of(context)
        .style
        .copyWith(
          fontSize: el.typography.h4,
          fontWeight: ElFont.bold,
        )
        .merge(style);
  }
}

class H5 extends ElText {
  /// 五级标题
  const H5(super.data, {super.key, super.style}) : super(semanticsLabel: 'H5');

  @override
  TextStyle buildTextStyle(BuildContext context) {
    return DefaultTextStyle.of(context)
        .style
        .copyWith(
          fontSize: el.typography.h5,
          fontWeight: ElFont.bold,
        )
        .merge(style);
  }
}

class H6 extends ElText {
  /// 六级标题
  const H6(super.data, {super.key, super.style}) : super(semanticsLabel: 'H6');

  @override
  TextStyle buildTextStyle(BuildContext context) {
    return DefaultTextStyle.of(context)
        .style
        .copyWith(
          fontSize: el.typography.h6,
          fontWeight: ElFont.bold,
        )
        .merge(style);
  }
}

// class A extends ElText {
//   /// 超链接小部件。
//   ///
//   /// 注意：如果在富文本当中，依赖状态的样式无法生效，因为内部只是对 [TextSpan] 进行封装，
//   /// 但它并不是一个[Widget]，虽然提供一些简单的事件触发，但你更改样式必须嵌套有状态小部件，
//   /// 在富文本中嵌套 [Widget] 你可以使用[WidgetSpan]，但这样又会导致和其他文本无法垂直对齐。
//   const A(
//     super.data, {
//     super.key,
//     super.style,
//     required this.href,
//     this.underline,
//     this.hoverUnderline,
//   }) : super(semanticsLabel: 'A', mouseCursor: SystemMouseCursors.click);
//
//   /// 跳转地址
//   final String href;
//
//   /// 是否显示下划线
//   final bool? underline;
//
//   /// 是否在鼠标悬停时显示下划线，默认false，若为true，[underline]将无效
//   final bool? hoverUnderline;
//
//   @override
//   bool get disabledHoverBuilder => false;
//
//   @override
//   GestureRecognizer? buildRecognizer() {
//     return TapGestureRecognizer()
//       ..onTap = () {
//         launchUrl(Uri.parse(href));
//       };
//   }
//
//   @override
//   TextStyle buildTextStyle(BuildContext context) {
//     final $data = DefaultTextStyle.of(context).style.copyWith(
//           fontSize: el.typography.h1,
//           fontWeight: ElFont.bold,
//         );
//     final color = context.elTheme.primary;
//     final isHover = HoverBuilder.of(context);
//     return $data.text.merge((style ?? const TextStyle()).copyWith(
//       color: color,
//       decoration: hoverUnderline ?? $data.hoverUnderline
//           ? (isHover ? TextDecoration.underline : TextDecoration.none)
//           : underline ?? $data.underline
//               ? TextDecoration.underline
//               : TextDecoration.none,
//       decorationColor: color,
//     ));
//   }
// }
