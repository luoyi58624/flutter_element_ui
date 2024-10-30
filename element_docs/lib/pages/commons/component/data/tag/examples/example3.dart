import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

class Example3 extends StatelessWidget {
  const Example3({super.key, required this.title});

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
    final tagList = useState(['tag 1']);
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ...tagList.value.map((e) => ElTag(
              e,
              leftIcon: const ElIcon(ElIcons.document),
              closable: true,
              onClose: () {
                final temp = List<String>.from(tagList.value);
                temp.remove(e);
                tagList.value = temp;
              },
            )),
        ElButton(
          onPressed: () {
            if (tagList.value.isEmpty) {
              tagList.value = ['tag 1'];
            } else {
              tagList.value = [
                ...tagList.value,
                'tag ${int.parse(tagList.value.last.split(' ')[1]) + 1}',
              ];
            }
          },
          height: 28,
          child: const ElText(
            '+ New Tag',
            style: TextStyle(fontSize: 12),
          ),
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
    final tagList = useState(['tag 1']);
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ...tagList.value.map((e) => ElTag(
              e,
              leftIcon: const ElIcon(ElIcons.document),
              closable: true,
              onClose: () {
                final temp = List<String>.from(tagList.value);
                temp.remove(e);
                tagList.value = temp;
              },
            )),
        ElButton(
          onPressed: () {
            if (tagList.value.isEmpty) {
              tagList.value = ['tag 1'];
            } else {
              tagList.value = [
                ...tagList.value,
                'tag \${int.parse(tagList.value.last.split(' ')[1]) + 1}',
              ];
            }
          },
          height: 28,
          child: const ElText(
            '+ New Tag',
            style: TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }
}''';
