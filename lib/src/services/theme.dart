import 'package:flutter_element_ui/src/global.dart';

mixin ElThemeService {
  /// Element UI 颜色主题类型集合，因为枚举略显繁琐，所以类型使用字符串表示
  final List<String> themeTypes = const [
    'primary',
    'success',
    'info',
    'warning',
    'error'
  ];

  /// Element UI 全局断点，它涵盖 320px -> 2560px 范围设备的断点，
  /// 你可以使用它，但不允许自定义，因为会破坏很多组件的响应式逻辑。
  ResponsiveData get responsive => responsiveData;
}
