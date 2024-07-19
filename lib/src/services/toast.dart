part of '../service.dart';

mixin _ToastService {
  OverlayEntry? _overlayEntry;
  Timer? _removeToastTimer;

  /// 在页面上显示轻提示，[ElToast] 适用于移动端，[ElMessage] 适合桌面端
  void showToast(
    dynamic content, {
    int duration = 3000,
  }) async {
    hideToast();
    if (_removeToastTimer != null) {
      _removeToastTimer!.cancel();
      _removeToastTimer = null;
    }
    await 0.05.delay();
    _overlayEntry = OverlayEntry(builder: (context) {
      return Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: context.isDark
                ? const Color.fromRGBO(82, 82, 82, 0.75)
                : const Color.fromRGBO(0, 0, 0, 0.75),
            borderRadius: BorderRadius.circular(6),
          ),
          child: ElText(
            '$content',
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
            ),
          ),
        ),
      );
    });
    if ($el.context.mounted) {
      Overlay.of($el.context, rootOverlay: true).insert(_overlayEntry!);
      _removeToastTimer = hideToast.delay(duration);
    }
  }

  void hideToast() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }
}
