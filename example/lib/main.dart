import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'global.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initSP();
  await CacheInterceptor.init();
  initFont(
      // fontModel: const FontModel(fontFamily: 'NotoSansSC'),
      // fontModel: GoogleFonts.notoSansSc([FontWeight.w500, FontWeight.w600]),
      // android: true,
      );
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return ObsBuilder(builder: (context) {
      return ElApp(
        child: MaterialApp.router(
          routerConfig: router,
          themeAnimationDuration: context.elConfig.themeDuration,
          theme: ElThemeUtil.buildMaterialTheme(
            context,
            brightness: GlobalState.brightness,
          ),
          darkTheme: ElThemeUtil.buildMaterialTheme(
            context,
            brightness: Brightness.dark,
          ),
          showSemanticsDebugger: GlobalState.showSemanticsDebugger.value,
          showPerformanceOverlay: GlobalState.showPerformanceOverlay.value,
          debugShowCheckedModeBanner: false,
          builder: ElApp.builder(
            (context, child) => CupertinoTheme(
              data: ElThemeUtil.buildCupertinoThemeData(
                context,
                brightness: Theme.of(context).brightness,
              ),
              child: child!,
            ),
          ),
        ).globalShortcut,
      );
    });
  }
}

extension _GlobalShortcut on Widget {
  Widget get globalShortcut {
    return Shortcuts(
      shortcuts: {
        LogicalKeySet(
          ElShortcutUtil.ctrl,
          LogicalKeyboardKey.keyL,
        ): LogIntent(),
        LogicalKeySet(
          ElShortcutUtil.ctrl,
          LogicalKeyboardKey.keyD,
          LogicalKeyboardKey.keyS,
        ): ShowSemanticsDebuggerIntent(),
      },
      child: Actions(
        actions: {
          LogIntent: CallbackAction(
            onInvoke: (intent) => () {
              i('打印日志');
            }(),
          ),
          ShowSemanticsDebuggerIntent: CallbackAction(
            onInvoke: (intent) => () {
              GlobalState.showSemanticsDebugger.value =
                  !GlobalState.showSemanticsDebugger.value;
            }(),
          ),
        },
        child: this,
      ),
    );
  }
}

class LogIntent extends Intent {}

class ShowSemanticsDebuggerIntent extends Intent {}
