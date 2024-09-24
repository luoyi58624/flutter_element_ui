import 'services/anchor.dart';
import 'services/cursor.dart';
import 'services/message.dart';
import 'services/other.dart';
import 'services/router.dart';
import 'services/toast.dart';

/// Element UI 全局服务对象
final el = ElService();

class ElService
    with
        AnchorService,
        OtherService,
        RouterService,
        CursorService,
        MessageService,
        ToastService {}
