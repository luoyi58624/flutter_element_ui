import 'package:element_plus/element_plus.dart';
import 'package:flutter/material.dart';
import 'package:element_plus/src/global.dart';

/// Element 对话框组件
class ElDialog extends StatelessWidget {
  /// 示例：
  /// ```dart
  /// showDialog(
  ///   context: context,
  ///   builder: (context) => ElDialog(
  ///     title: 'Dialog标题',
  ///   ),
  /// );
  /// ```
  const ElDialog({
    super.key,
    this.title,
    this.width = 480,
    required this.child,
    this.footer,
  });

  final String? title;
  final double width;
  final Widget child;
  final Widget? footer;

  /// 显示确认弹窗
  static Future<bool?> showConfirm(
    BuildContext context,
    String title,
    String content, {
    String cancelText = '取消',
    String confirmText = '确定',
    String confirmLoadingText = '加载中...',
    String? cancelButtonType,
    String confirmButtonType = El.primary,
    Function? onCancel,
    Function? onConfirm,
  }) async {
    return await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          bool loading = false;
          return ElDialog(
            title: title,
            footer: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) => Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (cancelText != '')
                    ElButton(
                      onPressed: () {
                        if (onCancel != null) onCancel();
                        if (context.mounted) Navigator.of(context).pop(false);
                      },
                      type: cancelButtonType,
                      disabled: loading,
                      child: cancelText,
                    ),
                  const SizedBox(width: 8),
                  if (confirmText != '')
                    ElButton(
                      onPressed: () async {
                        if (onConfirm != null) {
                          setState(() => loading = true);
                          await onConfirm();
                        }
                        if (context.mounted) Navigator.of(context).pop(true);
                      },
                      type: confirmButtonType,
                      disabled: loading,
                      child: loading ? confirmLoadingText : confirmText,
                    ),
                ],
              ),
            ),
            child: Text(content),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: width,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.elTheme.cardTheme.color,
          borderRadius: context.commonSizePreset.cardRadius!,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null)
              Text(
                title!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: child,
            ),
            if (footer != null) footer!
          ],
        ),
      ),
    );
  }
}
