import 'package:docs/global.dart';
import 'package:docs/pages/commons/responsive_page.dart';
import 'package:flutter/material.dart';

class InstallPage extends ResponsivePage {
  const InstallPage({super.key});

  @override
  String get title => '安装';

  @override
  List<Widget> buildPage(BuildContext context) {
    final count = useState(0);
    final flag = useState(false);
    final d = 500.ms;

    Widget result = Ink(
      decoration: BoxDecoration(
        color: context.isDark ? Colors.grey.shade800 : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(6),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        hoverDuration: 100.ms,
        onTap: () {
          count.value++;
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 8.0,
          ),
          child: ElText(
            'count: ${count.value}',
            style: TextStyle(fontWeight: ElFont.medium, fontSize: 15),
          ),
        ),
      ),
    );
    return [
      result,
      Center(child: ElSwitch(flag)),
      const Gap(50),
      ElButton(
        onPressed: () {
          // el.globalKey.currentContext!.push(ChildPage());
          el.context.push(ChildPage());
        },
        child: '下一页',
      ),
      Container(
        width: 50,
        height: 50,
        color: context.isDark ? Colors.red : Colors.green,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          FadeInLeft(animate: flag.value, duration: d, child: Square()),
          FadeInUp(animate: flag.value, duration: d, child: Square()),
          FadeInDown(animate: flag.value, duration: d, child: Square()),
          FadeInRight(animate: flag.value, duration: d, child: Square()),
        ],
      ),
    ];
  }
}

class Square extends StatelessWidget {
  const Square({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      color: Colors.green,
    );
  }
}
