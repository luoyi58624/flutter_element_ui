import 'package:docs/global.dart';
import 'package:flutter/material.dart';

class FlatCodeExample extends StatelessWidget {
  /// 左右平铺代码示例，注意代码量不要太多
  const FlatCodeExample({
    super.key,
    required this.code,
    required this.child,
    this.noBorderRadius = false,
  });

  /// 示例代码字符串
  final String code;

  /// 效果预览小部件
  final Widget child;

  final bool noBorderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: noBorderRadius
            ? BorderRadius.zero
            : context.elTheme.cardStyle.radius,
        border: Border.all(
          color: context.elTheme.colors.border,
          width: 1,
        ),
      ),
      child: context.sm ? mobileLayout(context) : desktopLayout(context),
    );
  }

  Widget desktopLayout(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: CodePreview(
              code: code,
              height: double.infinity,
              borderRadius: noBorderRadius
                  ? BorderRadius.zero
                  : BorderRadius.only(
                      topLeft: context.elTheme.cardStyle.radius.topLeft,
                      bottomLeft: context.elTheme.cardStyle.radius.bottomLeft,
                    ),
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }

  Widget mobileLayout(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            child: CodePreview(
              code: code,
              height: double.infinity,
              borderRadius: BorderRadius.only(
                topLeft: context.elTheme.cardStyle.radius.topLeft,
                bottomLeft: context.elTheme.cardStyle.radius.bottomLeft,
              ),
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
