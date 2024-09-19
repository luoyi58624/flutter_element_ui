import 'package:docs/global.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

import 'test.dart';

class NavPage extends ResponsivePage {
  const NavPage({super.key});

  @override
  String get title => '导航';

  @override
  List<Widget> buildPage(BuildContext context) {
    final count = useState(0);

    final disabled = useState(false);
    final loading = useState(false);

    return [
      const Gap(8),
      Link(
        uri: Uri.parse('https://www.baidu.com'),
        builder: (context, open) => ElButton(
          onPressed: () {
            open!();
          },
          type: 'primary',
          child: '链接',
        ),
      ),
      const Gap(8),
      Link(
        uri: Uri.parse('/component/button'),
        builder: (context, open) => ElButton(
          onPressed: () {
            open!();
          },
          type: 'primary',
          child: '按钮页面',
        ),
      ),
      const Gap(8),
      ElButton(
        onPressed: () {
          count.value++;
        },
        child: ElText('count: ${count.value}'),
      ),
      const Gap(8),
    ];
  }
}
