import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:luoyi_dart_base/luoyi_dart_base.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core.dart';
import '../../utils/font.dart';
import '../../widgets/hover.dart';
import '../../widgets/tap.dart';

/// 字体排版配置
class ElTypographyData {
  /// 默认的字体排版配置
  static final data = ElTypographyData(
    h1: 28,
    h2: 24,
    h3: 20,
    h4: 18,
    h5: 16,
    h6: 14,
    text: 15,
  );

  /// 一级标题
  final double h1;

  /// 二级标题
  final double h2;

  /// 三级标题
  final double h3;

  /// 四级标题
  final double h4;

  /// 五级标题
  final double h5;

  /// 六级标题
  final double h6;

  /// 普通文本
  final double text;

  final Widget Function(BuildContext context, String)? builder;

  ElTypographyData({
    required this.h1,
    required this.h2,
    required this.h3,
    required this.h4,
    required this.h5,
    required this.h6,
    required this.text,
    this.builder,
  });

  ElTypographyData copyWith({
    double? h1,
    double? h2,
    double? h3,
    double? h4,
    double? h5,
    double? h6,
    double? text,
    Color? hrefColor,
    bool? underline,
    bool? hoverUnderline,
  }) {
    return ElTypographyData(
      h1: h1 ?? this.h1,
      h2: h2 ?? this.h2,
      h3: h3 ?? this.h3,
      h4: h4 ?? this.h4,
      h5: h5 ?? this.h5,
      h6: h6 ?? this.h6,
      text: text ?? this.text,
    );
  }
}

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
  });

  /// 渲染的文本内容，支持传递任意小部件，如果是[List]集合，则会渲染成富文本。
  ///
  /// 对于富文本，如果传递的类型并非基础数据类型或者 [ElText] 类型，
  /// 那么将自动使用 [WidgetSpan] 进行包裹，为了能够垂直对齐文本，
  /// [WidgetSpan]设置了特定的 alignment、baseline 属性，
  /// 这些默认值对于非文本小部件的垂直对齐效果不好，
  /// 但你可以自己在外面包裹 [WidgetSpan] 调整定位。
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

  /// 构建当前文本样式
  TextStyle buildTextStyle(BuildContext context) {
    return DefaultTextStyle.of(context).style.merge(style);
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
    return HoverBuilder(
        onlyCursor: true,
        cursor: registrar == null
            ? null
            : DefaultSelectionStyle.of(context).mouseCursor ??
                HoverBuilder.mouseCursor(context) ??
                SystemMouseCursors.text,
        builder: (context) {
          return DefaultTextStyle.merge(
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
                  children:
                      _buildRichText(context, data is List ? data : [data]),
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
        });
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
    // 如果是基础数据类型，则返回文本片段
    if (DartUtil.isBaseType(data)) {
      return TextSpan(
        text: '$data',
        semanticsLabel: semanticsLabel,
      );
    }
    // 直接返回富文本的文本片段
    if (data is TextSpan || data is WidgetSpan) return data;
    // 处理 ElText 类型，如果目标 data 是数组，则递归构建文本片段
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
          return TextSpan(
            text: data.data,
            style: data.buildTextStyle(context),
            semanticsLabel: data.semanticsLabel,
            children: children != null && children.isNotEmpty ? children : null,
          );
        }
      }
    }
    return WidgetSpan(
      alignment: PlaceholderAlignment.baseline,
      baseline: TextBaseline.alphabetic,
      child: data,
    );
  }
}

// ============================================================================
// 标题小部件不会提供大量的额外配置，如果发现参数不能满足，请直接使用ElText
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

/// 超链接构建器
typedef HrefWidgetBuilder = Widget Function(
  BuildContext context,
  String text,
  String href,
);

class A extends StatelessWidget {
  /// 超链接小部件，当鼠标悬停时会在左下角显示链接地址，如果子组件是[Widget]，则不会触发点击事件，
  /// 其他数据类型则会调用 [builder] 构建默认风格的文本小部件。
  const A({
    super.key,
    required this.child,
    required this.href,
    this.builder,
  });

  /// 支持任意类型子组件
  final dynamic child;

  /// 超链接地址
  final String href;

  /// 构建默认风格的超链接小部件，支持全局配置
  final HrefWidgetBuilder? builder;

  /// 通过上下文拿到超链接的跳转地址
  static String of(BuildContext context) => _HrefInheritedWidget.of(context);

  @override
  Widget build(BuildContext context) {
    return _HrefInheritedWidget(
      href,
      child: HoverBuilder(
        cursor: SystemMouseCursors.click,
        builder: (context) {
          if (child is Widget) return child;
          final $builder = builder ??
              el.typography.builder ??
              (context, text) => HrefTextWidget(text, href);
          return $builder(context, child.toString());
        },
      ),
    );
  }
}

class _HrefInheritedWidget extends InheritedWidget {
  const _HrefInheritedWidget(this.href, {required super.child});

  final String href;

  static String of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_HrefInheritedWidget>()!.href;

  @override
  bool updateShouldNotify(_HrefInheritedWidget oldWidget) => false;
}

enum HrefDecoration {
  /// 不显示下划线
  none,

  /// 显示下划线
  underline,

  /// 当悬停时显示下划线
  hoverUnderline,
}

/// 超链接文本小部件
class HrefTextWidget extends StatelessWidget {
  const HrefTextWidget(
    this.text,
    this.href, {
    super.key,
    this.color = hrefColor,
    this.activeColor = hrefColor,
    this.decoration = HrefDecoration.hoverUnderline,
  });

  /// 文本字符串
  final String text;

  /// 超链接地址
  final String href;

  /// 默认的超链接文本颜色
  final Color color;

  /// 激活的超链接文本颜色
  final Color activeColor;

  /// 超链接下划线显示逻辑
  final HrefDecoration decoration;

  static const Color hrefColor = Color.fromRGBO(9, 105, 218, 1);

  @override
  Widget build(BuildContext context) {
    return TapBuilder(onTap: () {
      launchUrl(Uri.parse(href));
    }, builder: (context) {
      return DefaultTextStyle.merge(
        style: TextStyle(
          color: HoverBuilder.of(context) ? activeColor : color,
          decoration: decoration == HrefDecoration.underline
              ? TextDecoration.underline
              : decoration == HrefDecoration.hoverUnderline
                  ? (HoverBuilder.of(context)
                      ? TextDecoration.underline
                      : TextDecoration.none)
                  : TextDecoration.none,
          decorationColor: HoverBuilder.of(context) ? activeColor : color,
        ),
        child: ElText(text),
      );
    });
  }
}

// class A extends ElText {
//   /// 超链接小部件
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
//     return DefaultTextStyle.of(context).style.merge(style).copyWith(
//           color: el.typography.hrefColor,
//           decoration: underline ?? el.typography.underline
//               ? TextDecoration.underline
//               : null,
//           decorationColor: el.typography.hrefColor,
//         );
//   }
// }
