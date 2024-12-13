import 'package:element_docs/global.dart';
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
              '因为 Element Plus 官方使用 Svg 作为图标，如果要在 Flutter 中应用 Svg 则'
                  '需要额外引入 flutter_svg 这个第三方包，而且打包时图标不会剔除未使用的图标，'
                  '所以这里的图标是基于 ',
              ElLink(
                href: 'https://element.eleme.io/#/zh-CN/component/icon',
                child: 'Element UI',
              ),
              ' 的字体图标，图标素材来自 ',
              ElLink(
                href:
                    'https://www.iconfont.cn/collections/detail?spm=a313x.collections_index.i1.d9df05512.74d73a81YpH5vp&cid=21385',
                child: 'iconfont',
              ),
            ]),
          ],
        ),
        textGap,
        ElIconTheme(
          data: ElIconThemeData(
            size: 28,
            color: context.elTheme.iconTheme.color,
          ),
          child: GridWidget(
            size: 125,
            itemCount: ElIcons.values.length,
            borderColor: context.elLayout.borderColor!,
            borderRadius: context.commonSizePreset.cardRadius!,
            shrinkWrap: true,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                CommonUtil.copy(
                  'ElIcon(ElIcons.${keys[index]})',
                  'ElIcon(ElIcons.${keys[index]})',
                );
              },
              child: ElEvent(
                cursor: SystemMouseCursors.click,
                behavior: HitTestBehavior.opaque,
                builder: (context) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElIcon(
                          ElIcons.values[keys[index]],
                          color:
                              context.hasHover ? context.elTheme.primary : null,
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
                              color: context.hasHover
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
        ),
      ],
    );
  }
}
