import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? _sp;

/// SharedPreferences 本地存储实例
SharedPreferences get sp {
  assert(_sp != null, 'sp 还未初始化，请在 main 函数中执行 initSP 方法');
  return _sp!;
}

/// 初始化 SharedPreferences 本地存储实例
Future<void> initSP() async {
  _sp = await SharedPreferences.getInstance();
}
