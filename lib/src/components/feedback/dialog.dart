part of flutter_element_ui;

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
    ElThemeType? cancelButtonType,
    ElThemeType confirmButtonType = ElThemeType.primary,
    Function? onCancel,
    Function? onConfirm,
  }) async {
    return await showDialog<bool>(
        context: context,
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
                      cancelText,
                      type: cancelButtonType,
                      disabled: loading,
                      onPressed: () {
                        if (onCancel != null) onCancel();
                        if (context.mounted) Navigator.of(context).pop(false);
                      },
                    ),
                  const SizedBox(width: 8),
                  if (confirmText != '')
                    ElButton(
                      loading ? confirmLoadingText : confirmText,
                      type: confirmButtonType,
                      disabled: loading,
                      loading: loading,
                      onPressed: () async {
                        if (onConfirm != null) {
                          setState(() => loading = true);
                          await onConfirm();
                        }
                        if (context.mounted) Navigator.of(context).pop(true);
                      },
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
          color: context.appTheme.cardColor,
          borderRadius: BorderRadius.circular(context.elConfig.cardRadius),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null)
              Text(
                title!,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
