part of '../service.dart';

mixin _ToastService {
  OverlayEntry? _toastOverlayEntry;
  Timer? _removeToastTimer;

  /// 在页面上显示轻提示，[ElToast] 适用于移动端，[ElMessage] 适合桌面端
  /// * duration 持续时间，单位毫秒
  /// * type 主题类型，默认在屏幕中间显示半透明深色提示，而主题类型 toast 则显示在底部
  /// * bottomOffset 当使用 type 时，自定义 toast 的底部偏移值
  /// * builder 自定义构建 toast 小部件
  void showToast(
    dynamic content, {
    int duration = 3000,
    String? type,
    double bottomOffset = 80,
    Widget Function(dynamic content)? builder,
  }) async {
    removeToast();
    if (_removeToastTimer != null) {
      _removeToastTimer!.cancel();
      _removeToastTimer = null;
    }
    await 0.05.delay();
    _toastOverlayEntry = OverlayEntry(builder: (context) {
      if (builder == null) {
        return type == null
            ? _Toast(content)
            : _ThemeToast(content, type, bottomOffset);
      } else {
        return builder(content);
      }
    });
    if ($el.overlayContext.mounted) {
      Overlay.of($el.overlayContext).insert(_toastOverlayEntry!);
      _removeToastTimer = removeToast.delay(duration);
    }
  }

  void removeToast() {
    if (_toastOverlayEntry != null) {
      _toastOverlayEntry!.remove();
      _toastOverlayEntry = null;
    }
  }
}

class _Toast extends StatelessWidget {
  const _Toast(this.content);

  final dynamic content;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: $el.removeToast,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: context.isDark
                ? const Color.fromRGBO(82, 82, 82, 0.85)
                : const Color.fromRGBO(0, 0, 0, 0.65),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            '$content',
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
            ),
          ),
        ),
      ),
    );
  }
}

class _ThemeToast extends StatelessWidget {
  const _ThemeToast(this.content, this.type, this.bottomOffset);

  final dynamic content;
  final String type;
  final double bottomOffset;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 50,
        vertical: bottomPadding >= bottomOffset
            ? bottomPadding + bottomOffset / 2
            : bottomOffset,
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          onTap: $el.removeToast,
          child: UnconstrainedBox(
            child: Material(
              elevation: 1,
              borderRadius: BorderRadius.circular(200.0),
              clipBehavior: Clip.antiAlias,
              child: Container(
                  padding: const EdgeInsets.fromLTRB(24, 10, 24, 10),
                  alignment: Alignment.center,
                  decoration:
                      BoxDecoration(color: context.themeTypeColors[type]),
                  child: Text(
                    '$content',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
