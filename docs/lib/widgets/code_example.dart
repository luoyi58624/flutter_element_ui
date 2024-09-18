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

class CodeExampleWidget extends HookWidget {
  /// 代码示例小部件
  const CodeExampleWidget({
    super.key,
    required this.code,
    required this.children,
    this.expanded = false,
  }) : _onlyCode = false;

  /// 仅展示代码
  const CodeExampleWidget.code({
    super.key,
    required this.code,
    this.expanded = false,
  })  : _onlyCode = true,
        children = const [];

  final bool _onlyCode;

  /// 示例代码字符串，代码展示效果基于第三方库：[syntax_highlight]
  final String code;

  /// 效果预览
  final List<Widget> children;

  /// 是否默认展开代码示例，默认false
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final $code = useState<TextSpan>(const TextSpan());
    final isExpanded = useState(expanded);
    initCodeStyle(context, $code);
    return ElHoverBuilder(builder: (context) {
      return _onlyCode
          ? buildCodePreview($code)
          : RepaintBoundary(
              child: Card(
                elevation: context.isHover ? 4 : 0,
                shadowColor: Colors.black38,
                margin: EdgeInsets.zero,
                // color: context.elTheme.colors.bg,
                child: AnimatedContainer(
                  duration: context.elConfig.themeDuration,
                  decoration: BoxDecoration(
                    borderRadius: context.elTheme.cardStyle.radius,
                    border: Border.all(
                      color: context.elTheme.colors.border,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: children,
                        ),
                      ),
                      const ElDivider(),
                      _PreviewButton(isExpanded, context.isHover),
                      ElCollapseTransition(
                        isExpanded.value,
                        child: buildCodePreview($code),
                      ),
                    ],
                  ),
                ),
              ),
            );
    });
  }

  /// 初始化预览代码样式，全局只加载一次
  void initCodeStyle(BuildContext context, $code) {
    if (_initialize == false || _lightCode == null || _darkCode == null) {
      FlutterUtil.nextTick(() async {
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
          $code.value = (GlobalState.forceDarkCodeExample.value
                  ? _darkCode
                  : (context.isDark ? _darkCode : _lightCode))!
              .highlight(code);
        }
      });
    } else {
      $code.value = (GlobalState.forceDarkCodeExample.value
              ? _darkCode
              : (context.isDark ? _darkCode : _lightCode))!
          .highlight(code);
    }
  }

  /// 构建预览代码块
  Widget buildCodePreview($code) {
    return ElHoverBuilder(builder: (context) {
      final $bgColor = (GlobalState.forceDarkCodeExample.value
              ? ElApp.of(context).darkTheme.colors.bg
              : context.elTheme.colors.bg)
          .deepen(3);
      return Stack(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(
                // 固定最大高度在桌面端滚动体验不太好，暂时隐藏
                // maxHeight: 500,
                ),
            child: TextSelectionTheme(
              data: TextSelectionThemeData(
                selectionColor: $bgColor.isDark
                    ? Colors.blueAccent.withOpacity(0.5)
                    : Colors.blue.withOpacity(0.36),
              ),
              child: SingleChildScrollView(
                child: AnimatedContainer(
                  duration: context.elConfig.themeDuration,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: $bgColor,
                    borderRadius: _onlyCode
                        ? context.elTheme.cardStyle.radius
                        : BorderRadius.only(
                            bottomLeft:
                                context.elTheme.cardStyle.radius.bottomLeft,
                            bottomRight:
                                context.elTheme.cardStyle.radius.bottomRight,
                          ),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ObsBuilder(builder: (context) {
                      Widget result = Container(
                        padding: const EdgeInsets.all(16),
                        child: ElText(
                          $code.value,
                          softWrap: false,
                          style: const TextStyle(
                            fontFamily: MyFonts.consolas,
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
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
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 16,
            child: AnimatedOpacity(
              duration: 200.ms,
              opacity: PlatformUtil.isMobile || context.isHover ? 1.0 : 0.0,
              child: ElHoverBuilder(
                cursor: SystemMouseCursors.click,
                builder: (context) {
                  return GestureDetector(
                    onTap: () async {
                      await Clipboard.setData(ClipboardData(text: code));
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
                        color: context.isDark
                            ? Colors.grey.shade700
                            : Colors.grey.shade300,
                      ),
                      child: ElIcon(
                        ElIcons.documentCopy,
                        color: context.isDark
                            ? Colors.grey.shade300
                            : Colors.grey.shade700,
                        size: 18,
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      );
    });
  }
}

const _doubleOffset = 80.0;

/// 构建展开预览代码按钮
class _PreviewButton extends HookWidget {
  const _PreviewButton(this.isExpanded, this.codeHover);

  final ValueNotifier<bool> isExpanded;
  final bool codeHover;

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(duration: 250.ms);
    final curve = CurvedAnimation(
      parent: controller,
      curve: Curves.easeOut,
    );
    final iconColorAnimate = ColorTween(
      begin: context.isDark ? Colors.grey.shade600 : Colors.grey.shade300,
      end: context.elTheme.primary,
    ).animate(curve);
    final offsetAnimate = Tween(
      begin: _doubleOffset / 2,
      end: 0.0,
    ).animate(curve);

    return ElHoverBuilder(
      cursor: SystemMouseCursors.click,
      builder: (context) {
        codeHover ? controller.forward() : controller.reverse();
        return GestureDetector(
          onTap: () {
            isExpanded.value = !isExpanded.value;
          },
          child: AnimatedContainer(
            duration: context.elThemeDuration ??
                context.elTheme.collapseStyle.duration,
            curve: context.elThemeCurve ?? context.elTheme.collapseStyle.curve,
            height: 40,
            decoration: BoxDecoration(
                color: context.isHover
                    ? context.elTheme.primary.mix(context.elTheme.colors.bg, 96)
                    : context.elTheme.colors.bg,
                borderRadius: BorderRadius.only(
                  bottomLeft: isExpanded.value
                      ? Radius.zero
                      : context.elTheme.cardStyle.radius.bottomLeft,
                  bottomRight: isExpanded.value
                      ? Radius.zero
                      : context.elTheme.cardStyle.radius.bottomRight,
                )),
            alignment: Alignment.center,
            child: AnimatedBuilder(
              animation: controller.view,
              builder: (context, child) => Transform.translate(
                offset: Offset(offsetAnimate.value, 0),
                child: SizedBox(
                  width: _doubleOffset,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AnimatedRotation(
                        duration: 300.ms,
                        turns: isExpanded.value ? 0.5 : 0,
                        child: ElTriangle(
                          direction: AxisDirection.down,
                          color: iconColorAnimate.value,
                        ),
                      ),
                      const Gap(8),
                      Opacity(
                        opacity: controller.value,
                        child: AnimatedSwitcher(
                          duration: 150.ms,
                          child: ElText(
                            isExpanded.value ? '隐藏代码' : '查看代码',
                            key: ValueKey(isExpanded.value),
                            style: TextStyle(
                              fontSize: 14,
                              color: context.elTheme.primary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
