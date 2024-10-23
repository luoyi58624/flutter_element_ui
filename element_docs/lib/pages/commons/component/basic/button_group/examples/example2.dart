import 'package:element_docs/global.dart';
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
  const _Example();

  @override
  Widget build(BuildContext context) {
    final selected = useState(-1);
    final selectedList = useState([]);
    final loading = useState(false);

    openLoading() {
      loading.value = true;
      setTimeout(() {
        loading.value = false;
      }, 1000);
    }

    return Column(
      children: [
        ElText(selected.value),
        ElButtonTheme(
          data: ElButtonThemeData(
            borderBuilder: (state) => Border.all(
              width: state.isHover || state.isTap ? 1.5 : 1.0,
              color: state.color,
            ),
          ),
          child: ElButtonGroup(
            selected,
            children: const [
              ElButton(child: '选项一'),
              ElButton(child: '选项二'),
              ElButton(child: '选项三'),
              ElButton(child: '选项四'),
            ],
          ),
        ),
        const Gap(8),
        ElText(selectedList.value),
        ElButtonGroup(
          selectedList,
          children: const [
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
