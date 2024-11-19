import 'package:element_docs/global.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

Map<ShortcutActivator, Intent> globalShortcuts() => {
      SingleActivator(LogicalKeyboardKey.keyD,
          meta: PlatformUtil.isMacOS,
          control: !PlatformUtil.isMacOS): const DebugIntent(),
      LogicalKeySet(LogicalKeyboardKey.keyA, LogicalKeyboardKey.keyS):
          const DebugIntent(),
      const SingleActivator(LogicalKeyboardKey.escape): const QuitIntent(),
    };

class DebugIntent extends Intent {
  const DebugIntent();
}

class QuitIntent extends Intent {
  const QuitIntent();
}

class QuitAction extends Action<QuitIntent> {
  @override
  Object? invoke(QuitIntent intent) {
    if (el.context.canPop()) {
      el.context.pop();
    }
    return null;
  }
}
