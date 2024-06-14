import 'package:mini_getx/mini_getx.dart';

class GlobalController extends GetxController {
  static GlobalController get of => Get.find();
  final isDark = false.obs;
}
