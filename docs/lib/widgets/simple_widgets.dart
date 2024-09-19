import 'package:docs/global.dart';
import 'package:flutter/material.dart';

/// 标题间距
const Widget titleGap = Gap(36);

/// 普通文字间距
const Widget textGap = Gap(20);

class SectionTitle extends StatelessWidget {
  /// 段落标题，只能用于 [ResponsivePage] 页面中
  const SectionTitle(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        titleGap,
        // ElLink(
        //   href: '${ResponsivePageData.of(context).path}#$title',
        //   child: ElAnchor(
        //     name: title,
        //     child: H2(
        //       title,
        //       style: TextStyle(
        //         color: context.isDark
        //             ? Colors.grey.shade300
        //             : Colors.grey.shade800,
        //       ),
        //     ),
        //   ),
        // ),
        ElAnchor(
          name: title,
          child: H2(
            title,
            style: TextStyle(
              color: context.isDark
                  ? Colors.grey.shade300
                  : Colors.grey.shade800,
            ),
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

class SectionCard extends StatelessWidget {
  const SectionCard({
    super.key,
    this.type = 'primary',
    required this.title,
    required this.content,
  });

  final String type;
  final String title;
  final List<dynamic> content;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ElDefaultTextStyle.merge(
          style: const TextStyle(
            fontFamily: MyFonts.consolas,
            fontSize: 14,
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 20,
            ),
            decoration: BoxDecoration(
              color: context.elThemeColors[type]!.elLight9(context),
              borderRadius: context.elTheme.cardStyle.radius,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                H4(title),
                const Gap(8),
                ...content.map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: e is Widget ? e : ElText(e),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 0,
          top: 0,
          bottom: 0,
          child: Container(
            width: context.elTheme.cardStyle.radius.bottomLeft.x,
            decoration: BoxDecoration(
              color: context.elThemeColors[type],
              borderRadius: BorderRadius.only(
                topLeft: context.elTheme.cardStyle.radius.topLeft,
                bottomLeft: context.elTheme.cardStyle.radius.bottomLeft,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class FlutterHookLink extends StatelessWidget {
  const FlutterHookLink({super.key});

  @override
  Widget build(BuildContext context) {
    return const ElLink(
      href: 'https://pub.dev/packages/flutter_hooks',
      child: 'flutter_hooks',
    );
  }
}
