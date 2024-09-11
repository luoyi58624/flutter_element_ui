import 'package:docs/global.dart';
import 'package:flutter/services.dart';

class CommonUtil {
  static void copy(
    String text, {
    String? copyMessage,
  }) async {
    await Clipboard.setData(ClipboardData(text: text));
    String $copyMessage = '复制成功';
    if (!DartUtil.isEmpty(copyMessage)) {
      $copyMessage += ': $copyMessage';
    }
    el.message.primary(
      $copyMessage,
      icon: const ElIcon(ElIcons.success),
    );
  }
}
