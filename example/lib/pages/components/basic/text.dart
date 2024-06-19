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
            const WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Text('xxx'),
            ),
            const ElText(
              ['xxx', 'ccc'],
              style: TextStyle(color: Colors.red),
            ),
            const TextSpan(
              text: 'xxx',
              style: TextStyle(color: Colors.green),
            ),
            const TextSpan(
              text: '富文本',
              style: TextStyle(color: Colors.green),
            ),
            const Icon(Icons.home),
            'demo',
            '呃呃呃',
            const ElText('呃呃呃'),
            const ElText('xxx'),
            const ElButton(
              onPressed: null,
              child: 'https://www.baidu.com',
              link: true,
            ),
            // Container(
            //   width: 100,
            //   height: 100,
            //   color: Colors.green,
            // ),
            WidgetSpan(
              child: Container(
                // width: 100,
                // height: 100,
                color: Colors.green,
              ),
            ),
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
                    text: 'hello西南科技安心卡就是你看那就行那可就少女心久啊收纳显卡收纳',
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
