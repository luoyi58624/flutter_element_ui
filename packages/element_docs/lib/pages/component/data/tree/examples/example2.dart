import 'dart:io';

import 'package:element_docs/global.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Example2 extends StatelessWidget {
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

class _Example extends StatelessWidget {
  const _Example();

  void open() async {
    if (kIsWeb) {
      el.message.error('web不支持读取本地文件夹');
      return;
    }
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    if (selectedDirectory != null) {
      final directory = Directory(selectedDirectory);
      i(directory);

      final fileList = directory.listSync();
      i(fileList);
      for (var entity in fileList) {
        print(entity.path);
        // if (entity is Directory) {
        //   i(entity.path, '目录');
        // } else if (entity is File) {
        //   w(entity.path, '文件');
        // }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElButton(
          onPressed: open,
          type: El.primary,
          child: '打开文件夹',
        ),
      ],
    );
  }
}

String get code => '''
class _Example extends StatelessWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: El.themeTypes
          .mapIndexed((i, e) => ElTag(
                'Tag \${i + 1}',
                type: e,
                closable: true,
                onClose: () {
                  el.message.show('点击了关闭按钮', type: e);
                },
              ))
          .toList(),
    );
  }
}''';
