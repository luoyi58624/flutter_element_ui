import 'package:flutter/rendering.dart';
import 'package:element_plus/src/global.dart';
import 'package:flutter/widgets.dart';

import '../../../themes/components/basic/text.dart';

part 'state.dart';

class ElText extends StatefulWidget {
  /// Element UI 文本小部件，内部直接基于 [RichText] 进行封装，同时简化了富文本的写法。
  ///
  /// 注意：[ElText] 不会从 [DefaultTextStyle] 访问默认样式，你应当使用 [ElTextTheme] 提供默认样式。
  const ElText(
    this.data, {
    super.key,
    this.duration,
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

  /// 渲染的文本内容，支持传递类型数据，它们会统一使用 toString 转成字符串，
  /// 如果是[List]集合，则会当做富文本进行渲染。
  ///
  /// 渲染富文本有一点需要注意，嵌套的组件会被转换成 TextSpan、WidgetSpan，
  /// 所以如果是继承 [ElText] 的文本组件，那么只有 style、semanticsLabel 等属性会生效
  final dynamic data;

  /// 设置文本动画持续时间，默认 [Duration.zero]
  final Duration? duration;

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

  /// 文本最大行数
  final int? maxLines;

  /// 语义化标签
  final String? semanticsLabel;

  /// 测量一行或多行文本宽度的不同方法：
  /// * parent 多行文本将占据父级给出的整个宽度。对于单行文本，将仅使用包含文本所需的最小宽度。这方面的一个常见用例是一系列标准段落
  /// * longestLine 宽度刚好足以容纳最长的一行，而不会更长。一个常见的用例是聊天气泡
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;

  /// 文本选中颜色
  final Color? selectionColor;

  @override
  State<ElText> createState() => ElTextState();

  /// 自定义默认的文本样式
  TextStyle? buildDefaultTextStyle(BuildContext context) => null;

  /// 构建富文本片段集合
  List<InlineSpan> _buildRichText(BuildContext context, List children) {
    List<InlineSpan> richChildren = [];
    for (final child in children) {
      richChildren.add(_buildInlineSpan(context, child));
    }
    return richChildren;
  }

  /// 使用递归构建富文本片段
  InlineSpan _buildInlineSpan(BuildContext context, dynamic data) {
    // 1. 如果是文本片段则直接返回
    if (data is TextSpan || data is WidgetSpan) {
      return data;
    }

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
      if (ElUtil.isBaseType(data.data)) {
        return TextSpan(
          text: '${data.data}',
          style: data.buildDefaultTextStyle(context) != null
              ? data.buildDefaultTextStyle(context)!.merge(data.style)
              : data.style,
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
            style: data.buildDefaultTextStyle(context) != null
                ? data.buildDefaultTextStyle(context)!.merge(data.style)
                : data.style,
            children: _buildRichText(context, data.data),
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
        children: _buildRichText(context, data),
      );
    }

    // 6. 默认返回文本片段
    return TextSpan(
      text: '$data',
      semanticsLabel: semanticsLabel,
    );
  }
}

// class ElTextTheme extends DefaultTextStyle {
//   /// 构建默认文本样式必须遵循继承性，所以不允许直接构造 [ElTextTheme]，
//   /// 请使用 [merge] 方法设置默认的文本样式
//   const ElTextTheme._({
//     super.key,
//     required super.style,
//     super.textAlign,
//     super.softWrap,
//     super.overflow,
//     super.maxLines,
//     super.textWidthBasis,
//     super.textHeightBehavior,
//     required super.child,
//   });
//
//   /// 将祖先提供的默认文本样式与自定义样式进行合并
//   static Widget merge({
//     Key? key,
//     TextStyle? style,
//     TextAlign? textAlign,
//     bool? softWrap,
//     TextOverflow? overflow,
//     int? maxLines,
//     TextWidthBasis? textWidthBasis,
//     required Widget child,
//   }) {
//     return Builder(
//       builder: (BuildContext context) {
//         final ElTextTheme? parent = ElTextTheme.maybeOf(context);
//         if (parent != null) {
//           return ElTextTheme._(
//             key: key,
//             style: parent.style.merge(style),
//             textAlign: textAlign ?? parent.textAlign,
//             softWrap: softWrap ?? parent.softWrap,
//             overflow: overflow ?? parent.overflow,
//             maxLines: maxLines ?? parent.maxLines,
//             textWidthBasis: textWidthBasis ?? parent.textWidthBasis,
//             child: child,
//           );
//         } else {
//           return ElTextTheme._(
//             key: key,
//             style: style ?? const TextStyle(),
//             textAlign: textAlign,
//             softWrap: softWrap ?? true,
//             overflow: overflow ?? TextOverflow.clip,
//             maxLines: maxLines,
//             textWidthBasis: textWidthBasis ?? TextWidthBasis.parent,
//             child: child,
//           );
//         }
//       },
//     );
//   }
//
//   static ElTextTheme? maybeOf(BuildContext context) =>
//       context.dependOnInheritedWidgetOfExactType<ElTextTheme>();
//
//   static ElTextTheme of(BuildContext context) {
//     final ElTextTheme? result = maybeOf(context);
//     assert(result != null, 'No ElTextTheme found in context');
//     return result!;
//   }
//
//   @override
//   bool updateShouldNotify(ElTextTheme oldWidget) => true;
// }
//
// class ElAnimatedDefaultTextStyle extends ImplicitlyAnimatedWidget {
//   /// 默认的动画文本样式，这也是直接复制 [AnimatedDefaultTextStyle] 小部件，
//   const ElAnimatedDefaultTextStyle({
//     super.key,
//     required this.child,
//     required this.style,
//     this.textAlign,
//     this.softWrap = true,
//     this.overflow = TextOverflow.clip,
//     this.maxLines,
//     this.textWidthBasis = TextWidthBasis.parent,
//     this.textHeightBehavior,
//     super.curve,
//     required super.duration,
//     super.onEnd,
//   }) : assert(maxLines == null || maxLines > 0);
//
//   final Widget child;
//
//   /// 提示：使用自定义文本样式前注意通过 [ElTextTheme.of] 合并祖先样式
//   final TextStyle style;
//   final TextAlign? textAlign;
//   final bool softWrap;
//   final TextOverflow overflow;
//   final int? maxLines;
//   final TextWidthBasis textWidthBasis;
//   final TextHeightBehavior? textHeightBehavior;
//
//   @override
//   AnimatedWidgetBaseState<ElAnimatedDefaultTextStyle> createState() =>
//       _ElAnimatedDefaultTextStyleState();
// }
//
// class _ElAnimatedDefaultTextStyleState
//     extends AnimatedWidgetBaseState<ElAnimatedDefaultTextStyle> {
//   TextStyleTween? _style;
//
//   @override
//   void forEachTween(TweenVisitor<dynamic> visitor) {
//     _style = visitor(_style, widget.style,
//             (dynamic value) => TextStyleTween(begin: value as TextStyle))
//         as TextStyleTween?;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ElTextTheme._(
//       style: _style!.evaluate(animation),
//       textAlign: widget.textAlign,
//       softWrap: widget.softWrap,
//       overflow: widget.overflow,
//       maxLines: widget.maxLines,
//       textWidthBasis: widget.textWidthBasis,
//       textHeightBehavior: widget.textHeightBehavior,
//       child: widget.child,
//     );
//   }
// }
