import 'package:flutter/material.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool disabled = false;
  bool loading = false;
  int count = 0;

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
                ElButton(onPressed: onPressed, type: ElThemeType.primary, childText),
                ElButton(onPressed: onPressed, type: ElThemeType.success, childText),
                ElButton(onPressed: onPressed, type: ElThemeType.info, childText),
                ElButton(onPressed: onPressed, type: ElThemeType.warning, childText),
                ElButton(onPressed: onPressed, type: ElThemeType.error, childText),
                ElButton.icon(Icons.search, onPressed: onPressed),
                ElButton.icon(Icons.edit_calendar_outlined, onPressed: onPressed, type: ElThemeType.primary),
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
                ElButton.icon(Icons.search, onPressed: onPressed),
                ElButton.icon(Icons.edit_calendar_outlined, onPressed: onPressed, type: ElThemeType.primary),
                ElButton.icon(Icons.check, onPressed: onPressed, type: ElThemeType.success),
                ElButton.icon(Icons.email_outlined, onPressed: onPressed, type: ElThemeType.info),
                ElButton.icon(Icons.delete, onPressed: onPressed, type: ElThemeType.warning),
                ElButton.icon(Icons.access_alarm, onPressed: onPressed, type: ElThemeType.error),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElButton.icon(Icons.search, onPressed: onPressed, circle: true),
                ElButton.icon(Icons.edit_calendar_outlined, onPressed: onPressed, type: ElThemeType.primary, circle: true),
                ElButton.icon(Icons.check, onPressed: onPressed, type: ElThemeType.success, circle: true),
                ElButton.icon(Icons.email_outlined, onPressed: onPressed, type: ElThemeType.info, circle: true),
                ElButton.icon(Icons.delete, onPressed: onPressed, type: ElThemeType.warning, circle: true),
                ElButton.icon(Icons.access_alarm, onPressed: onPressed, type: ElThemeType.error, circle: true),
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
                ElButton.icon(onPressed: onLoading, Icons.check, loading: loading),
                ElButton.icon(onPressed: onLoading, type: ElThemeType.primary, Icons.check, loading: loading),
                ElButton.icon(onPressed: onLoading, Icons.check, loading: loading, circle: true),
                ElButton.icon(onPressed: onLoading, type: ElThemeType.primary, Icons.check, loading: loading, circle: true),
              ],
            ),
            const SizedBox(height: 8),
            ElButtonGroup(
              children: [
                ElButton(
                  'Previous Page',
                  leftIcon: Icons.arrow_back_ios,
                  onPressed: () {},
                ),
                ElButton(
                  'Next Page',
                  rightIcon: Icons.arrow_forward_ios,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
