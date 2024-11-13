part of 'index.dart';

class ElToastService {
  OverlayEntry? _toastOverlayEntry;
  Timer? _removeToastTimer;

  /// 显示轻提示，默认风格是中间显示半透明的黑底白字一段文本
  /// * context 默认使用全局context，如果你需要让它作用于局部页面，请传递当前context
  /// * duration 持续时间，单位毫秒
  /// * type 主题类型，如果不为空，将构建 [_ThemeToast]
  /// * offset 自定义 toast 的底部偏移值
  /// * builder 自定义构建 toast 小部件，支持全局配置
  void show(
    dynamic content, {
    BuildContext? context,
    int? duration,
    String? type,
    bool? enabledFeedback,
    ElToastBuilder? builder,
  }) async {
    final $context = context ?? el.context;
    await _beforeHook($context, enabledFeedback);
    _toastOverlayEntry = OverlayEntry(builder: (context) {
      return builder != null
          ? builder($context, content)
          : $context.elTheme.toastTheme.builder != null
              ? $context.elTheme.toastTheme.builder!($context, content)
              : type == null
                  ? _Toast(content)
                  : _ThemeToast(content, type);
    });
    if ($context.mounted) _afterHook($context, duration);
  }

  /// primary 主题轻提示
  void primary(
    dynamic content, {
    BuildContext? context,
    int? duration,
    bool? enabledFeedback,
  }) async {
    final $context = context ?? el.context;
    await _beforeHook($context, enabledFeedback);
    _toastOverlayEntry = OverlayEntry(
      builder: (context) => _ThemeToast(content, 'primary'),
    );
    if ($context.mounted) _afterHook($context, duration);
  }

  /// success 主题轻提示
  void success(
    dynamic content, {
    BuildContext? context,
    int? duration,
    bool? enabledFeedback,
  }) async {
    final $context = context ?? el.context;
    await _beforeHook($context, enabledFeedback);
    _toastOverlayEntry = OverlayEntry(
      builder: (context) => _ThemeToast(content, 'success'),
    );
    if ($context.mounted) _afterHook($context, duration);
  }

  /// info 主题轻提示
  void info(
    dynamic content, {
    BuildContext? context,
    int? duration,
    bool? enabledFeedback,
  }) async {
    final $context = context ?? el.context;
    await _beforeHook($context, enabledFeedback);
    _toastOverlayEntry = OverlayEntry(
      builder: (context) => _ThemeToast(content, 'info'),
    );
    if ($context.mounted) _afterHook($context, duration);
  }

  /// warning 主题轻提示
  void warning(
    dynamic content, {
    BuildContext? context,
    int? duration,
    bool? enabledFeedback,
  }) async {
    final $context = context ?? el.context;
    await _beforeHook($context, enabledFeedback);
    _toastOverlayEntry = OverlayEntry(
      builder: (context) => _ThemeToast(content, 'warning'),
    );
    if ($context.mounted) _afterHook($context, duration);
  }

  /// error 主题轻提示
  void error(
    dynamic content, {
    BuildContext? context,
    int? duration,
    bool? enabledFeedback,
  }) async {
    final $context = context ?? el.context;
    await _beforeHook($context, enabledFeedback);
    _toastOverlayEntry = OverlayEntry(
      builder: (context) => _ThemeToast(content, 'error'),
    );
    if ($context.mounted) _afterHook($context, duration);
  }

  /// 自定义构建轻提示
  void builder(
    dynamic content,
    Widget Function(dynamic content) builder, {
    BuildContext? context,
    int? duration,
    bool? enabledFeedback,
  }) async {
    final $context = context ?? el.context;
    await _beforeHook($context, enabledFeedback);
    _toastOverlayEntry = OverlayEntry(builder: (context) => builder(content));
    if ($context.mounted) _afterHook($context, duration);
  }

  Future<void> _beforeHook(BuildContext context, bool? enabledFeedback) async {
    if (enabledFeedback ?? context.elTheme.toastTheme.enableFeedback) {
      HapticFeedback.mediumImpact();
    }
    remove();
    if (_removeToastTimer != null) {
      _removeToastTimer!.cancel();
      _removeToastTimer = null;
    }
    await 50.ms.delay();
  }

  void _afterHook(BuildContext context, int? duration) {
    Overlay.of(context).insert(_toastOverlayEntry!);
    _removeToastTimer = setTimeout(
      remove,
      duration ?? context.elTheme.toastTheme.closeDuration,
    );
  }

  /// 移除当前轻提示
  void remove() {
    if (_toastOverlayEntry != null) {
      _toastOverlayEntry!.remove();
      _toastOverlayEntry = null;
    }
  }
}
