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
            // const Icon(Icons.home),
            'xxx',
            '呃呃呃',
            const ElText('呃呃呃'),
            const ElText('xxx'),
            // const ElButton(
            //   onPressed: null,
            //   child: 'https://www.baidu.com',
            //   link: true,
            // ),
            // Container(
            //   width: 100,
            //   height: 100,
            //   color: Colors.red,
            // ),
            // WidgetSpan(
            //   child: Container(
            //     width: 100,
            //     height: 100,
            //     color: Colors.green,
            //   ),
            // ),
            const ElText(
              ['呃呃呃', '呃呃呃'],
              style: TextStyle(color: Colors.red),
            ),
          ],
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        const Gap(50),
        DefaultTextStyle(
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          child: Builder(builder: (context) {
            return RichText(
              textWidthBasis: TextWidthBasis.longestLine,
              text: TextSpan(
                text: 'xx',
                style: DefaultTextStyle.of(context).style,
                children: [
                  WidgetSpan(
                    // alignment: PlaceholderAlignment.middle,
                    child: RichText(
                      text: TextSpan(
                        text: 'xx',
                        style: DefaultTextStyle.of(context).style,
                      ),
                    ),
                  ),
                  const TextSpan(
                    text: 'xxx',
                    style: TextStyle(color: Colors.red),
                    children: [
                      TextSpan(text: '罗伊'),
                    ],
                  ),
                  const WidgetSpan(child: Icon(Icons.home)),
                  // WidgetSpan(
                  //   child: Container(
                  //     width: 100,
                  //     height: 100,
                  //     color: Colors.green,
                  //   ),
                  // ),
                  const WidgetSpan(child: Text('陆毅')),
                  const TextSpan(text: '陆毅'),
                  const TextSpan(
                    text: 'hello西南科技安心卡就是你看那就行那可就少女心久啊收纳显卡收纳',
                    style: TextStyle(color: Colors.green),
                    children: [
                      TextSpan(text: '罗伊'),
                    ],
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}
