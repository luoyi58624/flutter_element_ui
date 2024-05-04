import 'package:example/global.dart';
import 'package:mini_getx/mini_getx.dart';

class GlobalController extends GetxController {
  static GlobalController of = Get.find();
  final useDark = false.obs;
  final elConfigData = ElConfigData(
    fontFamily: 'NotoSansSC',
  ).obs;
}
