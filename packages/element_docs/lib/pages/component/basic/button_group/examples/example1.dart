import 'package:element_docs/global.dart';
import 'package:element_docs/pages/component/basic/button/examples/example6.dart';
import 'package:flutter/material.dart';

class Example1 extends HookWidget {
  const Example1({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title),
        const SectionCard(
          title: 'Warning',
          type: El.warning,
          content: [
            '在按钮组模式下，height、type、plain、round、bgColor、text、bg 等属性只能通过 ElButtonTheme 统一指定',
          ],
        ),
        textGap,
        CodeExample(
          code: code,
          children: const [
            _Example(),
            Gap(20),
            _Example2(),
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
    final loadingGroupIndex = useState(0);
    final loading = useState(false);
    void openLoading() {
      loading.value = true;
      setTimeout(() {
        loading.value = false;
      }, 1000);
    }

    useEffect(() {
      loading.value = loadingGroupIndex.value != 0;
      return null;
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ElButtonTheme(
          data: const ElButtonThemeData(
            type: El.primary,
          ),
          child: ElButtonGroup.single(
            loadingGroupIndex,
            children: const [
              ElButton(child: '关闭 loading'),
              ElButton(child: '开启 loading'),
            ],
          ),
        ),
        const Gap(8),
        ElButtonGroup(
          children: [
            const ElButton(child: '选项一'),
            ElButton(
              loading: loading.value,
              child: '选项二',
            ),
            const ElButton(child: '选项三'),
          ],
        ),
        const Gap(8),
        ElButtonTheme(
          data: const ElButtonThemeData(
            plain: true,
            borderActiveWidth: 1.5,
          ),
          child: ElButtonGroup(
            children: [
              const ElButton(child: '选项一'),
              ElButton(
                loading: loading.value,
                child: '选项二',
              ),
              const ElButton(child: '选项三'),
            ],
          ),
        ),
        const Gap(8),
        ElButtonTheme(
          data: const ElButtonThemeData(
            type: El.primary,
          ),
          child: ElButtonGroup(
            children: [
              const ElButton(child: '选项一'),
              ElButton(
                loading: loading.value,
                child: '选项二',
              ),
              const ElButton(child: '选项三'),
            ],
          ),
        ),
        const Gap(8),
        ElButtonTheme(
          data: const ElButtonThemeData(
            type: El.success,
            plain: true,
            round: true,
          ),
          child: ElButtonGroup(
            children: [
              const ElButton(child: '选项一'),
              ElButton(
                loading: loading.value,
                child: '选项二',
              ),
              const ElButton(child: '选项三'),
            ],
          ),
        ),
        const Gap(8),
        ElButtonTheme(
          data: const ElButtonThemeData(
            text: true,
          ),
          child: ElButtonGroup(
            children: [
              const ElButton(child: '选项一'),
              ElButton(
                loading: loading.value,
                child: '选项二',
              ),
              const ElButton(child: '选项三'),
            ],
          ),
        ),
        const Gap(8),
        ElButtonTheme(
          data: const ElButtonThemeData(
            text: true,
            round: true,
            bg: true,
          ),
          child: ElButtonGroup(
            children: [
              const ElButton(child: '选项一'),
              ElButton(
                loading: loading.value,
                child: '选项二',
              ),
              const ElButton(child: '选项三'),
            ],
          ),
        ),
        const Gap(8),
        ElButtonTheme(
          data: const ElButtonThemeData(
            type: El.primary,
          ),
          child: ElButtonGroup(
            children: [
              const ElButton(child: ElIcon(ElIcons.edit)),
              ElButton(
                loading: loading.value,
                child: const ElIcon(ElIcons.share),
              ),
              const ElButton(child: ElIcon(ElIcons.delete)),
            ],
          ),
        ),
        const Gap(8),
        ElButtonTheme(
          data: const ElButtonThemeData(
            type: El.primary,
            block: true,
            round: true,
          ),
          child: ElButtonGroup(
            children: [
              const ElButton(child: '选项一'),
              ElButton(
                loading: loading.value,
                child: '选项二',
                block: false,
              ),
              const ElButton(child: '选项三', flex: 2),
            ],
          ),
        ),
      ],
    );
  }
}

class _Example2 extends HookWidget {
  const _Example2();

  @override
  Widget build(BuildContext context) {
    final loading = useState(false);
    void openLoading() {
      loading.value = true;
      setTimeout(() {
        loading.value = false;
      }, 1000);
    }

    return ElButtonTheme(
      data: ElButtonThemeData(
        loadingBuilder: loadingBuilder,
      ),
      child: Row(
        children: [
          ElButtonGroup(
            axis: Axis.vertical,
            children: [
              const ElButton(child: '选项一'),
              ElButton(
                loading: loading.value,
                child: '选项二',
              ),
              const ElButton(child: '选项三'),
            ],
          ),
          const Gap(8),
          ElButtonTheme(
            data: const ElButtonThemeData(
              plain: true,
            ),
            child: ElButtonGroup(
              axis: Axis.vertical,
              children: [
                const ElButton(child: '选项一'),
                ElButton(
                  loading: loading.value,
                  child: '选项二',
                ),
                const ElButton(child: '选项三'),
              ],
            ),
          ),
          const Gap(8),
          ElButtonTheme(
            data: const ElButtonThemeData(
              type: El.primary,
            ),
            child: ElButtonGroup(
              axis: Axis.vertical,
              children: [
                const ElButton(child: '选项一'),
                ElButton(
                  loading: loading.value,
                  child: '选项二',
                ),
                const ElButton(child: '选项三'),
              ],
            ),
          ),
          const Gap(8),
          ElButtonTheme(
            data: const ElButtonThemeData(
              type: El.success,
              plain: true,
              round: true,
            ),
            child: ElButtonGroup(
              axis: Axis.vertical,
              children: [
                const ElButton(child: '选项一'),
                ElButton(
                  loading: loading.value,
                  child: '选项二',
                ),
                const ElButton(child: '选项三'),
              ],
            ),
          ),
          const Gap(8),
          ElButtonTheme(
            data: const ElButtonThemeData(
              text: true,
            ),
            child: ElButtonGroup(
              axis: Axis.vertical,
              children: [
                const ElButton(child: '选项一'),
                ElButton(
                  loading: loading.value,
                  child: '选项二',
                ),
                const ElButton(child: '选项三'),
              ],
            ),
          ),
          const Gap(8),
          ElButtonTheme(
            data: const ElButtonThemeData(
              text: true,
              round: true,
              bg: true,
            ),
            child: ElButtonGroup(
              axis: Axis.vertical,
              children: [
                const ElButton(child: '选项一'),
                ElButton(
                  loading: loading.value,
                  child: '选项二',
                ),
                const ElButton(child: '选项三'),
              ],
            ),
          ),
          const Gap(8),
          ElButtonTheme(
            data: const ElButtonThemeData(
              type: El.primary,
            ),
            child: ElButtonGroup(
              axis: Axis.vertical,
              children: [
                const ElButton(child: ElIcon(ElIcons.edit)),
                ElButton(
                  loading: loading.value,
                  child: const ElIcon(ElIcons.share),
                ),
                const ElButton(child: ElIcon(ElIcons.delete)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

String get code => '''
class _Example extends StatelessWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        // 基础使用
        ElButtonGroup(
          children: [
            ElButton(child: '选项一'),
            ElButton(child: '选项二'),
            ElButton(child: '选项三'),
          ],
        ),
        Gap(8),
        // 使用 ElButtonTheme 设置主题
        ElButtonTheme(
          data: ElButtonThemeData(
            type: El.primary,
          ),
          child: ElButtonGroup(
            children: [
              ElButton(child: '选项一'),
              ElButton(child: '选项二'),
              ElButton(child: '选项三'),
            ],
          ),
        ),
        Gap(8),
        // 使用 block 属性实现 flex 弹性布局
        ElButtonTheme(
          data: ElButtonThemeData(
            type: El.primary,
            block: true,
            round: true,
          ),
          child: ElButtonGroup(
            children: [
              ElButton(child: '选项一'),
              ElButton(child: '选项二', block: false),
              ElButton(child: '选项三', flex: 2),
            ],
          ),
        ),
        Gap(8),
        // 垂直按钮组
        const ElButtonGroup(
          axis: Axis.vertical,
          children: [
            ElButton(child: '选项一'),
            ElButton(child: '选项二'),
            ElButton(child: '选项三'),
          ],
        ),
      ],
    );
  }
}''';
