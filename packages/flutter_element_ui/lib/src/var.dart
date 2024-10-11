import 'services/index.dart';

/// Element UI 全局服务对象
final el = Service();

/// Element UI 颜色主题类型集合，因为枚举略显繁琐，所以类型使用字符串表示
const List<String> elThemeTypes = [
  'primary',
  ...elThemeStatusTypes,
];

/// Element UI 主题状态类型集合
const List<String> elThemeStatusTypes = ['success', 'info', 'warning', 'error'];