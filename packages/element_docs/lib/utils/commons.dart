import 'package:element_docs/global.dart';
import 'package:flutter/services.dart';

class CommonUtil {
  static void copy(String text, [String? message]) async {
    await Clipboard.setData(ClipboardData(text: text));
    String $copyMessage = message ?? '复制成功';

    el.message.show(
      $copyMessage,
      type: El.primary,
      showClose: false,
      icon: const ElIcon(ElIcons.success),
    );
  }
}
