import 'package:element_docs/global.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../pages/test/test_page.dart';

Map<ShortcutActivator, Intent> globalShortcuts() => {
      SingleActivator(LogicalKeyboardKey.keyD,
          meta: PlatformUtil.isMacOS,
          control: !PlatformUtil.isMacOS): const DebugIntent(),
      const SingleActivator(LogicalKeyboardKey.escape): const QuitIntent(),
      LogicalKeySet(LogicalKeyboardKey.f3): const TestMessageIntent(),
    };

Map<Type, Action> globalActions() => {
      DebugIntent: DebugAction(),
      QuitIntent: QuitAction(),
      TestMessageIntent: TestMessageAction(),
    };

class DebugIntent extends Intent {
  const DebugIntent();
}

class DebugAction extends Action<DebugIntent> {
  @override
  Object? invoke(DebugIntent intent) {
    el.context.push(const TestPage());
    return null;
  }
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

class TestMessageIntent extends Intent {
  const TestMessageIntent();
}

class TestMessageAction extends Action<TestMessageIntent> {
  @override
  Object? invoke(TestMessageIntent intent) {
    el.message.success('test message');
    return null;
  }
}
