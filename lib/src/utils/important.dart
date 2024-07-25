// extension ImportantDynamicExtension on dynamic {
//   Important get important => Important(this);
// }
//
// extension ImportantNumExtension on num {
//   Important<num> get important => Important(this);
// }
//
// extension ImportantIntExtension on int {
//   Important<int> get important => Important(this);
// }
//
// extension ImportantDoubleExtension on double {
//   Important<double> get important => Important(this);
// }
//
// extension ImportantStringExtension on String {
//   Important<String> get important => Important(this);
// }
//
// extension ImportantBoolExtension on bool {
//   Important<bool> get important => Important(this);
// }
//
// /// 实现 css !important 规则，它是一个代理类,
// class Important<T> extends String {
//   final T value;
//
//   Important(this.value);
// }
//
// void demo() {
//   test(10.important);
// }
//
// void test(int i) {}
//
