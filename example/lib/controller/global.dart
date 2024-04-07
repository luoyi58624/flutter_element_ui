import 'package:example/global.dart';

class GlobalController extends GetxController {
  static GlobalController of = Get.find();
  final useDark = false.obs;
  final elConfigData = ElConfigData().obs;
}
