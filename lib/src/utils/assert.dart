import '../service.dart';

const String elInternalError = 'Element UI内部程序错误，此错误并非用户问题，请提交ISSUE';

abstract class ElAssert {
  /// 主题类型断言，允许空
  static void themeType(String? type) {
    assert(type == null || $el.themeTypes.contains(type), '无效的主题类型值: $type');
  }

  /// 主题类型断言，必须是五种主题类型的其中一个
  static void themeTypeRequired(String type) {
    assert($el.themeTypes.contains(type),
        '传递的主题类型必须是: primary、success、info、warning、error 以上的其中一个');
  }
}
