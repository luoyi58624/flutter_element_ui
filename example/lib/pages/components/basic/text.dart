import 'package:example/global.dart';
import 'package:flutter/material.dart';

class TextPage extends StatelessWidget {
  const TextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const H1('一级标题'),
            const H2('二级标题'),
            const H3('三级标题'),
            const H4('四级标题'),
            const H5('五级标题'),
            const H6('六级标题'),
            const ElText('普通文本'),
            const ElText(false),
            const ElText(
              '嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻',
              overflow: TextOverflow.ellipsis,
            ),
            const H1(
              [
                '一级标题',
                H2('二级标题'),
                H3('三级标题'),
                H4('四级标题'),
                H5('五级标题'),
                H6('六级标题'),
                ElText('普通文本'),
              ],
              style: TextStyle(color: Colors.red),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            ElText(
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
                const TextSpan(
                  text: 'ccc',
                  style: TextStyle(color: Colors.green),
                ),
                const H1(
                  '一级标题',
                  style: TextStyle(color: Colors.red),
                ),
                const Icon(Icons.home),
                'xxx',
                '呃呃呃',
                const ElText('呃呃呃'),
                const ElText('xxx'),
                const ElText(
                  ['呃呃呃', '呃呃呃'],
                  style: TextStyle(color: Colors.red),
                ),
                const ElButton(
                  onPressed: null,
                  child: 'https://www.baidu.com',
                  link: true,
                ),
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.red,
                ),
                WidgetSpan(
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.green,
                  ),
                ),
              ],
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
