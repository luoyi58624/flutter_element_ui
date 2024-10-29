import 'package:element_docs/global.dart';
import 'package:flutter/services.dart';

class CommonUtil {
  static void copy(
    String text, {
    String? copyMessage,
  }) async {
    await Clipboard.setData(ClipboardData(text: text));
    String $copyMessage = '复制成功';
    if (!ElUtil.isEmpty(copyMessage)) {
      $copyMessage += ': $copyMessage';
    }
    el.message.show(
      $copyMessage,
      type: El.success,
      icon: const ElIcon(ElIcons.success),
    );
  }
}
