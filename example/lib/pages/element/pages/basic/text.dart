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
          // const A('百度(显示下划线)', href: 'https://www.baidu.com'),
          // const A(
          //   '百度(禁止下划线)',
          //   href: 'https://www.baidu.com',
          //   underline: false,
          // ),
          // const A(
          //   '百度(悬停时显示下划线)',
          //   href: 'https://www.baidu.com',
          //   hoverUnderline: true,
          // ),
          ElText([
            const H1('一级标题', style: TextStyle(color: Colors.red)),
            const H2('二级标题', style: TextStyle(color: Colors.orange)),
            const H3('三级标题', style: TextStyle(color: Colors.green)),
            const H4('四级标题', style: TextStyle(color: Colors.cyan)),
            const H5('五级标题', style: TextStyle(color: Colors.purple)),
            const H6('六级标题', style: TextStyle(color: Colors.grey)),
            // const WidgetSpan(
            //   alignment: PlaceholderAlignment.middle,
            //   child: H6('六级标题', style: TextStyle(color: Colors.grey)),
            // ),
            // H6('六级标题', style: TextStyle(color: Colors.grey)),
            ElText(
              '普通文本 - count: ${count.value}',
              style: const TextStyle(color: Colors.indigoAccent),
              onTap: () {
                count.value++;
              },
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
        const Icon(Icons.home),
        const TextSpan(
          text: '垂直居中',
          style: TextStyle(color: Colors.green),
        ),
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Container(
            width: 100,
            height: 100,
            color: Colors.green,
          ),
        ),
        const TextSpan(
          text: '底部对齐',
          style: TextStyle(color: Colors.red),
        ),
        Container(
          width: 100,
          height: 100,
          color: Colors.red,
        ),
        'xxx',
        // const A(
        //   'https://www.baidu.com',
        //   href: 'https://www.baidu.com',
        //   // hoverUnderline: true,
        // ),
        '呃呃呃',
        const ElText('呃呃呃'),
        const ElText('xxx'),
        const ElButton(
          onPressed: null,
          child: 'https://www.baidu.com',
          link: true,
        ),
        const ElText(
          ['呃呃呃', '呃呃呃'],
          style: TextStyle(color: Colors.red),
        ),
      ],
      style: const TextStyle(fontWeight: FontWeight.w500),
    );
  }
}
