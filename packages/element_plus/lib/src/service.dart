import './services/anchor.dart';
import './services/cursor.dart';
import './services/router.dart';
import 'components/feedback/message/index.dart';
import 'components/feedback/toast/index.dart';

/// Element UI 全局服务对象实例
final el = El._();

/// Element UI 全局服务
class El with AnchorService, RouterService, CursorService {
  El._();

  static const String primary = 'primary';
  static const String success = 'success';
  static const String info = 'info';
  static const String warning = 'warning';
  static const String error = 'error';

  /// Element UI 主题状态类型集合，只包含：[success]、[info]、[warning]、[error]、
  static const List<String> themeStatusTypes = [success, info, warning, error];

  /// Element UI 颜色主题类型集合
  static const List<String> themeTypes = [primary, ...themeStatusTypes];

  /// Element UI 消息实例对象，它会在屏幕中上方显示一连串的消息，并支持合并相同类型的消息
  ElMessageService message = ElMessageService();

  /// Element UI 轻提示实例对象，在屏幕上显示一段简单的文本提示，每次只能显示一条消息
  ElToastService toast = ElToastService();
}
