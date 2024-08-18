import 'package:docs/global.dart';
import 'package:flutter/material.dart';

class DesignPage extends StatelessWidget {
  const DesignPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(50),
            const H1('设计原则'),
            const Gap(28),
            const H2('一致 Consistency'),
            const Gap(8),
            ElText(
              [
                ElText(
                  '与现实生活一致：',
                  style: TextStyle(fontWeight: FontUtil.medium),
                ),
                '与现实生活的流程、逻辑保持一致，遵循用户习惯的语言和概念；',
              ],
              style: const TextStyle(height: 1.8,fontWeight: FontWeight.w500),
            ),
            ElText(
              [
                ElText(
                  '在界面中一致：',
                  style: TextStyle(fontWeight: FontUtil.medium),
                ),
                '所有的元素和结构需保持一致，比如：设计样式、图标和文本、元素的位置等。',
              ],
              style: const TextStyle(height: 1.8),
            ),
            const Gap(28),
            const H2('反馈 Feedback'),
            const Gap(8),
            ElText(
              [
                ElText(
                  '控制反馈：',
                  style: TextStyle(fontWeight: FontUtil.medium),
                ),
                '通过界面样式和交互动效让用户可以清晰的感知自己的操作；',
              ],
              style: const TextStyle(height: 1.8),
            ),
            ElText(
              [
                ElText(
                  '页面反馈：',
                  style: TextStyle(fontWeight: FontUtil.medium),
                ),
                '操作后，通过页面元素的变化清晰地展现当前状态。',
              ],
              style: const TextStyle(height: 1.8),
            ),
            const Gap(28),
            const H2('效率 Efficiency'),
            const Gap(8),
            ElText(
              [
                ElText(
                  '简化流程：',
                  style: TextStyle(fontWeight: FontUtil.medium),
                ),
                '设计简洁直观的操作流程；',
              ],
              style: const TextStyle(height: 1.8),
            ),
            ElText(
              [
                ElText(
                  '清晰明确：',
                  style: TextStyle(fontWeight: FontUtil.medium),
                ),
                '语言表达清晰且表意明确，让用户快速理解进而作出决策；',
              ],
              style: const TextStyle(height: 1.8),
            ),
            ElText(
              [
                ElText(
                  '帮助用户识别：',
                  style: TextStyle(fontWeight: FontUtil.medium),
                ),
                '界面简单直白，让用户快速识别而非回忆，减少用户记忆负担。',
              ],
              style: const TextStyle(height: 1.8),
            ),
            const Gap(28),
            const H2('可控 Controllability'),
            const Gap(8),
            ElText(
              [
                ElText(
                  '用户决策：',
                  style: TextStyle(fontWeight: FontUtil.medium),
                ),
                '根据场景可给予用户操作建议或安全提示，但不能代替用户进行决策；',
              ],
              style: const TextStyle(height: 1.8),
            ),
            ElText(
              [
                ElText(
                  '结果可控：',
                  style: TextStyle(fontWeight: FontUtil.medium),
                ),
                '用户可以自由的进行操作，包括撤销、回退和终止当前操作等。',
              ],
              style: const TextStyle(height: 1.8),
            ),
          ],
        ).globalTextStyle,
      ),
    );
  }
}
