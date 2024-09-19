import 'package:docs/global.dart';
import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

class MyLink extends StatefulWidget {
  const MyLink({super.key});

  @override
  State<MyLink> createState() => _MyLinkState();
}

class _MyLinkState extends State<MyLink> {
  int count = 0;

  late web.HTMLButtonElement button;

  onClick() {
    setState(() {
      count++;
      button.innerText = 'count: $count';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 72,
          height: 24,
          color: Colors.green,
          child: HtmlElementView.fromTagName(
            tagName: 'button',
            onElementCreated: (element) async {
              button = (element as web.HTMLButtonElement)
                ..innerText = 'count: $count';
              button.onClick.listen((e) {
                onClick();
              });
            },
          ),
        ),
        const Gap(8),
      ],
    );
  }
}

