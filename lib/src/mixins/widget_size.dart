import 'package:flutter/widgets.dart';
import 'package:flutter_element_ui/src/global.dart';

mixin ElWidgetSize<T extends StatefulWidget> on State<T> {
  Size widgetSize = Size.zero;

  bool _flag = true;

  void calcWidgetSize() {
    if (_flag) {
      _flag = false;
      FlutterUtil.nextTick(() {
        i(context.size);
        setState(() {
          widgetSize = context.size!;
        });
        () {
          _flag = true;
        }.delay(16);
      });
    }
  }
}
