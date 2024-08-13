import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'global.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();
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
      el.config = ElConfigData(
        textStyle: TextStyle(
          fontFamily: FontUtil.fontFamily,
          fontFamilyFallback: FontUtil.fontFamilyFallback,
        ),
      );
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
            brightness: Theme.of(context).brightness,
            child: child!,
          ),
        ),
      );
    });
  }
}
