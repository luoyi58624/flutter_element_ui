import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

Map<ShortcutActivator, Intent> globalShortcuts() => {
      const SingleActivator(LogicalKeyboardKey.keyD, meta: true):
          const DebugIntent(),
      LogicalKeySet(LogicalKeyboardKey.keyA, LogicalKeyboardKey.keyS):
          const DebugIntent(),
      LogicalKeySet(LogicalKeyboardKey.escape): const QuitIntent(),
    };

class DebugIntent extends Intent {
  const DebugIntent();
}

class QuitIntent extends Intent {
  const QuitIntent();
}
