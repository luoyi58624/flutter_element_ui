part of 'index.dart';

class ElDialogService {
  /// 显示默认对话框
  /// * context 对话框默认在顶级路由插入，如果要将其作用于局部，请传递当前 context
  /// * draggable 是否允许拖拽
  /// * modalColor 遮罩层颜色，如果为透明，则不会渲染遮罩层
  /// * closeOnclickModal 点击对话框遮罩层时是否关闭对话框
  /// * closeOnClickOutside 在对话框外部指针按下时是否立即关闭对话框
  /// * allowInteractive 对话框下方内容是否允许交互
  Future<T?> show<T>({
    BuildContext? context,
    Color modalColor = Colors.black38,
    bool draggable = false,
    bool closeOnClickModal = true,
    bool closeOnClickOutside = false,
    bool allowInteractive = false,
  }) async {
    final themeData = el.context.elTheme.dialogTheme.copyWith();

    final $context = context ?? el.context;
    return await Navigator.of($context).push<T>(
      _DialogRoute<T>(
        overlayContext: $context,
        themeData: themeData,
        modalColor: modalColor,
        draggable: draggable,
        closeOnClickModal: closeOnClickModal,
        closeOnClickOutside: closeOnClickOutside,
        allowInteractive: allowInteractive,
      ),
    );
  }
}
