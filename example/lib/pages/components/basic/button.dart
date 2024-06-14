import 'package:example/global.dart';
import 'package:flutter/material.dart';

class ButtonPage extends HookWidget {
  const ButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useScrollController();
    final (count, addCount) = useCount();
    final (disabled, toggleDisabled) = useToggle();
    final buttonTypes = [null, ...elThemeTypes];

    Widget buildTitle(String title) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Gap(36),
            Text(title,
                style: TextStyle(
                  fontWeight: FontUtil.bold,
                  fontSize: 18,
                )),
            const Gap(8),
          ],
        );
    Widget buildWrap(Iterable<Widget> children) =>
        Wrap(spacing: 8, runSpacing: 8, children: children.toList());

    return SingleChildScrollView(
      controller: controller,
      physics: const NeverScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElButton(
                    child: disabled ? 'Enabled' : 'Disabled',
                    onPressed: toggleDisabled),
                const ElButton(child: '你好'),
              ],
            ),
            buildTitle('普通按钮'),
            buildWrap(buttonTypes.map(
              (type) => ElButton(
                  child: 'count: $count',
                  onPressed: addCount,
                  type: type,
                  disabled: disabled),
            )),
            buildTitle('镂空按钮'),
            buildWrap(buttonTypes.map(
              (type) => ElButton(
                  child: 'count: $count',
                  onPressed: addCount,
                  type: type,
                  plain: true,
                  disabled: disabled),
            )),
            buildTitle('圆角按钮'),
            buildWrap(buttonTypes.map(
              (type) => ElButton(
                  child: 'count: $count',
                  onPressed: addCount,
                  type: type,
                  round: true,
                  disabled: disabled),
            )),
            buildTitle('圆角镂空按钮'),
            buildWrap(buttonTypes.map(
              (type) => ElButton(
                  child: 'count: $count',
                  onPressed: addCount,
                  type: type,
                  plain: true,
                  round: true,
                  disabled: disabled),
            )),
            buildTitle('文字按钮'),
            buildWrap(buttonTypes.map(
              (type) => ElButton(
                  child: 'count: $count',
                  onPressed: addCount,
                  type: type,
                  text: true,
                  disabled: disabled),
            )),
            buildTitle('文字圆角按钮'),
            buildWrap(buttonTypes.map(
              (type) => ElButton(
                  child: 'count: $count',
                  onPressed: addCount,
                  type: type,
                  text: true,
                  round: true,
                  disabled: disabled),
            )),
            buildTitle('图标按钮'),
            buildWrap(buttonTypes.map(
              (type) => ElButton(
                  type: type,
                  disabled: disabled,
                  child: const ElIcon(ElIcons.aim)),
            )),
            buildTitle('圆形图标按钮'),
            buildWrap(buttonTypes.map(
              (type) => ElButton(
                  type: type,
                  circle: true,
                  disabled: disabled,
                  child: const ElIcon(ElIcons.aim)),
            )),
            buildTitle('左图标文字按钮'),
            buildWrap(buttonTypes.map(
              (type) => ElButton(
                child: 'count: $count',
                onPressed: addCount,
                type: type,
                leftIcon: const ElIcon(ElIcons.aim),
                disabled: disabled,
              ),
            )),
            buildTitle('右图标文字按钮'),
            buildWrap(buttonTypes.map(
              (type) => ElButton(
                child: 'count: $count',
                onPressed: addCount,
                type: type,
                rightIcon: const ElIcon(ElIcons.aim),
                disabled: disabled,
              ),
            )),
            buildTitle('自定义颜色按钮'),
            buildWrap([
              Colors.cyan,
              Colors.purple,
              Colors.blue,
              Colors.lightGreen,
              Colors.yellow
            ].map(
              (bgColor) => ElButton(
                child: 'count: $count',
                onPressed: addCount,
                bgColor: bgColor,
                disabled: disabled,
              ),
            )),
            buildTitle('自定义颜色镂空按钮'),
            buildWrap([
              Colors.cyan,
              Colors.purple,
              Colors.blue,
              Colors.lightGreen,
              Colors.yellow
            ].map(
              (bgColor) => ElButton(
                child: 'count: $count',
                onPressed: addCount,
                bgColor: bgColor,
                color: Colors.black,
                plain: true,
                disabled: disabled,
              ),
            )),
            buildTitle('块级按钮'),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: buttonTypes
                  .map(
                    (type) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: ElButton(
                        child: 'count: $count',
                        onPressed: addCount,
                        type: type,
                        block: true,
                        disabled: disabled,
                      ),
                    ),
                  )
                  .toList(),
            ),
            buildTitle('块级镂空按钮'),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: buttonTypes
                  .map(
                    (type) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: ElButton(
                        child: 'count: $count',
                        onPressed: addCount,
                        type: type,
                        block: true,
                        plain: true,
                        disabled: disabled,
                      ),
                    ),
                  )
                  .toList(),
            ),
            buildTitle('块级圆角按钮'),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: buttonTypes
                  .map(
                    (type) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: ElButton(
                        child: 'count: $count',
                        onPressed: addCount,
                        type: type,
                        block: true,
                        round: true,
                        disabled: disabled,
                      ),
                    ),
                  )
                  .toList(),
            ),
            buildTitle('块级镂空圆角按钮'),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: buttonTypes
                  .map(
                    (type) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: ElButton(
                        child: 'count: $count',
                        onPressed: addCount,
                        type: type,
                        block: true,
                        plain: true,
                        round: true,
                        disabled: disabled,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
