import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
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

  /// 从上下文拿到注入的排版配置数据
  static ElTypographyData of(BuildContext context) {
    return context
            .dependOnInheritedWidgetOfExactType<ElTypographyInheritedWidget>()
            ?.data ??
        ElTheme.of(context).typography;
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

  /// * 如果是[List]，则当做富文本渲染，你可以插入任意类型的内容。
  /// * 否则统一渲染为[Text]，无论是字符串还是其他类型，都会自动转成String类型。
  ///
  /// 提示：构建富文本时如果你插入的不是文本组件，那么你可能会遇到对齐问题，
  /// 默认情况下所有内容为底部对齐，如果你想垂直居中，请传递[WidgetSpan]并设置 alignment 属性。
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

  /// 构建文本样式抽象方法
  TextStyle buildTextStyle(BuildContext context);

  /// 构建文本小部件，如果[data]是[List]，则构建富文本，否则渲染普通[Text]小部件
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: buildTextStyle(context),
      textAlign: textAlign,
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
      textWidthBasis: textWidthBasis,
      child: _buildTextWidget(context),
    );
  }

  /// 构建文本组件
  Widget _buildTextWidget(BuildContext context) {
    final SelectionRegistrar? registrar = SelectionContainer.maybeOf(context);
    Widget result = Builder(builder: (context) {
      return RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: _buildRichText(context, data is List ? data : [data]),
        ),
        textAlign: textAlign ?? TextAlign.start,
        textDirection: textDirection,
        softWrap: softWrap,
        overflow: overflow ?? TextOverflow.clip,
        textScaler: textScaler ?? TextScaler.noScaling,
        maxLines: maxLines,
        locale: locale,
        strutStyle: strutStyle,
        textWidthBasis: textWidthBasis ?? TextWidthBasis.parent,
        textHeightBehavior: textHeightBehavior,
        selectionRegistrar: registrar,
        selectionColor: selectionColor ??
            DefaultSelectionStyle.of(context).selectionColor ??
            DefaultSelectionStyle.defaultColor,
      );
    });
    if (registrar != null) {
      result = MouseRegion(
        cursor: DefaultSelectionStyle.of(context).mouseCursor ??
            SystemMouseCursors.text,
        child: result,
      );
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

  /// 使用递归构建单个富文本片段
  InlineSpan _buildInlineSpan(BuildContext context, dynamic data,
      [List<InlineSpan>? children]) {
    if (DartUtil.isBaseType(data)) {
      GestureRecognizer? recognizer;
      if (onTap != null) {
        recognizer = TapGestureRecognizer()
          ..onTap = () {
            onTap!();
          };
      }
      return TextSpan(
        text: '$data',
        recognizer: recognizer,
        semanticsLabel: semanticsLabel,
        mouseCursor: mouseCursor,
      );
    }
    if (data is TextSpan || data is WidgetSpan) return data;
    if (data is ElTypography) {
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
          GestureRecognizer? recognizer;
          if (data.onTap != null) {
            recognizer = TapGestureRecognizer()
              ..onTap = () {
                data.onTap!();
              };
          }
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

/// Element UI 普通文本小部件
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
    super.mouseCursor,
    super.onTap,
  });

  @override
  TextStyle buildTextStyle(BuildContext context) {
    return ElTypographyInheritedWidget.of(context).text.merge(style);
  }
}

/// 一级标题
class H1 extends ElTypography {
  const H1(
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
    super.mouseCursor,
    super.onTap,
  }) : super(semanticsLabel: 'H1');

  @override
  TextStyle buildTextStyle(BuildContext context) {
    return ElTypographyInheritedWidget.of(context).h1.merge(style);
  }
}

/// 二级标题
class H2 extends ElTypography {
  const H2(
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
    super.mouseCursor,
    super.onTap,
  }) : super(semanticsLabel: 'H2');

  @override
  TextStyle buildTextStyle(BuildContext context) {
    return ElTypographyInheritedWidget.of(context).h2.merge(style);
  }
}

/// 三级标题
class H3 extends ElTypography {
  const H3(
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
    super.mouseCursor,
    super.onTap,
  }) : super(semanticsLabel: 'H3');

  @override
  TextStyle buildTextStyle(BuildContext context) {
    return ElTypographyInheritedWidget.of(context).h3.merge(style);
  }
}

/// 四级标题
class H4 extends ElTypography {
  const H4(
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
    super.mouseCursor,
    super.onTap,
  }) : super(semanticsLabel: 'H4');

  @override
  TextStyle buildTextStyle(BuildContext context) {
    return ElTypographyInheritedWidget.of(context).h4.merge(style);
  }
}

/// 五级标题
class H5 extends ElTypography {
  const H5(
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
    super.mouseCursor,
    super.onTap,
  }) : super(semanticsLabel: 'H5');

  @override
  TextStyle buildTextStyle(BuildContext context) {
    return ElTypographyInheritedWidget.of(context).h5.merge(style);
  }
}

/// 六级标题
class H6 extends ElTypography {
  const H6(
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
    super.mouseCursor,
    super.onTap,
  }) : super(semanticsLabel: 'H6');

  @override
  TextStyle buildTextStyle(BuildContext context) {
    return ElTypographyInheritedWidget.of(context).h6.merge(style);
  }
}

/// 超链接
class A extends ElTypography {
  const A(super.data, {super.key, super.style}) : super(semanticsLabel: 'A');

  @override
  TextStyle buildTextStyle(BuildContext context) {
    return ElTypographyInheritedWidget.of(context).text.merge(style);
  }
}
