import 'package:example/global.dart';
import 'package:flutter/material.dart';

class TextPage extends StatelessWidget {
  const TextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SelectionArea(child: test1()),
          const Gap(16),
          const H3('==============================='),
          const H3('=========上方可选中文本==========='),
          const H3('================================'),
          const Gap(16),
          test2(),
        ],
      ),
    );
  }

  Widget test1() {
    final count = Obs(0);
    return ObsBuilder(builder: (context) {
      return Column(
        children: [
          const H1('一级标题 (H1)'),
          const H2('二级标题 (H2)'),
          const H3('三级标题 (H3)'),
          const H4('四级标题 (H4)'),
          const H5('五级标题 (H5)'),
          const H6('六级标题 (H6)'),
          const ElText('普通文本 (ElText)'),
          const Text('普通文本 (Text)'),
          ElLink(
            child: '百度',
            href: 'https://www.baidu.com',
            color: context.elTheme.textColor,
            decoration: ElLinkDecoration.underline,
          ),
          ElLink(
            child: 'Flutter官方',
            href: 'https://flutter.cn/',
            color: context.elTheme.textColor,
          ),
          ElLink(
            child: 'Bing',
            href: 'https://www.bing.com/?mkt=zh-CN&FORM=BEHPTB&mkt=zh-CN',
            color: context.elTheme.textColor,
            decoration: ElLinkDecoration.hoverUnderline,
          ),
          ElText([
            const H1('一级标题', style: TextStyle(color: Colors.red)),
            const H2('二级标题', style: TextStyle(color: Colors.orange)),
            const H3('三级标题', style: TextStyle(color: Colors.green)),
            const H4('四级标题', style: TextStyle(color: Colors.cyan)),
            const H5('五级标题', style: TextStyle(color: Colors.purple)),
            const H6('六级标题', style: TextStyle(color: Colors.grey)),
            const SizedBox(width: 20),
            '设置20像素间隔',
            const SizedBox(width: 20),
            ElLink(
              href: 'https://www.bing.com',
              child: ElButton(
                onPressed: () {
                  launchUrl(Uri.parse('https://www.bing.com'));
                },
                type: 'primary',
                child: '超链接按钮',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                count.value++;
              },
              child: ElText(
                '普通文本 - count: ${count.value}',
                style: const TextStyle(color: Colors.indigoAccent),
              ),
            ),
          ]),
        ],
      );
    });
  }

  Widget test2() {
    return ElText(
      [
        'xxx',
        '富文本',
        'xxx',
        const TextSpan(
          text: 'xxx',
          style: TextStyle(color: Colors.green),
        ),
        const ElText(
          'xxx',
          style: TextStyle(color: Colors.red),
        ),
        const ElText(
          ['xxx', '富文本', 'ccc'],
          style: TextStyle(color: Colors.blue),
        ),
        const WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Icon(Icons.home),
        ),
        // WidgetSpan(
        //   alignment: PlaceholderAlignment.middle,
        //   child: Container(
        //     width: 100,
        //     height: 100,
        //     color: Colors.green,
        //   ),
        // ),
        // WidgetSpan(
        //   alignment: PlaceholderAlignment.baseline,
        //   baseline: TextBaseline.alphabetic,
        //   child: Container(
        //     width: 100,
        //     height: 100,
        //     color: Colors.green,
        //   ),
        // ),
        // Container(
        //   width: 100,
        //   height: 100,
        //   color: Colors.red,
        // ),
        'xxx',
        WidgetSpan(
          alignment: PlaceholderAlignment.baseline,
          baseline: TextBaseline.alphabetic,
          child: ElHoverBuilder(builder: (context) {
            return ElText(
              'xxx',
              style: TextStyle(
                color: ElHoverBuilder.of(context) ? Colors.red : null,
              ),
            );
          }),
        ),
        'xxx',
        const ElLink(
          child: 'https://www.baidu.com',
          href: 'https://www.baidu.com',
        ),
        const ElButton(
          onPressed: null,
          link: true,
          child: ElLink(
            child: 'https://www.bing.com',
            href: 'https://www.bing.com',
          ),
        ),
        const ElButton(
          onPressed: null,
          link: true,
          child: H1('百度'),
        ),
        const ElButton(
          onPressed: null,
          link: true,
          child: H2('百度'),
        ),
        const ElButton(
          onPressed: null,
          link: true,
          child: H3('百度'),
        ),
        const ElButton(
          onPressed: null,
          link: true,
          child: H4('百度'),
        ),
        const ElButton(
          onPressed: null,
          link: true,
          child: H5('百度'),
        ),
        const ElButton(
          onPressed: null,
          link: true,
          child: H6('百度'),
        ),
        const ElButton(
          onPressed: null,
          child: '百度',
          link: true,
        ),
        // WidgetSpan(
        //   child: const ElButton(
        //     onPressed: null,
        //     child: '百度',
        //     link: true,
        //   ),
        // ),
        const ElText(
          ['呃呃呃', '呃呃呃'],
          style: TextStyle(color: Colors.red),
        ),
      ],
      style: const TextStyle(fontWeight: FontWeight.w500),
    );
  }
}
