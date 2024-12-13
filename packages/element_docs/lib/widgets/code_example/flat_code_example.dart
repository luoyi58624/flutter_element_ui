import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

class FlatCodeExample extends StatelessWidget {
  /// 左右平铺代码示例，注意代码量不要太多
  const FlatCodeExample({
    super.key,
    this.code,
    required this.child,
    this.noBorderRadius = false,
    this.maxHeight = 500,
  });

  /// 示例代码字符串
  final String? code;

  /// 效果预览小部件
  final Widget child;

  final bool noBorderRadius;

  final double maxHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: noBorderRadius
            ? BorderRadius.zero
            : context.commonSizePreset.cardRadius!,
        border: Border.all(
          color: context.elLayout.borderColor!,
          width: 1,
        ),
      ),
      child: context.sm ? mobileLayout(context) : desktopLayout(context),
    );
  }

  Widget desktopLayout(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (code != null)
            Expanded(
              child: CodePreview(
                code: code!,
                maxHeight: maxHeight,
                borderRadius: noBorderRadius
                    ? BorderRadius.zero
                    : BorderRadius.only(
                        topLeft: context.commonSizePreset.cardRadius!.topLeft,
                        bottomLeft:
                            context.commonSizePreset.cardRadius!.bottomLeft,
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
          if (code != null)
            Expanded(
              child: CodePreview(
                code: code!,
                maxHeight: maxHeight,
                borderRadius: BorderRadius.only(
                  topLeft: context.commonSizePreset.cardRadius!.topLeft,
                  bottomLeft: context.commonSizePreset.cardRadius!.bottomLeft,
                ),
              ),
            ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
