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
    return Scaffold(
      appBar: AppBar(
        title: const Text('首页'),
      ),
      body: Center(
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
                ElButton.icon(const ElIcon(Icons.search), onPressed: onPressed),
                ElButton.icon(const ElIcon(Icons.edit_calendar_outlined), onPressed: onPressed, type: ElThemeType.primary),
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
                ElButton.text('Default', onPressed: onPressed),
                ElButton.text('Primary', onPressed: onPressed, type: ElThemeType.primary),
                ElButton.text('Success', onPressed: onPressed, type: ElThemeType.success),
                ElButton.text('Info', onPressed: onPressed, type: ElThemeType.info),
                ElButton.text('Warning', onPressed: onPressed, type: ElThemeType.warning),
                ElButton.text('Error', onPressed: onPressed, type: ElThemeType.error),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElButton.text('Default', onPressed: onPressed, bg: true),
                ElButton.text('Primary', onPressed: onPressed, type: ElThemeType.primary, bg: true),
                ElButton.text('Success', onPressed: onPressed, type: ElThemeType.success, bg: true),
                ElButton.text('Info', onPressed: onPressed, type: ElThemeType.info, bg: true),
                ElButton.text('Warning', onPressed: onPressed, type: ElThemeType.warning, bg: true),
                ElButton.text('Error', onPressed: onPressed, type: ElThemeType.error, bg: true),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElButton.icon(const ElIcon(Icons.search), onPressed: onPressed),
                ElButton.icon(const ElIcon(Icons.edit_calendar_outlined), onPressed: onPressed, type: ElThemeType.primary),
                ElButton.icon(const ElIcon(Icons.check), onPressed: onPressed, type: ElThemeType.success),
                ElButton.icon(const ElIcon(Icons.email_outlined), onPressed: onPressed, type: ElThemeType.info),
                ElButton.icon(const ElIcon(Icons.delete), onPressed: onPressed, type: ElThemeType.warning),
                ElButton.icon(const ElIcon(Icons.access_alarm), onPressed: onPressed, type: ElThemeType.error),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElButton.icon(const ElIcon(Icons.search), onPressed: onPressed, circle: true),
                ElButton.icon(const ElIcon(Icons.edit_calendar_outlined), onPressed: onPressed, type: ElThemeType.primary, circle: true),
                ElButton.icon(const ElIcon(Icons.check), onPressed: onPressed, type: ElThemeType.success, circle: true),
                ElButton.icon(const ElIcon(Icons.email_outlined), onPressed: onPressed, type: ElThemeType.info, circle: true),
                ElButton.icon(const ElIcon(Icons.delete), onPressed: onPressed, type: ElThemeType.warning, circle: true),
                ElButton.icon(const ElIcon(Icons.access_alarm), onPressed: onPressed, type: ElThemeType.error, circle: true),
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
                ElButton.text(onPressed: onLoading, loadingText, loading: loading),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElButton.icon(onPressed: onLoading, const ElIcon(Icons.check), loading: loading),
                ElButton.icon(onPressed: onLoading, type: ElThemeType.primary, const ElIcon(Icons.check), loading: loading),
                ElButton.icon(onPressed: onLoading, const ElIcon(Icons.check), loading: loading, circle: true),
                ElButton.icon(onPressed: onLoading, type: ElThemeType.primary, const ElIcon(Icons.check), loading: loading, circle: true),
              ],
            ),
            const SizedBox(height: 8),
            const ElButtonGroup(
              children: [
                ElButton(key: ValueKey(0), 'Item 1'),
                ElButton(key: ValueKey(1), 'Item 2'),
                ElButton(key: ValueKey(2), 'Item 3'),
              ],
            ),
            const SizedBox(height: 8),
            const ElButtonGroup(
              type: ElThemeType.primary,
              children: [
                ElButton(key: ValueKey(0), 'Item 1'),
                ElButton(key: ValueKey(1), 'Item 2'),
                ElButton(key: ValueKey(2), 'Item 3'),
              ],
            ),
            const SizedBox(height: 8),
            ElButtonGroup.single(
              index: selectIndex,
              onChange: (index) {
                setState(() {
                  selectIndex = index;
                });
              },
              children: const [
                ElButton(key: ValueKey(0), 'Previous Page', leftIcon: Icons.arrow_back_ios),
                ElButton(key: ValueKey(1), 'Next Page', rightIcon: Icons.arrow_forward_ios),
              ],
            ),
            const SizedBox(height: 8),
            ElButtonGroup.single(
              type: ElThemeType.primary,
              index: selectIndex,
              onChange: (index) {
                setState(() {
                  selectIndex = index;
                });
              },
              children: const [
                ElButton(key: ValueKey(0), 'Previous Page', leftIcon: Icons.arrow_back_ios),
                ElButton(key: ValueKey(1), 'Next Page', rightIcon: Icons.arrow_forward_ios),
              ],
            ),
            const SizedBox(height: 8),
            const ElButtonGroup(
              // type: ElThemeType.primary,
              children: [
                ElButton.text(key: ValueKey(0), 'Item 1'),
                ElButton.text(key: ValueKey(1), 'Item 2'),
                ElButton.text(key: ValueKey(2), 'Item 3'),
              ],
            ),
            const SizedBox(height: 8),
            const ElButtonGroup(
              children: [
                ElButton.icon(key: ValueKey(0), ElIcon(Icons.email_outlined)),
                ElButton.icon(key: ValueKey(1), ElIcon(Icons.access_alarm)),
                ElButton.icon(key: ValueKey(2), ElIcon(Icons.edit_calendar_outlined)),
              ],
            ),
            const SizedBox(height: 8),
            const ElButtonGroup(
              type: ElThemeType.primary,
              children: [
                ElButton.icon(key: ValueKey(0), ElIcon(Icons.email_outlined)),
                ElButton.icon(key: ValueKey(1), ElIcon(Icons.access_alarm)),
                ElButton.icon(key: ValueKey(2), ElIcon(Icons.edit_calendar_outlined)),
              ],
            ),
            const SizedBox(height: 8),
            ElButtonGroup.single(
              index: selectIndex,
              onChange: (index) {
                setState(() {
                  selectIndex = index;
                });
              },
              children: const [
                ElButton.icon(key: ValueKey(0), ElIcon(Icons.email_outlined)),
                ElButton.icon(key: ValueKey(1), ElIcon(Icons.access_alarm)),
              ],
            ),
            const SizedBox(height: 8),
            ElButtonGroup.single(
              type: ElThemeType.primary,
              index: selectIndex,
              onChange: (index) {
                setState(() {
                  selectIndex = index;
                });
              },
              children: const [
                ElButton.icon(key: ValueKey(0), ElIcon(Icons.email_outlined)),
                ElButton.icon(key: ValueKey(1), ElIcon(Icons.access_alarm)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
