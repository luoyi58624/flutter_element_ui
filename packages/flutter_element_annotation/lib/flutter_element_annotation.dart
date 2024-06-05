library flutter_element_annotation;

import 'package:meta/meta_meta.dart';

@Target({TargetKind.classType})
class ElModel {
  /// 标识数据类模型，引入[flutter_element_generator]库将自动生成通用的方法
  const ElModel();
}
