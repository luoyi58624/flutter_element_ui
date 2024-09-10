import 'package:docs/global.dart';
import 'package:flutter/services.dart';

class CommonUtil {
  static void copyColor(Color color) async {
    final colorText = color.toHex();
    await Clipboard.setData(ClipboardData(text: colorText));
    el.message.success('复制成功: $colorText');
  }
}
