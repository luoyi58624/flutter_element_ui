import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Example2 extends HookWidget {
  const Example2({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title),
        CodeExample(
          code: code,
          children: const [
            _Example(),
          ],
        ),
      ],
    );
  }
}

class _Example extends HookWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Row(
        children: [
          leftWidget,
          Expanded(child: rightWidget),
        ],
      ),
    );
  }

  Widget get leftWidget {
    final activeIndex = useState(-1);

    return ElBrightness(
      brightness: Brightness.dark,
      child: ColoredBox(
        color: Colors.blueGrey.shade800,
        child: ElFocusScope(
          child: Builder(builder: (context) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const Gap(8),
                  ElEventTheme(
                    data: const ElEventThemeData(
                      canRequestFocus: false,
                    ),
                    child: ElButton(
                      onPressed: () {
                        ElFocusScope.requestPoinerDownFocus(context);
                      },
                      child: FocusScope.of(context).hasFocus ? '得到焦点' : '失去焦点',
                    ),
                  ),
                  const Gap(16),
                  ...List.generate(
                    10,
                    (index) => CallbackShortcuts(
                      bindings: {
                        const SingleActivator(LogicalKeyboardKey.enter): () {
                          activeIndex.value = index;
                        }
                      },
                      child: ElEvent(
                        onTapDown: (e) {
                          activeIndex.value = index;
                        },
                        child: Builder(builder: (context) {
                          return Container(
                            width: 240,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Focus.of(context).hasFocus
                                  ? Colors.lightBlueAccent.shade400
                                  : activeIndex.value == index
                                      ? Colors.white24
                                      : null,
                            ),
                            child:
                                Center(child: ElText('item - ${index + 1}')),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget get rightWidget {
    final input = useState('');
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const ElButton(child: 'hello'),
          const Gap(8),
          ElInput(input),
        ],
      ),
    );
  }
}

String get code => '''
class _Example extends HookWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ElEvent(
          onTap: () {
            el.message.show('单击');
          },
          child: Container(
            width: 100,
            height: 50,
            color: Colors.grey,
            alignment: Alignment.center,
            child: const ElText('单击'),
          ),
        ),
        ElEvent(
          onSecondaryTap: () {
            el.message.primary('右键');
          },
          child: Container(
            width: 100,
            height: 50,
            color: Colors.grey,
            alignment: Alignment.center,
            child: const ElText('右键'),
          ),
        ),
        ElEvent(
          onDoubleTap: () {
            el.message.success('双击');
          },
          child: Container(
            width: 100,
            height: 50,
            color: Colors.grey,
            alignment: Alignment.center,
            child: const ElText('双击'),
          ),
        ),
        ElEvent(
          onTap: () {
            el.message.show('单击');
          },
          onDoubleTap: () {
            el.message.success('双击');
          },
          child: Container(
            width: 120,
            height: 50,
            color: Colors.grey,
            alignment: Alignment.center,
            child: const ElText('单击 + 双击'),
          ),
        ),
        ElEvent(
          onTap: () {
            el.message.show('单击');
          },
          onDoubleTap: () {
            el.message.success('双击');
          },
          delayTapForDouble: true,
          child: Container(
            width: 160,
            height: 50,
            color: Colors.grey,
            alignment: Alignment.center,
            child: const ElText('延迟单击 + 双击'),
          ),
        ),
        ElEvent(
          onLongPress: () {
            el.message.warning('长按');
          },
          child: Container(
            width: 100,
            height: 50,
            color: Colors.grey,
            alignment: Alignment.center,
            child: const ElText('长按'),
          ),
        ),
      ],
    );
  }
}''';
