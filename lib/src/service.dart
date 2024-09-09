import 'services/context_menu.dart';
import 'services/cursor.dart';
import 'services/message.dart';
import 'services/router.dart';
import 'services/toast.dart';

/// Element UI 全局服务对象
final el = ElService();

class ElService
    with
        ElRouterService,
        ElContextMenuService,
        ElCursorService,
        ElMessageService,
        ElToastService {
  /// Element UI 颜色主题类型集合，因为枚举略显繁琐，所以类型使用字符串表示
  final List<String> themeTypes = const [
    'primary',
    'success',
    'info',
    'warning',
    'error'
  ];
}
