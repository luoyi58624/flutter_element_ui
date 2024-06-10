part of 'loading.dart';

class _LoadingUtil {
  _LoadingUtil._();

  /// 判断当前页面是否已经打开loading，如果有，则下次打开新的loading需要移除上一个loading
  static bool _isShowLoading = false;

  /// 创建loading的时间
  static int _createLoadingStartTime = 0;

  /// loading延迟关闭时间
  static int _delayCloseTime = 0;

  /// 是否显示请求关闭loading提示框
  static bool _isShowConfirm = false;

  static void show(
    String text, {
    int delayClose = 0,
    String cancelText = '你要关闭 Loading 吗?',
    void Function()? onCancel,
  }) async {
    close(true);
    _isShowLoading = true;
    _delayCloseTime = math.max(delayClose, 0);
    _createLoadingStartTime = currentMilliseconds;
    if (elRootContext.mounted) {
      showDialog(
        context: elRootContext,
        barrierColor: Colors.black26,
        builder: (context) {
          return _LoadingModelWidget(
            title: text,
            cancelText: cancelText,
            onCancel: onCancel,
          );
        },
      );
    }
  }

  static Future<void> close([bool? immedClose]) async {
    if (_isShowLoading) {
      if (immedClose == true) {
        _pop();
      } else {
        var delayCloseLoadingTime = math.max<int>(
            (_delayCloseTime - math.min(currentMilliseconds - _createLoadingStartTime, 1000)), 0);
        if (delayCloseLoadingTime <= 0) {
          _pop();
        } else {
          await (delayCloseLoadingTime / 1000).delay();
          if (_isShowLoading) _pop();
        }
      }
    }
  }

  static void _pop() {
    // 如果有提示窗，则先关闭提示窗
    if (_isShowConfirm) Navigator.of(elRootContext).pop();
    _isShowConfirm = false;
    _delayCloseTime = 0;
    _isShowLoading = false;
    if (elRootContext.mounted) Navigator.of(elRootContext).pop();
  }
}

/// 构建loading组件
class _LoadingModelWidget extends StatelessWidget {
  const _LoadingModelWidget({required this.title, required this.cancelText, this.onCancel});

  final String title;
  final String cancelText;
  final void Function()? onCancel;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        _LoadingUtil._isShowConfirm = true;
        // await context.showConfirmModal(
        //   title: cancelText,
        //   onConfirm: () {
        //     _LoadingUtil._isShowLoading = false;
        //     if (onCancel != null) onCancel!();
        //     Navigator.of(context).pop();
        //   },
        // );
        _LoadingUtil._isShowConfirm = false;
      },
      child: Material(
        type: MaterialType.transparency,
        elevation: context.elTheme.modalElevation,
        child: Center(
          child: Container(
            padding: const EdgeInsets.fromLTRB(24, 36, 24, 24),
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey.shade700.withOpacity(0.85)
                  : Colors.grey.shade900.withOpacity(0.85),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const CircularProgressIndicator(color: Colors.white),
                const SizedBox(height: 24),
                Container(
                  constraints: const BoxConstraints(minWidth: 120, maxWidth: 150),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
