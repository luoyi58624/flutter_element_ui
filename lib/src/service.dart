import 'package:flutter/widgets.dart';

import 'services/context_menu.dart';
import 'services/cursor.dart';
import 'services/message.dart';
import 'services/other.dart';
import 'services/router.dart';
import 'services/toast.dart';

/// Element UI 全局服务对象
final el = ElService();

final GlobalKey elAppKey = GlobalKey();

class ElService
    with
        ElOtherService,
        ElRouterService,
        ElContextMenuService,
        ElCursorService,
        ElMessageService,
        ElToastService {}
