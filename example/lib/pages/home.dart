import 'package:flutter/material.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';

import '../store.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool disabled = false;
  bool loading = false;
  int count = 0;
  int selectIndex = 0;

  VoidCallback? get onPressed => disabled
      ? null
      : () => {
            setState(() {
              count++;
            })
          };

  String get childText => 'count: $count';

  String get loadingText => loading ? '加载中...' : '显示loading';

  VoidCallback? get onLoading => loading
      ? null
      : () => {
            setState(() {
              loading = true;
              Future.delayed(const Duration(milliseconds: 2000), () {
                if (mounted) {
                  setState(() {
                    loading = false;
                  });
                }
              });
            })
          };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 8),
            ElButton(
              disabled ? 'Enabled' : 'Disabled',
              onPressed: () {
                setState(() {
                  disabled = !disabled;
                });
              },
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElButton(
                  onPressed: onPressed,
                  childText,
                  tooltip: '这是基础按钮',
                  disabledTooltip: '按钮已被禁用',
                ),
                ValueListenableBuilder(
                  valueListenable: GlobalStore.counter,
                  builder: (context, value, _) => ElButton(
                    'count: ${GlobalStore.counter.value}',
                    onPressed: () {
                      GlobalStore.counter.value++;
                    },
                  ),
                ),
                ElButton(onPressed: onPressed, type: ElThemeType.primary, childText),
                ElButton(onPressed: onPressed, type: ElThemeType.success, childText),
                ElButton(onPressed: onPressed, type: ElThemeType.info, childText),
                ElButton(onPressed: onPressed, type: ElThemeType.warning, childText),
                ElButton(onPressed: onPressed, type: ElThemeType.error, childText),
                ElIconButton(const ElIcon(Icons.search), onPressed: onPressed),
                ElIconButton(const ElIcon(Icons.edit_calendar_outlined), onPressed: onPressed, type: ElThemeType.primary),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElButton(onPressed: onPressed, plain: true, childText),
                ElButton(onPressed: onPressed, type: ElThemeType.primary, plain: true, childText),
                ElButton(onPressed: onPressed, type: ElThemeType.success, plain: true, childText),
                ElButton(onPressed: onPressed, type: ElThemeType.info, plain: true, childText),
                ElButton(onPressed: onPressed, type: ElThemeType.warning, plain: true, childText),
                ElButton(onPressed: onPressed, type: ElThemeType.error, plain: true, childText),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElButton(onPressed: onPressed, round: true, childText),
                ElButton(onPressed: onPressed, type: ElThemeType.primary, round: true, childText),
                ElButton(onPressed: onPressed, type: ElThemeType.success, round: true, childText),
                ElButton(onPressed: onPressed, type: ElThemeType.info, round: true, childText),
                ElButton(onPressed: onPressed, type: ElThemeType.warning, round: true, childText),
                ElButton(onPressed: onPressed, type: ElThemeType.error, round: true, childText),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElTextButton('Default', onPressed: onPressed),
                ElTextButton('Primary', onPressed: onPressed, type: ElThemeType.primary),
                ElTextButton('Success', onPressed: onPressed, type: ElThemeType.success),
                ElTextButton('Info', onPressed: onPressed, type: ElThemeType.info),
                ElTextButton('Warning', onPressed: onPressed, type: ElThemeType.warning),
                ElTextButton('Error', onPressed: onPressed, type: ElThemeType.error),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElTextButton('Default', onPressed: onPressed, bg: true),
                ElTextButton('Primary', onPressed: onPressed, type: ElThemeType.primary, bg: true),
                ElTextButton('Success', onPressed: onPressed, type: ElThemeType.success, bg: true),
                ElTextButton('Info', onPressed: onPressed, type: ElThemeType.info, bg: true),
                ElTextButton('Warning', onPressed: onPressed, type: ElThemeType.warning, bg: true),
                ElTextButton('Error', onPressed: onPressed, type: ElThemeType.error, bg: true),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElIconButton(const ElIcon(Icons.search), onPressed: onPressed),
                ElIconButton(const ElIcon(Icons.edit_calendar_outlined), onPressed: onPressed, type: ElThemeType.primary),
                ElIconButton(const ElIcon(Icons.check), onPressed: onPressed, type: ElThemeType.success),
                ElIconButton(const ElIcon(Icons.email_outlined), onPressed: onPressed, type: ElThemeType.info),
                ElIconButton(const ElIcon(Icons.delete), onPressed: onPressed, type: ElThemeType.warning),
                ElIconButton(const ElIcon(Icons.access_alarm), onPressed: onPressed, type: ElThemeType.error),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElIconButton(const ElIcon(Icons.search), onPressed: onPressed, circle: true),
                ElIconButton(const ElIcon(Icons.edit_calendar_outlined), onPressed: onPressed, type: ElThemeType.primary, circle: true),
                ElIconButton(const ElIcon(Icons.check), onPressed: onPressed, type: ElThemeType.success, circle: true),
                ElIconButton(const ElIcon(Icons.email_outlined), onPressed: onPressed, type: ElThemeType.info, circle: true),
                ElIconButton(const ElIcon(Icons.delete), onPressed: onPressed, type: ElThemeType.warning, circle: true),
                ElIconButton(const ElIcon(Icons.access_alarm), onPressed: onPressed, type: ElThemeType.error, circle: true),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElButton(onPressed: onPressed, childText, leftIcon: Icons.arrow_back_ios),
                ElButton(onPressed: onPressed, childText, rightIcon: Icons.arrow_forward_ios),
                ElButton(onPressed: onPressed, type: ElThemeType.primary, childText, leftIcon: Icons.arrow_back_ios),
                ElButton(onPressed: onPressed, type: ElThemeType.success, childText, rightIcon: Icons.arrow_forward_ios),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElButton(onPressed: onLoading, loadingText, loading: loading),
                ElButton(onPressed: onLoading, type: ElThemeType.primary, loadingText, loading: loading),
                ElButton(
                  onPressed: onLoading,
                  type: ElThemeType.success,
                  loadingText,
                  loading: loading,
                  round: true,
                  loadingBuilder: (color) => SizedBox(
                    width: 14,
                    height: 14,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: color,
                    ),
                  ),
                ),
                ElTextButton(onPressed: onLoading, loadingText, loading: loading),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElIconButton(onPressed: onLoading, const ElIcon(Icons.check), loading: loading),
                ElIconButton(onPressed: onLoading, type: ElThemeType.primary, const ElIcon(Icons.check), loading: loading),
                ElIconButton(onPressed: onLoading, const ElIcon(Icons.check), loading: loading, circle: true),
                ElIconButton(onPressed: onLoading, type: ElThemeType.primary, const ElIcon(Icons.check), loading: loading, circle: true),
              ],
            ),
            // const SizedBox(height: 8),
            // const ElButtonGroup(
            //   children: [
            //     ElButton(key: ValueKey(0), 'Item 1'),
            //     ElButton(key: ValueKey(1), 'Item 2'),
            //     ElButton(key: ValueKey(2), 'Item 3'),
            //   ],
            // ),
            // const SizedBox(height: 8),
            // const ElButtonGroup(
            //   type: ElThemeType.primary,
            //   children: [
            //     ElButton(key: ValueKey(0), 'Item 1'),
            //     ElButton(key: ValueKey(1), 'Item 2'),
            //     ElButton(key: ValueKey(2), 'Item 3'),
            //   ],
            // ),
            // const SizedBox(height: 8),
            // ElButtonGroup.single(
            //   index: selectIndex,
            //   onChange: (index) {
            //     setState(() {
            //       selectIndex = index;
            //     });
            //   },
            //   children: const [
            //     ElButton(key: ValueKey(0), 'Previous Page', leftIcon: Icons.arrow_back_ios),
            //     ElButton(key: ValueKey(1), 'Next Page', rightIcon: Icons.arrow_forward_ios),
            //   ],
            // ),
            // const SizedBox(height: 8),
            // ElButtonGroup.single(
            //   type: ElThemeType.primary,
            //   index: selectIndex,
            //   onChange: (index) {
            //     setState(() {
            //       selectIndex = index;
            //     });
            //   },
            //   children: const [
            //     ElButton(key: ValueKey(0), 'Previous Page', leftIcon: Icons.arrow_back_ios),
            //     ElButton(key: ValueKey(1), 'Next Page', rightIcon: Icons.arrow_forward_ios),
            //   ],
            // ),
            // const SizedBox(height: 8),
            // const ElButtonGroup(
            //   // type: ElThemeType.primary,
            //   children: [
            //     ElTextButton(key: ValueKey(0), 'Item 1'),
            //     ElTextButton(key: ValueKey(1), 'Item 2'),
            //     ElTextButton(key: ValueKey(2), 'Item 3'),
            //   ],
            // ),
            // const SizedBox(height: 8),
            // const ElButtonGroup(
            //   children: [
            //     ElIconButton(key: ValueKey(0), ElIcon(Icons.email_outlined)),
            //     ElIconButton(key: ValueKey(1), ElIcon(Icons.access_alarm)),
            //     ElIconButton(key: ValueKey(2), ElIcon(Icons.edit_calendar_outlined)),
            //   ],
            // ),
            // const SizedBox(height: 8),
            // const ElButtonGroup(
            //   type: ElThemeType.primary,
            //   children: [
            //     ElIconButton(key: ValueKey(0), ElIcon(Icons.email_outlined)),
            //     ElIconButton(key: ValueKey(1), ElIcon(Icons.access_alarm)),
            //     ElIconButton(key: ValueKey(2), ElIcon(Icons.edit_calendar_outlined)),
            //   ],
            // ),
            // const SizedBox(height: 8),
            // ElButtonGroup.single(
            //   index: selectIndex,
            //   onChange: (index) {
            //     setState(() {
            //       selectIndex = index;
            //     });
            //   },
            //   children: const [
            //     ElIconButton(key: ValueKey(0), ElIcon(Icons.email_outlined)),
            //     ElIconButton(key: ValueKey(1), ElIcon(Icons.access_alarm)),
            //   ],
            // ),
            // const SizedBox(height: 8),
            // ElButtonGroup.single(
            //   type: ElThemeType.primary,
            //   index: selectIndex,
            //   onChange: (index) {
            //     setState(() {
            //       selectIndex = index;
            //     });
            //   },
            //   children: const [
            //     ElIconButton(key: ValueKey(0), ElIcon(Icons.email_outlined)),
            //     ElIconButton(key: ValueKey(1), ElIcon(Icons.access_alarm)),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
