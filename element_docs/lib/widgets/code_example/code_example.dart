import 'dart:async';

import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

class CodeExample extends HookWidget {
  /// 代码示例小部件，适用于传统的上下布局结构，上方为组件演示预览，下方为折叠的代码示例
  const CodeExample({
    super.key,
    this.code,
    required this.children,
    this.expanded = false,
  });

  /// 示例代码字符串
  final String? code;

  /// 是否默认展开
  final bool expanded;

  /// 效果预览小部件
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(expanded);

    return HoverBuilder(builder: (context) {
      return Card(
        elevation: 0,
        shadowColor: Colors.black38,
        margin: EdgeInsets.zero,
        color: context.elTheme.bgColor,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: context.elTheme.cardTheme.radius,
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
              if (code != null) const ElDivider(),
              if (code != null) _PreviewButton(isExpanded),
              if (code != null)
                ElCollapseTransition(
                  isExpanded.value,
                  child: ElCodePreview(
                    code: code!,
                    borderRadius: BorderRadius.only(
                      bottomLeft: context.elTheme.cardTheme.radius.bottomLeft,
                      bottomRight: context.elTheme.cardTheme.radius.bottomRight,
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }
}

const _doubleOffset = 80.0;
Timer? _delayShow;

/// 构建展开预览代码按钮
class _PreviewButton extends HookWidget {
  const _PreviewButton(this.isExpanded);

  final ValueNotifier<bool> isExpanded;

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

    return HoverBuilder(
      cursor: SystemMouseCursors.click,
      builder: (context) {
        if (context.isHover) {
          _delayShow = setTimeout(() {
            _delayShow = null;
            controller.forward();
          }, 100);
        } else {
          if (_delayShow != null) {
            _delayShow!.cancel();
            _delayShow = null;
          }
          controller.reverse();
        }
        return GestureDetector(
          onTap: () {
            isExpanded.value = !isExpanded.value;
          },
          child: AnimatedContainer(
            duration:
                context.elDuration(context.elTheme.collapseTheme.duration),
            curve: context.elCurve(context.elTheme.collapseTheme.curve),
            height: 40,
            decoration: BoxDecoration(
                color: context.isHover
                    ? context.elTheme.primary.mix(context.elTheme.bgColor, 96)
                    : context.elTheme.bgColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: isExpanded.value
                      ? Radius.zero
                      : context.elTheme.cardTheme.radius.bottomLeft,
                  bottomRight: isExpanded.value
                      ? Radius.zero
                      : context.elTheme.cardTheme.radius.bottomRight,
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
