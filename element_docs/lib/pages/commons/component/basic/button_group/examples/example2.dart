import 'package:element_docs/global.dart';
import 'package:element_docs/pages/commons/component/basic/button/examples/example6.dart';
import 'package:flutter/widgets.dart';

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

class _Example extends HookWidget {
  const _Example({super.key});

  @override
  Widget build(BuildContext context) {
    final selected = useState(-1);
    final loading = useState(false);

    openLoading() {
      loading.value = true;
      setTimeout(() {
        loading.value = false;
      }, 1000);
    }

    return Column(
      children: [
        ElButtonGroup(
          selected,
          children: [
            ElButton(child: '选项一'),
            ElButton(child: '选项二'),
            ElButton(child: '选项三'),
            ElButton(child: '选项四'),
          ],
        ),
      ],
    );
  }
}

String get code => '''
ElButton(child: 'Hello', disabled: true),''';
