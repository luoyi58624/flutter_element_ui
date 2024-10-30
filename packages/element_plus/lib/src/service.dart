import './services/anchor.dart';
import './services/cursor.dart';
import './services/message.dart';
import './services/router.dart';
import './services/toast.dart';

/// Element UI 全局服务对象实例
const el = El._();

/// Element UI 全局服务
class El
    with
        AnchorService,
        RouterService,
        CursorService,
        MessageService,
        ToastService {
  const El._();

  static const String primary = 'primary';
  static const String success = 'success';
  static const String info = 'info';
  static const String warning = 'warning';
  static const String error = 'error';

  /// Element UI 主题状态类型集合，只包含：[success]、[info]、[warning]、[error]、
  static const List<String> themeStatusTypes = [success, info, warning, error];

  /// Element UI 颜色主题类型集合
  static const List<String> themeTypes = [primary, ...themeStatusTypes];
}
