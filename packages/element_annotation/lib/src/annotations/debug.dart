import 'package:meta/meta_meta.dart';

@Target({TargetKind.classType})
class ElDebug {
  /// 调试用的注解，在编写 print 打印语句时可以通过此注解指定目标
  const ElDebug();
}
