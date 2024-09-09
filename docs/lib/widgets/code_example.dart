import 'package:docs/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

bool _initialize = false;
Highlighter? _lightCode;
Highlighter? _darkCode;

class CodeExampleWidget extends HookWidget {
  const CodeExampleWidget({
    super.key,
    required this.code,
    required this.children,
  });

  final String code;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final $code = useState<TextSpan>(const TextSpan());
    final isExpanded = useState(false);
    initCodeStyle(context, $code);
    return HoverBuilder(builder: (context) {
      return Material(
        elevation: context.isHover ? 4 : 0,
        shadowColor: Colors.black38,
        borderRadius: context.elTheme.cardStyle.radius,
        child: AnimatedContainer(
          duration: context.elConfig.themeDuration,
          decoration: BoxDecoration(
            color: context.elTheme.bgColor,
            borderRadius: context.elTheme.cardStyle.radius,
            border: Border.all(
              color: context.elTheme.borderColor,
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
              buildCodePreview(isExpanded, $code),
            ],
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
        var lightCodeTheme = await HighlighterTheme.loadFromAssets(
          [
            'packages/syntax_highlight/themes/light_vs.json',
            'packages/syntax_highlight/themes/light_plus.json',
          ],
          const TextStyle(color: Color(0xFF000088)),
        );
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
          $code.value =
              (el.isDark ? _darkCode : _lightCode)!.highlight(code);
        }
      });
    } else {
      $code.value = (el.isDark ? _darkCode : _lightCode)!.highlight(code);
    }
  }

  /// 构建预览代码块
  Widget buildCodePreview(isExpanded, $code) {
    return ElCollapseTransition(
      isExpanded.value,
      child: HoverBuilder(builder: (context) {
        return Stack(
          children: [
            AnimatedContainer(
              duration: context.elConfig.themeDuration,
              width: double.infinity,
              decoration: BoxDecoration(
                color: context.elTheme.bgColor.deepen(3),
                borderRadius: BorderRadius.only(
                  bottomLeft: context.elTheme.cardStyle.radius.bottomLeft,
                  bottomRight: context.elTheme.cardStyle.radius.bottomRight,
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
                        fontFamily: 'Consolas',
                        fontSize: 14,
                      ),
                    ),
                  );
                  if (GlobalState.enableGlobalTextSelected.value) {
                    if (RouterUtil.isMobile.value == true) {
                      return SelectionArea(child: result);
                    }
                    return result;
                  } else {
                    return SelectionArea(child: result);
                  }
                }),
              ),
            ),
            Positioned(
              top: 10,
              right: 16,
              child: AnimatedOpacity(
                duration: 200.ms,
                opacity: context.isHover ? 1.0 : 0.0,
                child: HoverBuilder(
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
                          color: el.isDark
                              ? Colors.grey.shade700
                              : Colors.grey.shade300,
                        ),
                        child: ElIcon(
                          ElIcons.documentCopy,
                          color: el.isDark
                              ? Colors.grey.shade300
                              : Colors.grey.shade700,
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        );
      }),
    );
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
    final controller =
        useAnimationController(duration: 250.ms);
    final curve = CurvedAnimation(
      parent: controller,
      curve: Curves.easeOut,
    );
    final iconColorAnimate = ColorTween(
      begin: el.isDark ? Colors.grey.shade600 : Colors.grey.shade300,
      end: context.elTheme.primary,
    ).animate(curve);
    final offsetAnimate = Tween(
      begin: _doubleOffset / 2,
      end: 0.0,
    ).animate(curve);

    return HoverBuilder(
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
                    ? context.elTheme.primary.mix(context.elTheme.bgColor, 96)
                    : context.elTheme.bgColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: context.elTheme.cardStyle.radius.bottomLeft,
                  bottomRight: context.elTheme.cardStyle.radius.bottomRight,
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
