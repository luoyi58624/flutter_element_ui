import 'package:example/global.dart';
import 'package:flutter/material.dart';

class ButtonPage extends HookWidget {
  const ButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    final (count, addCount) = useCount();
    final (disabled, toggleDisabled) = useToggle();
    final buttonTypes = [null, ...el.themeTypes];

    Widget buildTitle(String title) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Gap(36),
            H4(title),
            const Gap(8),
          ],
        );
    Widget buildWrap(Iterable<Widget> children) =>
        Wrap(spacing: 8, runSpacing: 8, children: children.toList());

    return ObsBuilder(builder: (context) {
      return ColumnWidget(
        scroll: true,
        repaintBoundary: GlobalState.scrollRepaintBoundary.value,
        padding: const EdgeInsets.all(8.0),
        children: [
          Material(
            child: InkWell(
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Text('text'),
              ),
            ),
          ),
          ElContextMenu(
            on: (offset) {
              i(offset);
            },
            child: ElButton(
              onPressed: () {
                i('x');
              },
              child: '点击',
            ),
          ),
          const Gap(8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ElButton(
                onPressed: toggleDisabled,
                child: disabled ? '开启' : '禁用',
              ),
              ObsBuilder(builder: (context) {
                return ElButton(
                  onPressed: () =>
                      GlobalState.isDark.value = !GlobalState.isDark.value,
                  child: GlobalState.isDark.value ? '亮色模式' : '暗色模式',
                );
              }),
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
          buildTitle('链接按钮'),
          buildWrap(buttonTypes.map(
            (type) => ElButton(
                child: 'count: $count',
                onPressed: addCount,
                type: type,
                link: true,
                disabled: disabled),
          )),
          buildTitle('链接按钮 - 自定义样式'),
          buildWrap([
            ElButton(
              onPressed: () {
                launchUrl(Uri.parse('https://www.baidu.com'));
              },
              link: true,
              type: 'primary',
              child: const Text(
                'https://www.baidu.com',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const ElButton(
              onPressed: null,
              link: true,
              type: 'error',
              child: Text(
                'https://www.baidu.com',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            const ElButton(
              onPressed: null,
              link: true,
              type: 'success',
              child: 'https://www.baidu.com',
            ),
            const ElButton(
              onPressed: null,
              link: true,
              type: 'info',
              child: ElText('https://www.baidu.com'),
            ),
            const ElButton(
              onPressed: null,
              link: true,
              type: 'warning',
              child: ElText('https://www.baidu.com'),
            ),
            const ElButton(
              onPressed: null,
              link: true,
              type: 'error',
              child: ElText('https://www.baidu.com'),
            ),
          ]),
          buildTitle('图标按钮'),
          buildWrap(buttonTypes.map(
            (type) => ElButton(
              onPressed: null,
              type: type,
              disabled: disabled,
              child: const ElIcon(ElIcons.aim),
            ),
          )),
          buildTitle('圆形图标按钮'),
          buildWrap(buttonTypes.map(
            (type) => ElButton(
              onPressed: null,
              type: type,
              circle: true,
              disabled: disabled,
              child: const ElIcon(ElIcons.aim),
            ),
          )),
          buildTitle('左图标文字按钮'),
          buildWrap(buttonTypes.map(
            (type) => ElButton(
              child: 'Search',
              onPressed: () {},
              type: type,
              leftIcon: const ElIcon(ElIcons.search),
              disabled: disabled,
            ),
          )),
          buildTitle('右图标文字按钮'),
          buildWrap(buttonTypes.map(
            (type) => ElButton(
              child: 'Upload',
              onPressed: () {},
              type: type,
              rightIcon: const ElIcon(ElIcons.upload),
              disabled: disabled,
            ),
          )),
          buildTitle('自定义颜色按钮'),
          buildWrap([
            Colors.cyan,
            Colors.purple,
            Colors.blue,
            Colors.lightGreen,
            Colors.indigo
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
            Colors.indigo
          ].map(
            (bgColor) => ElButton(
              child: 'count: $count',
              onPressed: addCount,
              bgColor: bgColor,
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
      );
    });
  }
}
