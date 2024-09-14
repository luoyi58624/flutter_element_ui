import 'package:docs/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../index.dart';

class Example6 extends StatelessWidget {
  const Example6({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('加载状态'),
        CodeExampleWidget(
          code: code,
          children: const [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _LoadingButton1(),
                _LoadingButton2(),
                _LoadingButton3(),
                ElButton(child: '',type: 'primary',),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _LoadingButton1 extends HookWidget {
  const _LoadingButton1();

  @override
  Widget build(BuildContext context) {
    final loading = useState(false);
    return ElButton(
      onPressed: () {
        loading.value = true;
        () {
          loading.value = false;
        }.delay(1500);
      },
      loading: loading.value,
      child: ('Default'),
    );
  }
}

class _LoadingButton2 extends HookWidget {
  const _LoadingButton2();

  @override
  Widget build(BuildContext context) {
    final loading = useState(false);
    return ElButton(
      onPressed: () {
        loading.value = true;
        () {
          loading.value = false;
        }.delay(1500);
      },
      loading: loading.value,
      type: 'primary',
      child: ('Default'),
    );
  }
}

class _LoadingButton3 extends HookWidget {
  const _LoadingButton3();

  @override
  Widget build(BuildContext context) {
    final loading = useState(false);
    return ElButton(
      onPressed: () {
        loading.value = true;
        () {
          loading.value = false;
        }.delay(1500);
      },
      loading: loading.value,
      loadingWidget: const SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Colors.white,
        ),
      ),
      type: 'primary',
      child: ('Default'),
    );
  }
}

String get code => '''ElButton(child: 'Hello', text: true),''';
