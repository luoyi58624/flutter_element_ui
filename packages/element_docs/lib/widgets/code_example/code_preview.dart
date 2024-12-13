import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

/// [syntax_highlight] 需要加载 assert 资产包中的代码样式配置文件，这个全局变量表示是否初始化成功
bool _initialize = false;

/// 暗色代码主题
Highlighter? _darkCode;

/// 解决行高和代码（中文高度比英文、数字高）不一致问题
const _codeStrutStyle = StrutStyle(
  forceStrutHeight: true,
  leading: 0.3,
);

/// 默认代码样式
const _codeTextStyle = TextStyle(
  fontSize: 14,
  height: 1.5,
  fontFamily: MyFonts.consolas,
);

class CodePreview extends StatefulWidget {
  /// 代码示例预览小部件，展示效果基于第三方库：[syntax_highlight]
  const CodePreview({
    super.key,
    required this.code,
    this.color = const Color(0xFFD19A66),
    this.bgColor = const Color.fromRGBO(49, 49, 49, 1.0),
    this.maxHeight,
    this.borderRadius,
    this.textStyle,
  });

  /// 示例代码字符串
  final String code;

  /// 默认文本颜色
  final Color color;

  /// 默认背景颜色
  final Color bgColor;

  /// 代码块最大高度
  final double? maxHeight;

  /// 代码示例背景圆角
  final BorderRadius? borderRadius;

  /// 代码字体样式
  final TextStyle? textStyle;

  @override
  State<CodePreview> createState() => _CodePreviewState();
}

class _CodePreviewState extends State<CodePreview> {
  ScrollController verticalController = ScrollController();
  ScrollController horizontalController = ScrollController();
  ScrollController lineNumController = ScrollController();
  final code = Obs(const TextSpan());
  final codeHeight = Obs(0.0);

  final lineNumKey = GlobalKey();
  final lineNumWidth = Obs(0.0);

  Color get codeColor => widget.color;

  EdgeInsetsGeometry get _padding => const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      );

  TextStyle get textStyle => _codeTextStyle.merge(widget.textStyle);

  Color get bgColor => widget.bgColor;

  BorderRadius get borderRadius =>
      widget.borderRadius ?? context.commonSizePreset.cardRadius!;

  @override
  void initState() {
    super.initState();
    initCodeStyle(context);
    verticalController.addListener(() {
      lineNumController.jumpTo(verticalController.position.pixels);
    });
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
    verticalController.dispose();
    horizontalController.dispose();
    lineNumController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget result = buildCodePreview();
    if (widget.maxHeight != null) {
      result = SizedBox.expand(child: result);
    }
    return ClipRRect(
      borderRadius: borderRadius,
      child: ColoredBox(color: bgColor, child: result),
    );
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
            'assets/code_themes/dark_vs.json',
            'assets/code_themes/dark_plus.json',
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
    return ElBrightness(
      brightness: Brightness.dark,
      child: Stack(
        children: [
          TextSelectionTheme(
            data: TextSelectionThemeData(
              selectionColor: bgColor.isDark
                  ? Colors.blueAccent.withOpacity(0.5)
                  : Colors.blue.withOpacity(0.36),
            ),
            child: ObsBuilder(builder: (context) {
              return Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: lineNumWidth.value),
                constraints: widget.maxHeight != null
                    ? BoxConstraints(
                        minWidth: double.infinity,
                        maxWidth: double.infinity,
                        minHeight: 0.0,
                        maxHeight: widget.maxHeight!,
                      )
                    : null,
                child: NestScrollWrapper(
                  controller: verticalController,
                  child: ElScrollbar(
                    controller: verticalController,
                    mode: ElScrollbarMode.always,
                    child: ElScrollbar(
                      mode: ElScrollbarMode.always,
                      controller: horizontalController,
                      notificationPredicate: (notify) => notify.depth == 1,
                      child: SingleChildScrollView(
                        controller: verticalController,
                        child: SelectionArea(
                          child: SingleChildScrollView(
                            controller: horizontalController,
                            scrollDirection: Axis.horizontal,
                            child: Container(
                              padding: _padding,
                              child: ObsBuilder(builder: (context) {
                                return ElText(
                                  code.value,
                                  softWrap: false,
                                  style: textStyle,
                                  strutStyle: _codeStrutStyle,
                                );
                              }),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ).noScrollBehavior,
              );
            }),
          ),
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: buildLineNum(),
          ),
          Positioned(
            top: 5,
            right: 10,
            child: buildCopyButton(),
          ),
        ],
      ),
    );
  }

  Widget buildLineNum() {
    final numLines = '\n'.allMatches(widget.code).length + 1;

    nextTick(() {
      lineNumWidth.value = lineNumKey.currentContext!.size!.width;
    });
    return IgnorePointer(
      child: Container(
        key: lineNumKey,
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
        child: SingleChildScrollView(
          controller: lineNumController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(
              numLines,
              (index) => ElText(
                '${index + 1}',
                textAlign: TextAlign.right,
                style: textStyle.copyWith(
                  color: context.elTheme.textTheme.secondaryStyle.color,
                ),
                strutStyle: _codeStrutStyle,
              ),
            ),
          ),
        ).noScrollBehavior,
      ),
    );
  }

  Widget buildCopyButton() {
    return Material(
      borderRadius: context.commonSizePreset.radius,
      color: bgColor.isDark ? Colors.grey.shade700 : Colors.grey.shade300,
      child: InkWell(
        onTap: () async {
          await Clipboard.setData(ClipboardData(text: widget.code));
          el.message.success('复制成功');
        },
        borderRadius: context.commonSizePreset.radius,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ElIcon(
            ElIcons.documentCopy,
            color: bgColor.isDark ? Colors.grey.shade300 : Colors.grey.shade700,
            size: 14,
          ),
        ),
      ),
    );
  }
}
