import 'package:docs/global.dart';
import 'package:flutter/material.dart';

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
                _LoadingButton4(),
                _LoadingButton5(),
                _LoadingButton6(),
                _LoadingButton10(),
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
      loadingText: '加载中...',
      type: 'primary',
      child: '提交',
    );
  }
}

class _LoadingButton10 extends HookWidget {
  const _LoadingButton10();

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
      child: ('自定义 Loading'),
    );
  }
}

class _LoadingButton4 extends HookWidget {
  const _LoadingButton4();

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
      leftIcon: const ElIcon(ElIcons.edit),
      child: '编辑',
    );
  }
}

class _LoadingButton5 extends HookWidget {
  const _LoadingButton5();

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
      child: '',
    );
  }
}

class _LoadingButton6 extends HookWidget {
  const _LoadingButton6();

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
      child: '',
    );
  }
}

String get code => '''ElButton(child: 'Hello', text: true),''';
