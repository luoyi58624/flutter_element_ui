import 'package:docs/global.dart';
import 'package:flutter/material.dart';

class CodeExampleWidget extends HookWidget {
  /// 代码示例小部件，
  const CodeExampleWidget({
    super.key,
    required this.code,
    required this.children,
    this.expanded = false,
  });

  /// 示例代码字符串，代码展示效果基于第三方库：[syntax_highlight]
  final String code;

  /// 效果预览
  final List<Widget> children;

  /// 是否默认展开代码示例，默认false
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(expanded);

    return ElHoverBuilder(builder: (context) {
      return RepaintBoundary(
        child: Card(
          elevation: 0,
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
                  child: CodePreviewWidget(
                    code: code,
                    borderRadius: BorderRadius.only(
                      bottomLeft: context.elTheme.cardStyle.radius.bottomLeft,
                      bottomRight: context.elTheme.cardStyle.radius.bottomRight,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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
