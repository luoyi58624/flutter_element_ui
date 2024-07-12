import '../service.dart';

const String elInternalError = 'Element UI内部程序错误，此错误并非用户问题，请提交ISSUE';

/// Element UI 主题类型断言
///
/// 与枚举相比，类型使用字符串可以令代码更加简洁，唯一的缺点就是没有类型提示
void themeTypeAssets(String? type) {
  assert(type == null || $el.themeTypes.contains(type),
      'theme type is invalid value: $type');
}
