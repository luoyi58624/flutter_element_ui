import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

class ElUtil {
  ElUtil._();

  static bool isEmpty(dynamic value) => DartUtil.isEmpty(value);

  static bool isHttp(String url) => url.startsWith('http');
}
