import '../components/feedback/message/index.dart';
import '../components/feedback/toast/index.dart';
import '../components/others/anchor/index.dart';
import 'cursor.dart';
import 'logger.dart';
import 'other.dart';
import 'router.dart';

/// Element UI 全局服务对象
final el = ElService();

class ElService
    with
        ElAnchorService,
        OtherService,
        RouterService,
        LoggerService,
        CursorService,
        ElMessageService,
        ElToastService {}
