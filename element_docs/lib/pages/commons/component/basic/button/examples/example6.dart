import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

int _loadingDuration = 1000;

class Example6 extends StatelessWidget {
  const Example6({super.key, required this.title});

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
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _Loading1(),
                _Loading2(),
                _Loading3(),
                _Loading4(),
                _Loading5(),
              ],
            ),
            Gap(8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                _CustomLoading1(),
                _CustomLoading2(),
                _CustomLoading3(),
                _CustomLoading4(),
                _CustomLoading5(),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _Loading1 extends HookWidget {
  const _Loading1();

  @override
  Widget build(BuildContext context) {
    final loading = useState(false);
    return ElButton(
      onPressed: () {
        loading.value = true;
        setTimeout(() {
          loading.value = false;
        }, _loadingDuration);
      },
      loading: loading.value,
      child: '提交',
    );
  }
}

class _Loading2 extends HookWidget {
  const _Loading2();

  @override
  Widget build(BuildContext context) {
    final loading = useState(false);
    return ElButton(
      onPressed: () {
        loading.value = true;
        setTimeout(() {
          loading.value = false;
        }, _loadingDuration);
      },
      loading: loading.value,
      type: 'primary',
      leftIcon: const ElIcon(ElIcons.edit),
      child: '编辑',
    );
  }
}

class _Loading3 extends HookWidget {
  const _Loading3();

  @override
  Widget build(BuildContext context) {
    final loading = useState(false);
    return ElButton(
      onPressed: () {
        loading.value = true;
        setTimeout(() {
          loading.value = false;
        }, _loadingDuration);
      },
      loading: loading.value,
      type: 'success',
      rightIcon: const ElIcon(ElIcons.upload2),
      child: '上传',
    );
  }
}

class _Loading4 extends HookWidget {
  const _Loading4();

  @override
  Widget build(BuildContext context) {
    final loading = useState(false);
    return ElButton(
      onPressed: () {
        loading.value = true;
        setTimeout(() {
          loading.value = false;
        }, _loadingDuration);
      },
      loading: loading.value,
      type: 'warning',
      loadingWidget: const ElLoading(ElIcons.eleme),
      child: '自定义Icon',
    );
  }
}

class _Loading5 extends HookWidget {
  const _Loading5();

  @override
  Widget build(BuildContext context) {
    final loading = useState(false);
    return ElButton(
      onPressed: () {
        loading.value = true;
        setTimeout(() {
          loading.value = false;
        }, _loadingDuration);
      },
      loading: loading.value,
      type: 'error',
      child: const ElIcon(ElIcons.delete),
    );
  }
}

class _CustomLoading1 extends HookWidget {
  const _CustomLoading1();

  @override
  Widget build(BuildContext context) {
    final loading = useState(false);
    return ElButton(
      onPressed: () {
        loading.value = true;
        setTimeout(() {
          loading.value = false;
        }, _loadingDuration);
      },
      loading: loading.value,
      loadingBuilder: (color) => const ElText('加载中...'),
      type: 'primary',
      child: '自定义加载内容',
    );
  }
}

class _CustomLoading2 extends HookWidget {
  const _CustomLoading2();

  @override
  Widget build(BuildContext context) {
    final loading = useState(false);
    return ElButton(
      onPressed: () {
        loading.value = true;
        setTimeout(() {
          loading.value = false;
        }, _loadingDuration);
      },
      loading: loading.value,
      loadingBuilder: (state) => SizedBox(
        width: state.size,
        height: state.size,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: state.color,
        ),
      ),
      type: 'primary',
      child: '自定义Loading',
    );
  }
}

class _CustomLoading3 extends HookWidget {
  const _CustomLoading3();

  @override
  Widget build(BuildContext context) {
    final loading = useState(false);
    return ElButton(
      onPressed: () {
        loading.value = true;
        setTimeout(() {
          loading.value = false;
        }, _loadingDuration);
      },
      loading: loading.value,
      loadingBuilder: loadingBuilder,
      type: 'primary',
      plain: true,
      child: '镂空按钮',
    );
  }
}

class _CustomLoading4 extends HookWidget {
  const _CustomLoading4();

  @override
  Widget build(BuildContext context) {
    final loading = useState(false);
    return ElButton(
      onPressed: () {
        loading.value = true;
        setTimeout(() {
          loading.value = false;
        }, _loadingDuration);
      },
      loading: loading.value,
      loadingBuilder: loadingBuilder,
      type: 'primary',
      text: true,
      child: '文字按钮',
    );
  }
}

class _CustomLoading5 extends HookWidget {
  const _CustomLoading5();

  @override
  Widget build(BuildContext context) {
    final loading = useState(false);
    return ElButton(
      onPressed: () {
        loading.value = true;
        setTimeout(() {
          loading.value = false;
        }, _loadingDuration);
      },
      loading: loading.value,
      loadingBuilder: loadingBuilder,
      type: 'primary',
      link: true,
      child: '链接按钮',
    );
  }
}

var loadingBuilder = (ElButtonLoadingState state) => SizedBox(
      width: state.size,
      height: state.size,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: state.color,
      ),
    );

String get code => '''
// 默认在左边显示 loading 图标
ElButton(loading: true, child: '提交'),

// 如果存在 leftIcon，则会将左图标替换成 loading
ElButton(loading: true, leftIcon: const ElIcon(ElIcons.edit), child: '编辑'),

// 如果存在 rightIcon，则会将右图标替换成 loading
ElButton(loading: true, rightIcon: const ElIcon(ElIcons.upload2), child: '上传'),

// 自定义加载图标
ElButton(loading: true, loadingWidget: const ElLoading(ElIcons.eleme), child: '自定义Icon'),

// loadingBuilder 会替换按钮原有内容
ElButton(
  loading: true,
  loadingBuilder: (state) => const ElText('加载中...'), 
  child: '自定义加载内容',
),

// 渲染 Flutter 官方提供的进度指示器小部件
ElButton(
  loading: true,
  loadingBuilder: loadingBuilder,
  child: '自定义Loading',
),

// 你可以将 loadingBuilder 封装成一个函数，或者在 ElButtonTheme 小部件中注入默认的加载器
var loadingBuilder = (ElButtonLoadingState state) => SizedBox(
      width: state.size,
      height: state.size,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: state.color,
      ),
    );
''';
