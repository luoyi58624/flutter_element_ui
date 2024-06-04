import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/extension.dart';

class ElTextStyle {
  /// 默认文本样式
  static const ElTextStyle style = ElTextStyle(
    textStyle: TextStyle(),
    strutStyle: StrutStyle(),
  );

  /// 文本样式
  final TextStyle? textStyle;

  /// 文字排版样式
  final StrutStyle? strutStyle;

  const ElTextStyle({
    this.textStyle,
    this.strutStyle,
  });

  ElTextStyle copyWith({
    TextStyle? textStyle,
    StrutStyle? strutStyle,
  }) {
    return ElTextStyle(
      textStyle: this.textStyle?.merge(textStyle),
      strutStyle: strutStyle ?? this.strutStyle,
    );
  }

  /// 合并新的主题配置
  ElTextStyle merge([ElTextStyle? style]) {
    if (style == null) return this;
    return copyWith(
      textStyle: textStyle?.merge(style.textStyle),
      strutStyle: style.strutStyle,
    );
  }
}

class ElTextTheme extends InheritedWidget {
  /// 局部默认样式小部件
  const ElTextTheme({
    super.key,
    required super.child,
    required this.style,
  });

  final ElTextStyle style;

  static ElTextStyle? _merge(BuildContext context, ElTextStyle? style) {
    var defaultStyle = context.dependOnInheritedWidgetOfExactType<ElTextTheme>()?.style;
    return defaultStyle == null ? style : defaultStyle.merge(style);
  }

  @override
  bool updateShouldNotify(ElTextTheme oldWidget) => true;
}

class ElTextImportantTheme extends InheritedWidget {
  /// 强制后代小部件应用的主题样式，效果类似于 CSS !important
  const ElTextImportantTheme({
    super.key,
    required super.child,
    required this.style,
  });

  final ElTextStyle style;

  static ElTextStyle _merge(BuildContext context, ElTextStyle style) =>
      style.merge(context.dependOnInheritedWidgetOfExactType<ElTextImportantTheme>()?.style);

  @override
  bool updateShouldNotify(ElTextImportantTheme oldWidget) => true;
}

class ElText extends StatelessWidget {
  /// 文本小部件，对[Text]进行的封装，支持如下功能：
  /// * 支持任意类型，并不局限String
  /// * 支持覆盖后代样式
  const ElText(
    this.text, {
    super.key,
    this.style,
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

  /// 文字内容，支持传递任意类型
  final dynamic text;

  /// 文本样式
  final ElTextStyle? style;

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

  @override
  Widget build(BuildContext context) {
    final $style = ElTextImportantTheme._merge(
      context,
      context.elConfig.textStyle.merge(
        ElTextTheme._merge(context, style),
      ),
    );
    return Text(
      '$text',
      style: $style.textStyle,
      strutStyle: $style.strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaler: textScaler,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      selectionColor: selectionColor,
    );
  }
}
