import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

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
            _Example(0),
            Gap(8),
            _Example(1),
            Gap(8),
            _Example(2),
            Gap(8),
            _Example(3),
            Gap(8),
            _Example2(),
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

class _Example extends HookWidget {
  const _Example(this.buttonType);

  final int buttonType;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _LoadingIconButton(
          buttonType: buttonType,
          type: El.primary,
          child: '提交',
        ),
        _LoadingIconButton(
          buttonType: buttonType,
          type: El.success,
          leftIcon: const ElIcon(ElIcons.search),
          child: 'Search',
        ),
        _LoadingIconButton(
          buttonType: buttonType,
          type: El.warning,
          rightIcon: const ElIcon(ElIcons.upload2),
          child: '上传',
        ),
        _LoadingIconButton(
          buttonType: buttonType,
          type: El.error,
          leftIcon: const ElIcon(ElIcons.search),
          loadingWidget: const ElLoading(ElIcons.eleme),
          child: '自定义 Loading',
        ),
      ],
    );
  }
}

class _LoadingIconButton extends HookWidget {
  const _LoadingIconButton({
    required this.child,
    this.type,
    this.leftIcon,
    this.rightIcon,
    this.loadingWidget,
    this.buttonType = 0,
  });

  final dynamic child;
  final String? type;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final Widget? loadingWidget;
  final int buttonType;

  @override
  Widget build(BuildContext context) {
    final loading = useState(false);
    onTap() {
      loading.value = true;
      setTimeout(() {
        loading.value = false;
      }, 1000);
    }

    if (buttonType == 1) {
      return ElOutlineButton(
        onPressed: onTap,
        loading: loading.value,
        type: type,
        leftIcon: leftIcon,
        rightIcon: rightIcon,
        loadingWidget: loadingWidget,
        child: child,
      );
    } else if (buttonType == 2) {
      return ElTextButton(
        onPressed: onTap,
        loading: loading.value,
        type: type,
        leftIcon: leftIcon,
        rightIcon: rightIcon,
        loadingWidget: loadingWidget,
        bg: true,
        child: child,
      );
    } else if (buttonType == 3) {
      return ElTextButton(
        onPressed: onTap,
        loading: loading.value,
        type: type,
        leftIcon: leftIcon,
        rightIcon: rightIcon,
        loadingWidget: loadingWidget,
        child: child,
      );
    }
    return ElButton(
      onPressed: onTap,
      loading: loading.value,
      type: type,
      leftIcon: leftIcon,
      rightIcon: rightIcon,
      loadingWidget: loadingWidget,
      child: child,
    );
  }
}

class _Example2 extends StatelessWidget {
  const _Example2();

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _TextIconLoadingWidget(
          child: ElIcon(ElIcons.sHome),
        ),
        _TextIconLoadingWidget(
          type: El.primary,
          child: ElIcon(ElIcons.share),
        ),
        _TextIconLoadingWidget(
          type: El.success,
          child: ElIcon(ElIcons.editOutline),
        ),
        _TextIconLoadingWidget(
          type: El.warning,
          child: ElIcon(ElIcons.warning),
        ),
        _TextIconLoadingWidget(
          type: El.error,
          child: ElIcon(ElIcons.delete),
        ),
      ],
    );
  }
}

class _TextIconLoadingWidget extends HookWidget {
  const _TextIconLoadingWidget({this.child, this.type});

  final dynamic child;
  final String? type;

  @override
  Widget build(BuildContext context) {
    final loading = useState(false);
    onTap() {
      loading.value = true;
      setTimeout(() {
        loading.value = false;
      }, 1000);
    }

    return ElTextButton(
      onPressed: onTap,
      loading: loading.value,
      type: type,
      child: child,
    );
  }
}

int _loadingDuration = 1000;

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
      loadingBuilder: (context) => const ElText('加载中...'),
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
      loadingBuilder: ElLinkButton.defaultLoadingBuilder,
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
    return ElOutlineButton(
      onPressed: () {
        loading.value = true;
        setTimeout(() {
          loading.value = false;
        }, _loadingDuration);
      },
      loading: loading.value,
      loadingBuilder: ElLinkButton.defaultLoadingBuilder,
      type: 'primary',
      child: '镂空按钮',
    );
  }
}

class _CustomLoading4 extends HookWidget {
  const _CustomLoading4();

  @override
  Widget build(BuildContext context) {
    final loading = useState(false);
    return ElTextButton(
      onPressed: () {
        loading.value = true;
        setTimeout(() {
          loading.value = false;
        }, _loadingDuration);
      },
      loading: loading.value,
      loadingBuilder: ElLinkButton.defaultLoadingBuilder,
      type: 'primary',
      child: '文字按钮',
    );
  }
}

class _CustomLoading5 extends HookWidget {
  const _CustomLoading5();

  @override
  Widget build(BuildContext context) {
    final loading = useState(false);
    return ElLinkButton(
      onPressed: () {
        loading.value = true;
        setTimeout(() {
          loading.value = false;
        }, _loadingDuration);
      },
      loading: loading.value,
      type: 'primary',
      child: '链接按钮',
    );
  }
}

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
  loadingBuilder: (context) => const ElText('加载中...'), 
  child: '自定义加载内容',
),

// 使用 ElLinkButton 链接按钮的加载器
ElButton(
  loading: true,
  loadingBuilder: ElLinkButton.defaultLoadingBuilder,
  child: '自定义Loading',
),''';
