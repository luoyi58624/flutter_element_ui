import 'anchor.dart';
import 'cursor.dart';
import 'message.dart';
import 'router.dart';
import 'toast.dart';

class Service
    with
        AnchorService,
        RouterService,
        CursorService,
        MessageService,
        ToastService {}
