import 'package:docs/global.dart';
import 'package:flutter/material.dart';

import '../../responsive_page.dart';

class NavPage extends ResponsivePage {
  const NavPage({super.key});

  @override
  String get title => '导航';

  @override
  List<Widget> buildPage(BuildContext context) {
    final flag = useState(true);
    return [
      ElSwitch(flag),
      ElCollapse(
        flag.value,
        child: SizedBox(
          child: ElText(str),
        ),
      ),
      ExpansionTile(
        title: Text('hello'),
        children: [
          ElText(str),
        ],
      ),
    ];
  }
}

String str =
    '商业平台学院是百度商业体系最大的前端团队，所在部门主要负责百度核心商业产品推广平台的建设，包括搜索推广和信息流推广，是公司绝大部分收入的来源。学院不仅提供Web前端、还有iOS、Android方向供大家学习。商业平台学院欢迎你的到来！';
