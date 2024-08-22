import 'services/context_menu.dart';
import 'services/cursor.dart';
import 'services/message.dart';
import 'services/router.dart';
import 'services/theme.dart';
import 'services/toast.dart';

/// Element UI 全局服务对象
final el = ElService();

class ElService
    with
        ElThemeService,
        ElRouterService,
        ElContextMenuService,
        ElCursorService,
        ElMessageService,
        ElToastService {}
