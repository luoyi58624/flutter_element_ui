import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syntax_highlight/syntax_highlight.dart';
import 'package:element_plus/src/global.dart';

part 'state.dart';

/// [syntax_highlight] 需要加载 assert 资产包中的代码样式配置文件，这个全局变量表示是否初始化成功
bool _initialize = false;

/// 暗色代码主题
Highlighter? _darkCode;

class ElCodePreview extends StatefulWidget {
  /// 代码示例预览小部件，展示效果基于第三方库：[syntax_highlight]
  const ElCodePreview({
    super.key,
    required this.code,
    this.fontFamily,
    this.color,
    this.bgColor,
    this.enableSection,
    this.height,
    this.maxHeight,
    this.borderRadius,
  });

  /// 示例代码字符串
  final String code;

  /// 字体名称
  final String? fontFamily;

  /// 默认文本颜色
  final Color? color;

  /// 默认背景颜色
  final Color? bgColor;

  /// 是否开启文本选择
  final bool? enableSection;

  /// 固定高度
  final double? height;

  /// 代码块最大高度
  final double? maxHeight;

  /// 代码示例背景圆角
  final BorderRadius? borderRadius;

  @override
  State<ElCodePreview> createState() => _ElCodePreviewState();
}

class _ElCodePreviewState extends State<ElCodePreview> {
  ScrollController scrollController = ScrollController();
  final code = Obs(const TextSpan());

  TextStyle get _textStyle => TextStyle(
        fontFamily:
            widget.fontFamily ?? context.elTheme.codePreviewTheme.fontFamily,
        fontSize: 14,
        height: 1.5,
      );

  Color get codeColor => widget.color ?? context.elTheme.codePreviewTheme.color;

  EdgeInsetsGeometry get _padding => const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      );

  Color get bgColor =>
      widget.bgColor ?? context.elTheme.codePreviewTheme.bgColor;

  BorderRadius get borderRadius =>
      widget.borderRadius ?? context.elTheme.cardTheme.radius;

  @override
  void initState() {
    super.initState();
    initCodeStyle(context);
  }

  @override
  void didUpdateWidget(covariant ElCodePreview oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.code != oldWidget.code) {
      initCodeStyle(context);
    }
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildElCodePreview();
  }

  /// 初始化预览代码样式，全局只加载一次
  void initCodeStyle(BuildContext context) {
    if (_initialize == false || _darkCode == null) {
      nextTick(() async {
        await Highlighter.initialize(['dart']);
        _initialize = true;
        // 暗色主题使用自定义的配置文件
        var darkCodeTheme = await HighlighterTheme.loadFromAssets(
          [
            'packages/element_plus/assets/code_themes/dark_vs.json',
            'packages/element_plus/assets/code_themes/dark_plus.json',
            // 'assets/code_themes/dark_vs.json',
            // 'assets/code_themes/dark_plus.json',
          ],
          TextStyle(color: codeColor),
        );
        _darkCode = Highlighter(language: 'dart', theme: darkCodeTheme);
        if (context.mounted) {
          code.value = _darkCode!.highlight(widget.code);
        }
      });
    } else {
      code.value = _darkCode!.highlight(widget.code);
    }
  }

  /// 构建预览代码块
  Widget buildElCodePreview() {
    return Stack(
      children: [
        TextSelectionTheme(
          data: TextSelectionThemeData(
            selectionColor: bgColor.isDark
                ? Colors.blueAccent.withOpacity(0.5)
                : Colors.blue.withOpacity(0.36),
          ),
          child: AnimatedContainer(
            duration: context.elConfig.themeDuration,
            width: double.infinity,
            height: widget.height,
            constraints: widget.maxHeight != null
                ? BoxConstraints(
                    minWidth: double.infinity,
                    maxWidth: double.infinity,
                    maxHeight: widget.maxHeight!,
                  )
                : null,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: borderRadius,
            ),
            clipBehavior: Clip.hardEdge,
            child: NestScrollWrapper(
              controller: scrollController,
              child: SingleChildScrollView(
                controller: scrollController,
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildLineNum(),
                      Expanded(child: buildCode()),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: buildCopyButton(),
        ),
      ],
    );
  }

  Widget buildCode() {
    Widget result = SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ObsBuilder(builder: (context) {
        return Container(
          padding: _padding,
          child: ObsBuilder(builder: (context) {
            return ElText(
              code.value,
              softWrap: false,
              style: _textStyle,
            );
          }),
        );
      }),
    );
    if (widget.enableSection ??
        context.elTheme.codePreviewTheme.enableSection) {
      result = SelectionArea(child: result);
    }
    return result;
  }

  Widget buildLineNum() {
    final numLines = '\n'.allMatches(widget.code).length + 1;

    return Container(
      height: double.infinity,
      padding: _padding,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.only(
          topLeft: borderRadius.topLeft,
          bottomLeft: borderRadius.bottomLeft,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 2,
            offset: Offset(2, 0),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(
          numLines,
          (index) => ElText(
            '${index + 1}',
            textAlign: TextAlign.right,
            style: _textStyle.copyWith(
              color: context.elTheme.textTheme.secondaryStyle.color,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCopyButton() {
    return ElHoverBuilder(
      cursor: SystemMouseCursors.click,
      builder: (context) {
        return GestureDetector(
          onTap: () async {
            await Clipboard.setData(ClipboardData(text: widget.code));
            el.message.show('复制成功', type: El.success);
          },
          onTapDown: (e) {
            HapticFeedback.mediumImpact();
          },
          child: AnimatedContainer(
            duration: context.elDuration(const Duration(milliseconds: 250)),
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              borderRadius: context.elConfig.radius,
              color:
                  bgColor.isDark ? Colors.grey.shade700 : Colors.grey.shade300,
            ),
            child: ElIcon(
              ElIcons.documentCopy,
              color:
                  bgColor.isDark ? Colors.grey.shade300 : Colors.grey.shade700,
              size: 14,
            ),
          ),
        );
      },
    );
  }
}
