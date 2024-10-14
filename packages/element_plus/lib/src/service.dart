import './services/anchor.dart';
import './services/cursor.dart';
import './services/message.dart';
import './services/router.dart';
import './services/toast.dart';

/// Element UI 全局服务对象实例
const el = El._();

/// Element UI 全局服务类
class El
    with
        AnchorService,
        RouterService,
        CursorService,
        MessageService,
        ToastService {
  const El._();

  /// Element UI primary 字符串主题类型
  static const String primary = 'primary';

  /// Element UI success 字符串主题类型
  static const String success = 'success';

  /// Element UI info 字符串主题类型
  static const String info = 'info';

  /// Element UI warning 字符串主题类型
  static const String warning = 'warning';

  /// Element UI error 字符串主题类型
  static const String error = 'error';

  /// Element UI 主题状态类型集合
  static const List<String> themeStatusTypes = [success, info, warning, error];

  /// Element UI 颜色主题类型集合
  static const List<String> themeTypes = [primary, ...themeStatusTypes];
}
