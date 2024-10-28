import 'package:element_docs/global.dart';
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
              color:
                  context.isDark ? Colors.grey.shade300 : Colors.grey.shade800,
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
    this.type = El.primary,
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
        ElTextTheme.merge(
          data: const ElTextThemeData(
            style: TextStyle(
              fontFamily: MyFonts.consolas,
              fontSize: 14,
            ),
          ),
          child: AnimatedContainer(
            duration: context.elDuration(),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 20,
            ),
            decoration: BoxDecoration(
              color: context.elThemeColors[type]!.elLight9(context),
              borderRadius: context.elTheme.cardTheme.radius,
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
            width: context.elTheme.cardTheme.radius.bottomLeft.x,
            decoration: BoxDecoration(
              color: context.elThemeColors[type],
              borderRadius: BorderRadius.only(
                topLeft: context.elTheme.cardTheme.radius.topLeft,
                bottomLeft: context.elTheme.cardTheme.radius.bottomLeft,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class FlutterHookTip extends StatelessWidget {
  const FlutterHookTip(this.name,{super.key});

  final String name;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Tip',
      content: [
        ElText([
          '$name 支持双向绑定，推荐你使用 ',
          const FlutterHookLink(),
          ' 代替 StatefulWidget',
        ]),
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
