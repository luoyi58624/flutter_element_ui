import 'package:example/global.dart';
import 'package:flutter/material.dart';

class TextPage extends StatelessWidget {
  const TextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ElText('hello'),
        const ElText(false),
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
    );
  }
}
