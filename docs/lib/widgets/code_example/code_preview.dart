import 'package:docs/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

/// [syntax_highlight] 需要加载 assert 资产包中的代码样式配置文件，这个全局变量表示是否初始化成功
bool _initialize = false;

/// 亮色代码主题
Highlighter? _lightCode;

/// 暗色代码主题
Highlighter? _darkCode;

class CodePreview extends StatefulWidget {
  /// 示例代码预览小部件，展示效果基于第三方库：[syntax_highlight]
  const CodePreview({
    super.key,
    required this.code,
    this.height,
    this.borderRadius,
  });

  /// 示例代码字符串
  final String code;

  final double? height;
  final BorderRadiusGeometry? borderRadius;

  @override
  State<CodePreview> createState() => _CodePreviewState();
}

class _CodePreviewState extends State<CodePreview> {
  final code = Obs(const TextSpan());

  TextStyle get _textStyle => const TextStyle(
        fontFamily: MyFonts.consolas,
        fontSize: 14,
        height: 1.5,
      );

  EdgeInsetsGeometry get _padding => const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      );

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
  Widget build(BuildContext context) {
    return buildCodePreview();
  }

  /// 初始化预览代码样式，全局只加载一次
  void initCodeStyle(BuildContext context) {
    if (_initialize == false || _lightCode == null || _darkCode == null) {
      ElUtils.nextTick(() async {
        await Highlighter.initialize(['dart']);
        _initialize = true;
        // 亮色主题使用默认配置
        var lightCodeTheme = await HighlighterTheme.loadFromAssets(
          [
            'packages/syntax_highlight/themes/light_vs.json',
            'packages/syntax_highlight/themes/light_plus.json',
          ],
          const TextStyle(color: Color(0xFF000088)),
        );
        // 暗色主题使用自定义的配置文件
        var darkCodeTheme = await HighlighterTheme.loadFromAssets(
          [
            'assets/code_themes/dark_vs.json',
            'assets/code_themes/dark_plus.json',
          ],
          const TextStyle(color: Color(0xFFD19A66)),
        );
        _lightCode = Highlighter(language: 'dart', theme: lightCodeTheme);
        _darkCode = Highlighter(language: 'dart', theme: darkCodeTheme);
        if (context.mounted) {
          code.value = (GlobalState.forceDarkCodeExample.value
                  ? _darkCode
                  : (context.isDark ? _darkCode : _lightCode))!
              .highlight(widget.code);
        }
      });
    } else {
      code.value = (GlobalState.forceDarkCodeExample.value
              ? _darkCode
              : (context.isDark ? _darkCode : _lightCode))!
          .highlight(widget.code);
    }
  }

  /// 构建预览代码块
  Widget buildCodePreview() {
    final $bgColor = (GlobalState.forceDarkCodeExample.value
            ? ElApp.of(context).darkTheme.colors.bg
            : context.elTheme.colors.bg)
        .deepen(3);
    return Stack(
      children: [
        TextSelectionTheme(
          data: TextSelectionThemeData(
            selectionColor: $bgColor.isDark
                ? Colors.blueAccent.withOpacity(0.5)
                : Colors.blue.withOpacity(0.36),
          ),
          child: AnimatedContainer(
            duration: context.elConfig.themeDuration,
            width: double.infinity,
            height: widget.height,
            decoration: BoxDecoration(
              color: $bgColor,
              borderRadius:
                  widget.borderRadius ?? context.elTheme.cardStyle.radius,
            ),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  buildLineNum(context, $bgColor),
                  Expanded(child: buildCode()),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 16,
          child: buildCopyButton(context),
        ),
      ],
    );
  }

  Widget buildCode() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ObsBuilder(builder: (context) {
        Widget result = Container(
          padding: _padding,
          child: ObsBuilder(builder: (context) {
            return ElText(
              code.value,
              softWrap: false,
              style: _textStyle,
            );
          }),
        );
        if (GlobalState.enableGlobalTextSelected.value) {
          if (RouterState.isMobile.value == true) {
            return SelectionArea(child: result);
          }
          return result;
        } else {
          return SelectionArea(child: result);
        }
      }),
    );
  }

  Widget buildLineNum(BuildContext context, Color bgColor) {
    final numLines = '\n'.allMatches(widget.code).length + 1;

    return Container(
      height: double.infinity,
      padding: _padding,
      decoration: BoxDecoration(
        color: bgColor,
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
              color: context.elTheme.colors.secondaryText,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCopyButton(BuildContext context) {
    return ElHoverBuilder(
      cursor: SystemMouseCursors.click,
      builder: (context) {
        return GestureDetector(
          onTap: () async {
            await Clipboard.setData(ClipboardData(text: widget.code));
            el.message.success('复制成功');
          },
          onTapDown: (e) {
            HapticFeedback.mediumImpact();
          },
          child: AnimatedContainer(
            duration: context.elThemeDuration ?? 250.ms,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: context.elTheme.cardStyle.radius,
              color:
                  context.isDark ? Colors.grey.shade700 : Colors.grey.shade300,
            ),
            child: ElIcon(
              ElIcons.documentCopy,
              color:
                  context.isDark ? Colors.grey.shade300 : Colors.grey.shade700,
              size: 18,
            ),
          ),
        );
      },
    );
  }
}
