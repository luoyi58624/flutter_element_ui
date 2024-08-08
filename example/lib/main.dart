import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'global.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();
  await CacheInterceptor.init();
  await FontUtil.init(
    // fontModel: const FontModel(fontFamily: 'NotoSansSC'),
    // android: true,
  );
  ElFont.bold = FontWeight.w400;
  el.config = ElConfigData(
    textStyle: TextStyle(
      fontFamily: FlutterFont.fontFamily,
      fontFamilyFallback: ElFont.fontFamilyFallback,
    ),
  );
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return ObsBuilder(builder: (context) {
      return MaterialApp.router(
        routerConfig: router,
        theme: ElThemeUtil.buildMaterialTheme(
          context,
          brightness:
              GlobalState.isDark.value ? Brightness.dark : Brightness.light,
        ),
        darkTheme: ElThemeUtil.buildMaterialTheme(
          context,
          brightness: Brightness.dark,
        ),
        showPerformanceOverlay: GlobalState.showPerformanceOverlay.value,
        debugShowCheckedModeBanner: false,
        builder: (context, child) => CupertinoTheme(
          data: ElThemeUtil.buildCupertinoThemeData(
            context,
            brightness: Theme.of(context).brightness,
          ),
          child: ElConfigProvider(
            child: child!,
          ),
        ),
      );
    });
  }
}
