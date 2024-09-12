import 'package:docs/global.dart';
import 'package:flutter/material.dart';

class NavPage extends ResponsivePage {
  const NavPage({super.key});

  @override
  String get title => '导航';

  @override
  List<Widget> buildPage(BuildContext context) {
    final count = useState(0);
    return [
      ElButton(
        onPressed: () {
          count.value++;
        },
        child: ElText('count: ${count.value}'),
      ),
      ElevatedButton(
        onPressed: () {
          count.value++;
        },
        child: Text('count: ${count.value}'),
      ),
      ElButton2(
        onPressed: () {
          count.value++;
        },
        child: ElText('count: ${count.value}'),
      ),
    ];
  }
}
