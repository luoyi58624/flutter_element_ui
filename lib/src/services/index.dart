import 'anchor.dart';
import 'cursor.dart';
import 'logger.dart';
import 'message.dart';
import 'router.dart';
import 'toast.dart';

class Service
    with
        AnchorService,
        RouterService,
        LoggerService,
        CursorService,
        MessageService,
        ToastService {}
