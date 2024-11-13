import 'package:element_docs/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconTestPage extends HookWidget {
  const IconTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useScrollController();
    final List<String> keys = [];
    for (int i = 0; i < 1000; i++) {
      keys.addAll(ElIcons.values.keys.toList());
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Icon测试'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CupertinoScrollbar(
          controller: controller,
          child: GridWidget(
            controller: controller,
            size: 125,
            itemCount: keys.length,
            borderColor: context.elTheme.borderColor,
            borderRadius: context.elTheme.cardTheme.radius,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                CommonUtil.copy('ElIcon(ElIcons.${keys[index]})');
              },
              child: ElEvent(
                cursor: SystemMouseCursors.click,
                builder: (context) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElIcon(
                          ElIcons.values[keys[index]],
                          color: context.isHover ? context.elTheme.primary : null,
                        ),
                        const Gap(16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ElText(
                            keys[index],
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              color:
                                  context.isHover ? context.elTheme.primary : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ).noScrollBehavior,
        ),
      ),
    );
  }
}
