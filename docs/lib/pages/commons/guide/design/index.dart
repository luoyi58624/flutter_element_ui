import 'package:docs/global.dart';
import 'package:flutter/material.dart';

import 'svg/consistency.dart';
import 'svg/controllability.dart';
import 'svg/efficiency.dart';
import 'svg/feedback.dart';

class DesignPage extends ResponsivePage {
  const DesignPage({super.key});

  @override
  String get title => '设计原则';

  @override
  List<Widget> buildPage(BuildContext context) {
    return [
      const Gap(16),
      SizedBox(
        height: 200,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1024),
          child: Row(
            children: [
              _buildCard(context, const ConsistencySvg(), 'Consistency'),
              const Gap(16),
              _buildCard(context, const FeedbackSvg(), 'Feedback'),
              const Gap(16),
              _buildCard(context, const EfficiencySvg(), 'Efficiency'),
              const Gap(16),
              _buildCard(context, const ControllabilitySvg(), 'Controllability')
            ],
          ),
        ),
      ),
      ..._buildFragment('一致 Consistency', [
        ('与现实生活一致：', '与现实生活的流程、逻辑保持一致，遵循用户习惯的语言和概念；'),
        ('在界面中一致：', '所有的元素和结构需保持一致，比如：设计样式、图标和文本、元素的位置等。'),
      ]),
      ..._buildFragment('反馈 Feedback', [
        ('控制反馈：', '通过界面样式和交互动效让用户可以清晰的感知自己的操作；'),
        ('页面反馈：', '操作后，通过页面元素的变化清晰地展现当前状态。'),
      ]),
      ..._buildFragment('效率 Efficiency', [
        ('简化流程：', '设计简洁直观的操作流程；'),
        ('清晰明确：', '语言表达清晰且表意明确，让用户快速理解进而作出决策；'),
        ('帮助用户识别：', '界面简单直白，让用户快速识别而非回忆，减少用户记忆负担。'),
      ]),
      ..._buildFragment('可控 Controllability', [
        ('用户决策：', '根据场景可给予用户操作建议或安全提示，但不能代替用户进行决策；'),
        ('结果可控：', '用户可以自由的进行操作，包括撤销、回退和终止当前操作等。'),
      ]),
    ];
  }

  Widget _buildCard(BuildContext context, Widget svg, String title) {
    return Expanded(
      child: Card(
        // color: context.isDark
        //     ? const Color.fromRGBO(29, 29, 29, 1)
        //     : const Color.fromRGBO(250, 250, 250, 1),
        // borderRadius: context.elTheme.cardStyle.radius,
        elevation: 1,
        child: Column(
          children: [
            Expanded(child: Center(child: svg)),
            ElText(
              title,
              style: TextStyle(
                fontWeight: FontUtil.medium,
                fontSize: 18,
              ),
            ),
            const Gap(28),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildFragment(String title, List<(String, String)> items) {
    return [
      const Gap(25),
      H2(title),
      const Gap(8),
      Ul(children: [
        ...items.map(
          (e) => Li(
            child: ElText(
              [
                ElText(e.$1, style: TextStyle(fontWeight: FontUtil.medium)),
                e.$2
              ],
            ),
          ),
        ),
      ]),
    ];
  }
}
