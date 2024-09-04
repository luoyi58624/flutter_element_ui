import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

// 注意：ElText 只会从 ElDefaultTextStyle 组件访问祖先默认的文本样式，所以，它并不能完全代替 Text 小部件，
// 当你使用一些小部件用到 DefaultTextStyle 时，你可能需要使用 Text 小部件。
//
// 究其原因是我实在不想依赖 Material 的文本设计系统，它太繁杂了，官方给它设计了 10 种左右的文本主题，
// 目前我体会不到它的任何好处，我只想拥有一种全局默认的文本样式，然后根据需求自己封装不同类型的文本小部件。
//
// 然后问题便在于 Material 系列的小部件不会合并祖先默认文本样式，因为它们有自身那一套庞大的设计体系，
// 所以我只能被迫再搞一个独立的默认文本样式，用于绕开 Material 的限制。
//
// 那为什么 Element UI 非要使用 Material 组件？
// 注意：Material 是一个系列，你平时用 Scaffold 脚手架内部也用到了 Material 小部件，
// 你不可能只用 Element UI 提供的组件，我也不可能脱离 Material 从头去设计所有组件。
class ElText extends StatelessWidget {
  /// Element UI 文本小部件，底层基于 [RichText] 进行封装，同时简化了富文本的写法。
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
    this.semanticsLabel = 'Text',
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
  });

  /// 渲染的文本内容，支持传递任意小部件，如果是[List]集合，则会渲染成富文本。
  ///
  /// 渲染富文本有一点需要注意，嵌套的组件会被转换成 TextSpan、WidgetSpan，
  /// 所以如果是文本组件，那么只有 style、semanticsLabel 等属性会生效
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

  /// 自定义当前文本样式，覆写它可以实现自定义样式文本，例如：H1、H2...
  TextStyle? get textStyle => style;

  /// 构建当前文本样式
  TextStyle _buildTextStyle(ElDefaultTextStyle defaultStyle, TextStyle? style) {
    return defaultStyle.style.merge(textStyle).merge(style);
  }

  /// 构建富文本片段集合
  List<InlineSpan> _buildRichText(ElDefaultTextStyle defaultStyle, List children) {
    List<InlineSpan> richChildren = [];
    for (final child in children) {
      richChildren.add(_buildInlineSpan(defaultStyle, child));
    }
    return richChildren;
  }

  /// 使用递归构建富文本片段
  InlineSpan _buildInlineSpan(ElDefaultTextStyle defaultStyle, dynamic data) {
    // 1. 如果是文本片段则直接返回
    if (data is TextSpan || data is WidgetSpan) return data;

    // 2. 处理 Text 小部件，对于嵌套的子组件，TextSpan 本身就只接受少量参数，所以其他参数会被忽略
    if (data is Text) {
      return TextSpan(
        text: '${data.data}',
        style: data.style,
        semanticsLabel: data.semanticsLabel,
      );
    }

    // 3. 处理自定义的 ElText 小部件，2、3 两个步骤是对第 4 步进行一个扩充，
    // 目的是以最大限度解决文本垂直对齐问题，单纯地使用 WidgetSpan 渲染如果有些文字太大，
    // 那么依旧存在文本无法垂直对齐bug
    if (data is ElText) {
      if (DartUtil.isBaseType(data.data)) {
        return TextSpan(
          text: '${data.data}',
          style: data._buildTextStyle(defaultStyle, data.style),
          semanticsLabel: data.semanticsLabel,
        );
      } else if (data.data is List) {
        // 如果列表中存在非文本小部件，那么不能使用 TextSpan 渲染，否则在多级嵌套下会出现样式问题，例如：
        // P(
        //  B([
        //    A('百度', href: 'https://www.baidu.com'),
        //  ]),
        // ),
        // A 标签属于 StatelessWidget 小部件，它内部会继承父级样式，如果 B 标签是通过 TextSpan 渲染，
        // 由于 DefaultTextStyle 无法访问 TextSpan 样式，那么它将继承 P 标签的样式，导致加粗失败，
        // 所以针对这种情况我们需要跳到步骤 4 处理，用 WidgetSpan 渲染 B 标签。
        bool hasWidget = (data.data as List)
            .any((e) => e is Widget && (e is! Text || e is! ElText));
        if (!hasWidget) {
          return TextSpan(
            style: data._buildTextStyle(defaultStyle, data.style),
            children: _buildRichText(defaultStyle, data.data),
          );
        }
      }
    }

    // 4. 如果是 Widget 小部件，则使用 WidgetSpan 包裹，默认使用文本对齐方案，
    // 如果你传递的 Widget 不是文本，你可以自己包裹 WidgetSpan 实现自定义对齐
    if (data is Widget) {
      return WidgetSpan(
        alignment: PlaceholderAlignment.baseline,
        baseline: TextBaseline.alphabetic,
        child: data,
      );
    }

    // 5. 如果是数组，则递归渲染
    if (data is List) {
      return TextSpan(
        children: _buildRichText(defaultStyle, data),
      );
    }

    // 6. 默认返回文本片段
    return TextSpan(
      text: '$data',
      semanticsLabel: semanticsLabel,
    );
  }

  @override
  Widget build(BuildContext context) {
    final $defaultStyle = ElDefaultTextStyle.of(context);
    var $style = _buildTextStyle($defaultStyle, style);
    // 同步 Text 小部件的加粗文本逻辑
    if (MediaQuery.boldTextOf(context)) {
      $style.copyWith(fontWeight: FontWeight.bold);
    }
    final SelectionRegistrar? registrar = SelectionContainer.maybeOf(context);
    Widget result = Builder(builder: (context) {
      return RichText(
        text: TextSpan(
          style: $style,
          children: _buildRichText($defaultStyle, data is List ? data : [data]),
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
    });

    if (registrar == null) return result;
    return HoverBuilder(
        onlyCursor: true,
        cursor: DefaultSelectionStyle.of(context).mouseCursor ??
            HoverBuilder.mouseCursor(context) ??
            SystemMouseCursors.text,
        builder: (context) {
          return result;
        });
  }
}

class ElDefaultTextStyle extends DefaultTextStyle {
  /// 之所以不使用 [DefaultTextStyle] 是因为 [Material] 小部件不尊重祖先提供的默认文本样式，
  /// 它会覆盖 Element UI 注入的全局文本样式。
  const ElDefaultTextStyle({
    super.key,
    required super.style,
    super.textAlign,
    super.softWrap = true,
    super.overflow = TextOverflow.clip,
    super.maxLines,
    super.textWidthBasis = TextWidthBasis.parent,
    super.textHeightBehavior,
    required super.child,
  });

  static Widget merge({
    Key? key,
    TextStyle? style,
    TextAlign? textAlign,
    bool? softWrap,
    TextOverflow? overflow,
    int? maxLines,
    TextWidthBasis? textWidthBasis,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        final ElDefaultTextStyle parent = ElDefaultTextStyle.of(context);
        return ElDefaultTextStyle(
          key: key,
          style: parent.style.merge(style),
          textAlign: textAlign ?? parent.textAlign,
          softWrap: softWrap ?? parent.softWrap,
          overflow: overflow ?? parent.overflow,
          maxLines: maxLines ?? parent.maxLines,
          textWidthBasis: textWidthBasis ?? parent.textWidthBasis,
          child: child,
        );
      },
    );
  }

  static ElDefaultTextStyle? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ElDefaultTextStyle>();

  static ElDefaultTextStyle of(BuildContext context) {
    final ElDefaultTextStyle? result = maybeOf(context);
    assert(result != null, 'No ElDefaultTextStyle found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ElDefaultTextStyle oldWidget) => true;
}

class ElAnimatedDefaultTextStyle extends ImplicitlyAnimatedWidget {
  /// 默认的动画文本样式，这也是直接复制 [AnimatedDefaultTextStyle] 小部件
  const ElAnimatedDefaultTextStyle({
    super.key,
    required this.child,
    required this.style,
    this.textAlign,
    this.softWrap = true,
    this.overflow = TextOverflow.clip,
    this.maxLines,
    this.textWidthBasis = TextWidthBasis.parent,
    this.textHeightBehavior,
    super.curve,
    required super.duration,
    super.onEnd,
  }) : assert(maxLines == null || maxLines > 0);

  final Widget child;
  final TextStyle style;
  final TextAlign? textAlign;
  final bool softWrap;
  final TextOverflow overflow;
  final int? maxLines;
  final TextWidthBasis textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;

  @override
  AnimatedWidgetBaseState<ElAnimatedDefaultTextStyle> createState() =>
      _ElAnimatedDefaultTextStyleState();
}

class _ElAnimatedDefaultTextStyleState
    extends AnimatedWidgetBaseState<ElAnimatedDefaultTextStyle> {
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
