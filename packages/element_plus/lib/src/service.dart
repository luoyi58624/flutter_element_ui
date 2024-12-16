import 'package:element_plus/src/global.dart';
import 'package:element_storage/element_storage.dart';
import 'package:flutter/cupertino.dart';

import './services/anchor.dart';
import './services/cursor.dart';
import './services/router.dart';
import 'components/feedback/message/index.dart';
import 'components/feedback/toast/index.dart';

El? _el;

/// Element UI 全局服务对象实例
El get el {
  assert(_el != null, 'el 全局变量还未初始化，请在 main 函数中执行 El.init() 方法');
  return _el!;
}

/// Element UI 全局服务类
class El with AnchorService, RouterService, CursorService {
  El._();

  // 主题颜色常量字符串，之所以不使用枚举是因为枚举类名太长了，例如：ElThemeType.primary -> El.primary
  static const String primary = 'primary';
  static const String success = 'success';
  static const String info = 'info';
  static const String warning = 'warning';
  static const String error = 'error';

  // 全局尺寸预设字符串
  static const String mini = 'mini';
  static const String small = 'small';
  static const String medium = 'medium';
  static const String large = 'large';
  static const String xLarge = 'xLarge';

  /// Element UI 主题状态类型集合，只包含：[success]、[info]、[warning]、[error]、
  static const List<String> themeStatusTypes = [success, info, warning, error];

  /// Element UI 颜色主题类型集合
  static const List<String> themeTypes = [primary, ...themeStatusTypes];

  /// 初始化 [el] 全局变量
  static Future<void> init() async {
    if (_el == null) {
      _el = El._();
      await ElStorage.createLocalStorage();
      await ElStorage.createSessionStorage();
      await LocalObs.initStorage();
    }
  }

  /// Element UI 组件全局尺寸预设，此对象没有必要通过 [InheritedWidget] 注入，因为尺寸预设的实现和使用都比较复杂，
  /// 所以它很少需要在运行时改变状态（通知 UI），在绝大多数情况下尺寸预设会在编译前就直接确定，
  /// 当需要覆写默认配置时，只需要在构建 ElApp 之前对此变量进行赋值即可：
  /// ```dart
  /// ElSizePreset mySizePreset = ElSizePreset(
  ///   common: _CommonSizePreset(),
  /// );
  ///
  /// class _CommonSizePreset extends ElCommonSizePreset {
  ///   @override
  ///   ElCommonSizePreset get mini => const ElCommonSizePreset();
  /// }
  ///
  /// el.sizePreset = mySizePreset;
  /// ```
  ElSizePreset sizePreset = const ElSizePreset();

  /// Element UI 消息实例对象，它会在屏幕中上方显示一连串的消息，并支持合并相同类型的消息
  ElMessageService message = ElMessageService();

  /// Element UI 轻提示实例对象，在屏幕上显示一段简单的文本提示，每次只能显示一条消息
  ElToastService toast = ElToastService();
}
