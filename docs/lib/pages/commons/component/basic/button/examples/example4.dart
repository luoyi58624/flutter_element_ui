import 'package:docs/global.dart';
import 'package:flutter/widgets.dart';

import '../index.dart';

class Example4 extends HookWidget {
  const Example4({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final loading = useState(false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title),
        CodeExample(
          code: code,
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ButtonPage.buttonTypes
                  .map(
                    (type) => ElButton(
                      type: type,
                      text: true,
                      child: (type ?? 'Default').firstUpperCase,
                    ),
                  )
                  .toList(),
            ),
            const Gap(12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ButtonPage.buttonTypes
                  .map(
                    (type) => ElButton(
                      type: type,
                      text: true,
                      bg: true,
                      child: (type ?? 'Default').firstUpperCase,
                    ),
                  )
                  .toList(),
            ),
            const Gap(12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ButtonPage.buttonTypes
                  .map(
                    (type) => ElButton(
                      type: type,
                      text: true,
                      disabled: true,
                      child: (type ?? 'Default').firstUpperCase,
                    ),
                  )
                  .toList(),
            ),
            const Gap(12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElButton(
                  onPressed: () {
                    loading.value = true;
                    () {
                      loading.value = false;
                    }.delay(1000);
                  },
                  height: 32,
                  iconSize: 18,
                  text: true,
                  loading: loading.value,
                  padding: EdgeInsets.zero,
                  loadingBuilder: iconLoading,
                  child: const ElIcon(ElIcons.sHome),
                ),
                ElButton(
                  onPressed: () {
                    loading.value = true;
                    () {
                      loading.value = false;
                    }.delay(1000);
                  },
                  height: 32,
                  iconSize: 18,
                  text: true,
                  type: 'primary',
                  loading: loading.value,
                  padding: EdgeInsets.zero,
                  loadingBuilder: iconLoading,
                  child: const ElIcon(ElIcons.share),
                ),
                ElButton(
                  onPressed: () {
                    loading.value = true;
                    () {
                      loading.value = false;
                    }.delay(1000);
                  },
                  height: 32,
                  iconSize: 18,
                  text: true,
                  type: 'success',
                  loading: loading.value,
                  padding: EdgeInsets.zero,
                  loadingBuilder: iconLoading,
                  child: const ElIcon(ElIcons.editOutline),
                ),
                ElButton(
                  onPressed: () {
                    loading.value = true;
                    () {
                      loading.value = false;
                    }.delay(1000);
                  },
                  height: 32,
                  iconSize: 18,
                  text: true,
                  type: 'error',
                  loading: loading.value,
                  padding: EdgeInsets.zero,
                  loadingBuilder: iconLoading,
                  child: const ElIcon(ElIcons.delete),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

var iconLoading = (state) => ElLoading(
      ElIcons.loading,
      size: state.size,
      color: state.color,
    );

String get code => '''
ElButton(child: 'Hello', text: true),
ElButton(child: 'Hello', text: true, bg: true),

// 文字图标按钮
ElButton(
  height: 32,
  iconSize: 18,
  text: true,
  padding: EdgeInsets.zero,
  child: ElIcon(ElIcons.sHome),
),

// 默认加载只会在左侧显示 loading 图标，所以如果你想覆盖按钮图标应当使用 loadingBuilder
var iconLoading = (state) => ElLoading(
  ElIcons.loading,
  size: state.size,
  color: state.color,
);''';
