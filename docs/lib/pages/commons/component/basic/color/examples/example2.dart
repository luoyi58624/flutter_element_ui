import 'package:docs/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Example2 extends StatelessWidget {
  const Example2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('辅助色'),
        const SectionText('除了主颜色外，您需要在不同的场景中使用不同的场景颜色 (例如，危险的颜色表示危险的操作)'),
        textGap,
        Row(
          children: [
            ...el.themeTypes.whereIndexed((i, v) => i != 0).map(
                  (e) => buildThemeColor(context, e, context.elThemeColors[e]!),
                )
          ],
        ),
      ],
    );
  }

  Widget buildThemeColor(BuildContext context, String title, Color themeColor) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 200,
      ),
      margin: const EdgeInsets.only(right: 8.0),
      decoration: BoxDecoration(
        borderRadius: context.elTheme.cardStyle.radius,
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 100,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 16),
            decoration: BoxDecoration(
              color: themeColor,
            ),
            child: SelectionArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElText(
                    '${title.firstUpperCase} Color',
                    style: TextStyle(
                      color: themeColor.elTextColor(context),
                    ),
                  ),
                  const Gap(4),
                  ElText(
                    themeColor.toHex(),
                    style: TextStyle(
                      fontSize: 0.875.rem(context),
                      color: themeColor.elTextColor(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
