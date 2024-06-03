import 'package:example/global.dart';
import 'package:flutter/material.dart';

class ButtonPage extends HookWidget {
  const ButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useScrollController();
    final (count, addCount) = useCount();
    final (disabled, toggleDisabled) = useToggle();
    return ElScrollbar(
      controller: controller,
      child: SingleChildScrollView(
        controller: controller,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ElButton(disabled ? 'Enabled' : 'Disabled', onClick: toggleDisabled),
                  ElButton('你好'),
                ],
              ),
              const Gap(12),
              Text('普通按钮', style: context.h3),
              const Gap(8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ElButton(
                    'Default: $count',
                    onClick: addCount,
                    style: ElButtonStyle(disabled: disabled),
                  ),
                  ElButton(
                    'Primary: $count',
                    onClick: addCount,
                    style: ElButtonStyle(type: ElThemeType.primary, disabled: disabled),
                  ),
                  ElButton(
                    'Success: $count',
                    onClick: addCount,
                    style: ElButtonStyle(type: ElThemeType.success, disabled: disabled),
                  ),
                  ElButton(
                    'Info: $count',
                    onClick: addCount,
                    style: ElButtonStyle(type: ElThemeType.info, disabled: disabled),
                  ),
                  ElButton(
                    'Warning: $count',
                    onClick: addCount,
                    style: ElButtonStyle(type: ElThemeType.warning, disabled: disabled),
                  ),
                  ElButton(
                    'Error: $count',
                    onClick: addCount,
                    style: ElButtonStyle(type: ElThemeType.error, disabled: disabled),
                  ),
                ],
              ),
              const Gap(12),
              Text('镂空按钮', style: context.h3),
              const Gap(8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ElButton(
                    'Default: $count',
                    onClick: addCount,
                    style: ElButtonStyle(disabled: disabled),
                  ),
                  ElButton(
                    'Primary: $count',
                    onClick: addCount,
                    style: ElButtonStyle(type: ElThemeType.primary, plain: true, disabled: disabled),
                  ),
                  ElButton(
                    'Success: $count',
                    onClick: addCount,
                    style: ElButtonStyle(type: ElThemeType.success, plain: true, disabled: disabled),
                  ),
                  ElButton(
                    'Info: $count',
                    onClick: addCount,
                    style: ElButtonStyle(type: ElThemeType.info, plain: true, disabled: disabled),
                  ),
                  ElButton(
                    'Warning: $count',
                    onClick: addCount,
                    style: ElButtonStyle(type: ElThemeType.warning, plain: true, disabled: disabled),
                  ),
                  ElButton(
                    'Error: $count',
                    onClick: addCount,
                    style: ElButtonStyle(type: ElThemeType.error, plain: true, disabled: disabled),
                  ),
                ],
              ),
              const Gap(12),
              Text('圆角按钮', style: context.h3),
              const Gap(8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ElButton(
                    'Default: $count',
                    onClick: addCount,
                    style: ElButtonStyle(disabled: disabled),
                  ),
                  ElButton(
                    'Primary: $count',
                    onClick: addCount,
                    style: ElButtonStyle(type: ElThemeType.primary, round: true, disabled: disabled),
                  ),
                  ElButton(
                    'Success: $count',
                    onClick: addCount,
                    style: ElButtonStyle(type: ElThemeType.success, round: true, disabled: disabled),
                  ),
                  ElButton(
                    'Info: $count',
                    onClick: addCount,
                    style: ElButtonStyle(type: ElThemeType.info, round: true, disabled: disabled),
                  ),
                  ElButton(
                    'Warning: $count',
                    onClick: addCount,
                    style: ElButtonStyle(type: ElThemeType.warning, round: true, disabled: disabled),
                  ),
                  ElButton(
                    'Error: $count',
                    onClick: addCount,
                    style: ElButtonStyle(type: ElThemeType.error, round: true, disabled: disabled),
                  ),
                ],
              ),
              const Gap(12),
              Text('圆角镂空按钮', style: context.h3),
              const Gap(8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ElButton(
                    'Default: $count',
                    onClick: addCount,
                    style: ElButtonStyle(disabled: disabled),
                  ),
                  ElButton(
                    'Primary: $count',
                    onClick: addCount,
                    style: ElButtonStyle(type: ElThemeType.primary, plain: true, round: true, disabled: disabled),
                  ),
                  ElButton(
                    'Success: $count',
                    onClick: addCount,
                    style: ElButtonStyle(type: ElThemeType.success, plain: true, round: true, disabled: disabled),
                  ),
                  ElButton(
                    'Info: $count',
                    style: ElButtonStyle(type: ElThemeType.info, plain: true, round: true, disabled: disabled),
                  ),
                  ElButton(
                    'Warning: $count',
                    onClick: addCount,
                    style: ElButtonStyle(type: ElThemeType.warning, plain: true, round: true, disabled: disabled),
                  ),
                  ElButton(
                    'Error: $count',
                    onClick: addCount,
                    style: ElButtonStyle(type: ElThemeType.error, plain: true, round: true, disabled: disabled),
                  ),
                ],
              ),
              const Gap(12),
              Text('文字按钮', style: context.h3),
              const Gap(8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ElButton(
                    'Default: $count',
                    onClick: addCount,
                    style: ElButtonStyle(text: true, disabled: disabled),
                  ),
                  ElButton(
                    'Primary: $count',
                    onClick: addCount,
                    style: ElButtonStyle(type: ElThemeType.primary, text: true, disabled: disabled),
                  ),
                  ElButton(
                    'Success: $count',
                    onClick: addCount,
                    style: ElButtonStyle(type: ElThemeType.success, text: true, disabled: disabled),
                  ),
                  ElButton(
                    'Info: $count',
                    onClick: addCount,
                    style: ElButtonStyle(type: ElThemeType.info, text: true, disabled: disabled),
                  ),
                  ElButton(
                    'Warning: $count',
                    onClick: addCount,
                    style: ElButtonStyle(type: ElThemeType.warning, text: true, disabled: disabled),
                  ),
                  ElButton(
                    'Error: $count',
                    onClick: addCount,
                    style: ElButtonStyle(type: ElThemeType.error, text: true, disabled: disabled),
                  ),
                ],
              ),
              const Gap(12),
              Text('文字圆角按钮', style: context.h3),
              const Gap(8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ElButton(
                    'Default: $count',
                    onClick: addCount,
                    style: ElButtonStyle(text: true, round: true, disabled: disabled),
                  ),
                  ElButton(
                    'Primary: $count',
                    onClick: addCount,
                    style: ElButtonStyle(type: ElThemeType.primary, text: true, round: true, disabled: disabled),
                  ),
                  ElButton(
                    'Success: $count',
                    onClick: addCount,
                    style: ElButtonStyle(type: ElThemeType.success, text: true, round: true, disabled: disabled),
                  ),
                  ElButton(
                    'Info: $count',
                    onClick: addCount,
                    style: ElButtonStyle(type: ElThemeType.info, text: true, round: true, disabled: disabled),
                  ),
                  ElButton(
                    'Warning: $count',
                    onClick: addCount,
                    style: ElButtonStyle(type: ElThemeType.warning, text: true, round: true, disabled: disabled),
                  ),
                  ElButton(
                    'Error: $count',
                    onClick: addCount,
                    style: ElButtonStyle(type: ElThemeType.error, text: true, round: true, disabled: disabled),
                  ),
                ],
              ),
              const Gap(12),
              Text('图标按钮', style: context.h3),
              const Gap(8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ElButton(
                    ElIcon.svg(ElIcons.aim),
                    style: ElButtonStyle(disabled: disabled),
                  ),
                  ElButton(
                    ElIcon.svg(ElIcons.aim),
                    style: ElButtonStyle(type: ElThemeType.primary, disabled: disabled),
                  ),
                  ElButton(
                    ElIcon.svg(ElIcons.aim),
                    style: ElButtonStyle(type: ElThemeType.success, disabled: disabled),
                  ),
                  ElButton(
                    ElIcon.svg(ElIcons.aim),
                    style: ElButtonStyle(type: ElThemeType.info, disabled: disabled),
                  ),
                  ElButton(
                    ElIcon.svg(ElIcons.aim),
                    style: ElButtonStyle(type: ElThemeType.warning, disabled: disabled),
                  ),
                  ElButton(
                    ElIcon.svg(ElIcons.aim),
                    style: ElButtonStyle(type: ElThemeType.error, disabled: disabled),
                  ),
                ],
              ),
              const Gap(12),
              Text('块级按钮', style: context.h3),
              const Gap(8),
              ElButton(
                'Default',
                style: ElButtonStyle(block: true, disabled: disabled),
              ),
              const Gap(8),
              ElButton(
                'Primary',
                style: ElButtonStyle(type: ElThemeType.primary, block: true, disabled: disabled),
              ),
              const Gap(8),
              ElButton(
                'Success',
                style: ElButtonStyle(type: ElThemeType.success, block: true, disabled: disabled),
              ),
              const Gap(8),
              ElButton(
                'Info',
                style: ElButtonStyle(type: ElThemeType.info, block: true, disabled: disabled),
              ),
              const Gap(8),
              ElButton(
                'Warning',
                style: ElButtonStyle(type: ElThemeType.warning, block: true, disabled: disabled),
              ),
              const Gap(8),
              ElButton(
                'Error',
                style: ElButtonStyle(type: ElThemeType.error, block: true, disabled: disabled),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
