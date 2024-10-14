import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

class Example2 extends StatelessWidget {
  const Example2({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title),
        const SectionText('除了主颜色外，您需要在不同的场景中使用不同的场景颜色 (例如，危险的颜色表示危险的操作)'),
        textGap,
        FlatCodeExample(
          // code: code,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ...El.themeTypes.whereIndexed((i, v) => i != 0).map(
                        (e) => buildThemeColor(
                            context, e, context.elThemeColors[e]!),
                      )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildThemeColor(BuildContext context, String title, Color themeColor) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 160,
      ),
      margin: const EdgeInsets.only(right: 8.0),
      decoration: BoxDecoration(
        borderRadius: context.elTheme.cardTheme.radius,
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 75,
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
                    themeColor.toHex().toUpperCase(),
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

String get code => '''
context.elTheme.success;
context.elTheme.info;
context.elTheme.warning;
context.elTheme.error;''';
