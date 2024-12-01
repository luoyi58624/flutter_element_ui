import 'package:element_docs/global.dart';
import 'package:flutter/widgets.dart';
import 'example6.dart';

class Example9 extends HookWidget {
  const Example9({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title),
        const SectionCard(
          title: 'Tip',
          content: [
            '预设全局 Size 不仅需要考虑所有 Widget 的各种边距、尺寸，还需要考虑内部的文字、图标的大小，'
                '即使实现此功能在很多时候预设的值也往往不符合预期，还造成 Api 复杂度、代码实现复杂度进一步提升，'
                '所以我对这种功能并不感兴趣，我更推荐用户自己去封装一些特定尺寸的小部件，'
                '例如：你可以简单的通过设置 width、height、padding、block 等属性封装各种尺寸按钮。'
          ],
        ),
        textGap,
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
    final loading = useState(false);
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        const ElButton(
          height: 20,
          type: 'primary',
          child: ElText('小型按钮', style: TextStyle(fontSize: 12)),
        ),
        ElButton(
          onPressed: () {
            loading.value = true;
            setTimeout(() {
              loading.value = false;
            }, 1000);
          },
          height: 20,
          type: 'success',
          loading: loading.value,
          leftIcon: const ElIcon(ElIcons.delete),
          loadingBuilder: loadingBuilder,
          child: const ElText('删除', style: TextStyle(fontSize: 12)),
        ),
        const ElButton(
          height: 48,
          block: true,
          type: 'primary',
          child: ElText('块级按钮', style: TextStyle(fontSize: 20)),
        ),
        ElButton(
          width: 80,
          height: 80,
          padding: EdgeInsets.zero,
          borderRadius: BorderRadius.circular(40),
          type: 'primary',
          child: const ElText(
            '按钮',
            style: TextStyle(fontSize: 20),
          ),
        ),
        ElButton(
          padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 26),
          borderRadius: BorderRadius.circular(16),
          type: 'primary',
          child: const ElText('按钮', style: TextStyle(fontSize: 20)),
        ),
      ],
    );
  }
}

String get code => '''
class _Example extends HookWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    final loading = useState(false);
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        const ElButton(
          height: 20,
          type: 'primary',
          child: ElText('小型按钮', style: TextStyle(fontSize: 12)),
        ),
        ElButton(
          onPressed: () {
            loading.value = true;
            setTimeout(() {
              loading.value = false;
            }, 1000);
          },
          height: 20,
          type: 'success',
          loading: loading.value,
          leftIcon: const ElIcon(ElIcons.delete),
          loadingBuilder: loadingBuilder,
          child: const ElText('删除', style: TextStyle(fontSize: 12)),
        ),
        const ElButton(
          height: 48,
          block: true,
          type: 'primary',
          child: ElText('块级按钮', style: TextStyle(fontSize: 20)),
        ),
        ElButton(
          width: 80,
          height: 80,
          padding: EdgeInsets.zero,
          borderRadius: BorderRadius.circular(40),
          type: 'primary',
          child: const ElText(
            '按钮',
            style: TextStyle(fontSize: 20),
          ),
        ),
        ElButton(
          padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 26),
          borderRadius: BorderRadius.circular(16),
          type: 'primary',
          child: const ElText('按钮', style: TextStyle(fontSize: 20)),
        ),
      ],
    );
  }
}''';
