import 'package:docs/global.dart';
import 'package:flutter/material.dart';

/// 标题间距
const Widget titleGap = Gap(36);

/// 普通文字间距
const Widget textGap = Gap(20);

class SectionTitle extends StatelessWidget {
  /// 段落标题
  const SectionTitle(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        titleGap,
        H2(
          title,
          style: TextStyle(
            color: context.isDark ? Colors.grey.shade300 : Colors.grey.shade800,
          ),
        ),
        textGap,
      ],
    );
  }
}

class SectionText extends StatelessWidget {
  /// 段落文本
  const SectionText(this.text, {super.key});

  final dynamic text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElText(text),
      ],
    );
  }
}
