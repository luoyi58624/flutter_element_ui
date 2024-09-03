import 'package:flutter/foundation.dart';
import 'package:flutter_element_ui/global.dart';

import '../styles/config.dart';
import '../styles/theme.dart';

final globalThemeDuration = Obs<Duration?>(null);

/// Element UI 提供的主题服务就是全局变量，直接修改 el.theme、el.darkTheme、el.config
/// 即可应用全局主题，它不依赖 [InheritedWidget] 小部件，对于颜色主题，请通过 context.elTheme
/// 访问自适应颜色变量。
mixin ElThemeService {
  /// 全局主题过渡持续时间。
  ///
  /// [MaterialApp] 提供了 themeAnimationDuration 属性，你需要将此属性和 MaterialApp 进行同步，
  /// 这样可以防止切换暗黑模式时颜色过渡出现不一致问题，如果没有切换主题的需求那么无需此操作
  Duration get themeDuration => GlobalConfig.themeDuration;

  set themeDuration(Duration v) {
    GlobalConfig.themeDuration = v;
  }

  Future<void> changeTheme(VoidCallback fun) async {
    globalThemeDuration.value = el.themeDuration;
    fun();
    await themeDuration.delay();
    globalThemeDuration.value = null;
  }

  /// Element UI 颜色主题类型集合，因为枚举有点繁琐，所以类型使用字符串表示
  final List<String> themeTypes = const [
    'primary',
    'success',
    'info',
    'warning',
    'error'
  ];

  /// Element UI 全局亮色主题配置，如果需要自适应，请使用 context.elTheme
  ElThemeData theme = ElThemeData();

  /// Element UI 全局暗色主题配置，如果需要自适应，请使用 context.elTheme
  ElThemeData darkTheme = ElThemeData.dark();

  /// Element UI 全局配置
  ElConfigData config = ElConfigData.data;

  /// Element UI 全局断点，它涵盖 320px -> 2560px 范围设备的断点，
  /// 你可以使用它，但不允许自定义，因为会破坏很多组件的响应式逻辑。
  ResponsiveData get responsive => GlobalConfig.responsive;
}
