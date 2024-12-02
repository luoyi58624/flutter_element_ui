import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/flutter_base.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

/// [syntax_highlight] 需要加载 assert 资产包中的代码样式配置文件，这个全局变量表示是否初始化成功
bool _initialize = false;

/// 暗色代码主题
Highlighter? _darkCode;

class CodePreview extends StatefulWidget {
  /// 代码示例预览小部件，展示效果基于第三方库：[syntax_highlight]
  const CodePreview({
    super.key,
    required this.code,
    this.color = const Color(0xFFD19A66),
    this.bgColor = const Color.fromRGBO(49, 49, 49, 1.0),
    this.height,
    this.maxHeight,
    this.borderRadius,
  });

  /// 示例代码字符串
  final String code;

  /// 默认文本颜色
  final Color color;

  /// 默认背景颜色
  final Color bgColor;

  /// 固定高度
  final double? height;

  /// 代码块最大高度
  final double? maxHeight;

  /// 代码示例背景圆角
  final BorderRadius? borderRadius;

  /// 代码字体全局样式
  static final textStyle = Obs(const TextStyle(
    fontSize: 14,
    height: 1.5,
  ));

  @override
  State<CodePreview> createState() => _CodePreviewState();
}

class _CodePreviewState extends State<CodePreview> {
  ScrollController scrollController = ScrollController();
  final code = Obs(const TextSpan());

  Color get codeColor => widget.color;

  EdgeInsetsGeometry get _padding => const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      );

  Color get bgColor => widget.bgColor;

  BorderRadius get borderRadius =>
      widget.borderRadius ?? context.elConfig.cardRadius!;

  @override
  void initState() {
    super.initState();
    initCodeStyle(context);
  }

  @override
  void didUpdateWidget(covariant CodePreview oldWidget) {
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
    return buildCodePreview();
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
            'packages/flutter_base/assets/code_themes/dark_vs.json',
            'packages/flutter_base/assets/code_themes/dark_plus.json',
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
  Widget buildCodePreview() {
    return Stack(
      children: [
        TextSelectionTheme(
          data: TextSelectionThemeData(
            selectionColor: bgColor.isDark
                ? Colors.blueAccent.withOpacity(0.5)
                : Colors.blue.withOpacity(0.36),
          ),
          child: Container(
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
    Widget result = SelectionArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ObsBuilder(builder: (context) {
          return Container(
            padding: _padding,
            child: ObsBuilder(builder: (context) {
              return ElText(
                code.value,
                softWrap: false,
                style: CodePreview.textStyle.value,
              );
            }),
          );
        }),
      ),
    );
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
      child: ObsBuilder(
          watch: [CodePreview.textStyle],
          builder: (context) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(
                numLines,
                (index) => ElText(
                  '${index + 1}',
                  textAlign: TextAlign.right,
                  style: CodePreview.textStyle.value.copyWith(
                    color: context.elTheme.textTheme.secondaryStyle.color,
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget buildCopyButton() {
    return ElEvent(
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
