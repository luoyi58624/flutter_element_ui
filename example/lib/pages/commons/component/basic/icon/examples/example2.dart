import 'package:example/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Example2 extends StatelessWidget {
  const Example2({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final keys = ElIcons.values.keys.toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title),
        const SectionCard(
          type: 'warning',
          title: 'Warning',
          content: [
            ElText([
              '这里的图标基于 ',
              ElLink(
                href: 'https://element.eleme.io/#/zh-CN/component/icon',
                child: 'Element UI',
              ),
              '，而不是 Element Plus，图标素材来自 ',
              ElLink(
                href:
                    'https://www.iconfont.cn/collections/detail?spm=a313x.collections_index.i1.d9df05512.74d73a81YpH5vp&cid=21385',
                child: 'iconfont',
              ),
            ]),
          ],
        ),
        textGap,
        ElGridWidget(
          size: 125,
          itemCount: ElIcons.values.length,
          borderColor: context.elTheme.colors.border,
          borderRadius: context.elTheme.cardTheme.radius,
          shrinkWrap: true,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              CommonUtil.copy('ElIcon(ElIcons.${keys[index]})');
            },
            child: HoverBuilder(
              cursor: SystemMouseCursors.click,
              builder: (context) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElIcon(
                        ElIcons.values[keys[index]],
                        color:
                            context.isHover ? context.elTheme.primary : null,
                      ),
                      const Gap(16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ElText(
                          keys[index],
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
        ),
      ],
    );
  }
}


