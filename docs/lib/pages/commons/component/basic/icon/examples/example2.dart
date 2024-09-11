import 'package:docs/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Example2 extends StatelessWidget {
  const Example2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('图标集合'),
        ElIconTheme(
          size: 2.rem(context),
          child: LayoutBuilder(builder: (context, constraints) {
            final sumCount = ElIcons.values.length;
            final rowCount = (constraints.maxWidth / 125).floor();
            // 禁止绘制底部边框的网格索引值
            int bottomBorderIndex = sumCount % rowCount;
            bottomBorderIndex = sumCount -
                (bottomBorderIndex == 0 ? rowCount : bottomBorderIndex);
            final defaultBorder = BorderSide(
              color: context.elTheme.borderColor,
            );
            return DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: context.elTheme.cardStyle.radius,
                border: Border.all(
                  color: context.elTheme.borderColor,
                ),
              ),
              child: GridView.count(
                  crossAxisCount: rowCount,
                  shrinkWrap: true,
                  children: ElIcons.values.keys.mapIndexed(
                    (index, key) {
                      BorderSide rightBorder = BorderSide.none;
                      BorderSide bottomBorder = BorderSide.none;
                      if (index % rowCount != rowCount - 1) {
                        rightBorder = defaultBorder;
                      }
                      if (index < bottomBorderIndex) {
                        bottomBorder = defaultBorder;
                      }
                      return Container(
                        decoration: BoxDecoration(
                          border: Border(
                            right: rightBorder,
                            bottom: bottomBorder,
                          ),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            CommonUtil.copy('ElIcon(ElIcons.$key)');
                          },
                          child: ElHoverBuilder(
                            cursor: SystemMouseCursors.click,
                            builder: (context) {
                              return Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ElIcon(
                                      ElIcons.values[key],
                                      color: context.isHover
                                          ? context.elTheme.primary
                                          : null,
                                    ),
                                    const Gap(16),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: ElText(
                                        key,
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: context.isHover
                                              ? context.elTheme.primary
                                              : null,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ).toList()),
            );
          }),
        ),
      ],
    );
  }
}
