import 'package:flutter/widgets.dart';

import 'services/context_menu.dart';
import 'services/cursor.dart';
import 'services/message.dart';
import 'services/router.dart';
import 'services/theme.dart';
import 'services/toast.dart';

/// Element UI 全局服务对象
final el = ElService();

final GlobalKey elAppKey = GlobalKey();

class ElService
    with
        ElThemeService,
        ElRouterService,
        ElContextMenuService,
        ElCursorService,
        ElMessageService,
        ElToastService {
  /// [ElApp] 全局 key 秘钥
  GlobalKey get key => elAppKey;

  /// [ElApp] 全局 context 对象，允许用户在任意地方直接无 context 访问 [ElApp] 注入的全局配置：
  /// ```
  /// // 判断是否是暗黑模式
  /// el.el.isDark;
  ///
  ///
  /// ```
  BuildContext get context => key.currentContext!;

  /// Element UI 颜色主题类型集合，因为枚举略显繁琐，所以类型使用字符串表示
  final List<String> themeTypes = const [
    'primary',
    'success',
    'info',
    'warning',
    'error'
  ];
}
