import 'package:docs/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SectionTitle extends StatelessWidget {
  /// 段落标题
  const SectionTitle(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Gap(28),
        H4(title),
        const Gap(16),
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
    return ElDefaultTextStyle.merge(
      style: const TextStyle(fontSize: 14),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElText(
            text,
          ),
          const Gap(12),
        ],
      ),
    );
  }
}
