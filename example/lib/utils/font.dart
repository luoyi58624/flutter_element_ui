// Future<void> _setElFontWeight() async {
//   if (kIsWeb) return;
//   await DeviceUtil.init();
//   if (PlatformUtil.isAndroid) {
//     // 小米手机400字重太细了，将normal设置为500
//     if (DeviceUtil.isXiaomi) {
//       ElFont.normal = FontWeight.w500;
//       ElFont.bold = FontWeight.w600;
//     }
//     // 华为手机700字重太重了，将bold设置为600
//     else if (DeviceUtil.isHUAWEI) {
//       ElFont.bold = FontWeight.w600;
//     }
//   }
// }
