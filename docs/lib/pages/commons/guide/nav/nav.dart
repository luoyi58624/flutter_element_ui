import 'package:docs/global.dart';
import 'package:flutter/material.dart';

import '../../responsive_page.dart';

class NavPage extends ResponsivePage {
  const NavPage({super.key});

  @override
  String get title => '导航';

  @override
  List<Widget> buildPage(BuildContext context) {
    final flag1 = useState(true);
    final flag2 = useState(false);
    return [
      ElSwitch(flag1),
      ElCollapse(
        flag1,
        alignment: Alignment.center,
        child: Container(
          width: 300,
          child: Text(str),
        ),
      ),
      ElSwitch(flag2),
      ElCollapse2(
        value: flag2.value,
        alignment: Alignment.topLeft,
        child: Container(
          width: 300,
          child: Text(str),
        ),
      ),
      const Text('text'),
      // AnimatedContainer(
      //   duration: 300.ms,
      //   color: Colors.grey,
      //   child: flag.value ? Text('data' * 10) : Text('data' * 100),
      // ),
      ExpansionTile(
        title: Text('hello'),
        children: [
          Text(str),
        ],
      ),
    ];
  }
}

String str =
    '商业平台学院是百度商业体系最大的前端团队，所在部门主要负责百度核心商业产品推广平台的建设，包括搜索推广和信息流推广，是公司绝大部分收入的来源。学院不仅提供Web前端、还有iOS、Android方向供大家学习。商业平台学院欢迎你的到来！';
