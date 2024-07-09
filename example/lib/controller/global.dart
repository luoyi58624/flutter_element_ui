import 'package:example/global.dart';

class GlobalController extends GetxController {
  static GlobalController get of => Get.find();
  final isDark = false.obs;
}
