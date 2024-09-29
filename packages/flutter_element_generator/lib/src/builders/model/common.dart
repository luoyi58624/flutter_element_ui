part of './index.dart';

const TypeChecker _modelChecker = TypeChecker.fromRuntime(ElModel);
const TypeChecker _modelFieldChecker = TypeChecker.fromRuntime(ElModelField);

/// 判断字段是否允许 copy
bool _allowCopy(FieldElement fieldInfo) {
  return !(fieldInfo.isSynthetic ||
      fieldInfo.isStatic ||
      fieldInfo.isLate ||
      fieldInfo.isConst);
}

/// 判断当前字段是否被忽略
/// * typeString 生成的函数类型字符串，根据此字符串获取当前字段声明的注解参数，
/// 如果为true，则表示此函数生成的代码应当忽略该字段
bool _isIgnoreField(String typeString, FieldElement fieldInfo) {
  bool isElModelField = _modelFieldChecker.hasAnnotationOfExact(fieldInfo);
  if (isElModelField) {
    var target = _modelFieldChecker
        .firstAnnotationOfExact(fieldInfo)!
        .getField('ignore')!;
    return target.getField(typeString)?.toBoolValue() ?? false;
  }
  return false;
}

/// 判断反射的字段是否包含克隆方法，如果包含，则生成的代码需要调用目标的克隆方法
bool _isDeepCloneField(FieldElement fieldInfo) {
  final fieldElement = fieldInfo.type.element;
  if (fieldElement is ClassElement) {
    // 判断当前字段类型是否声明了 ElModel 注解，如果声明了 merge 方法，则属于深克隆字段
    bool isElModelField = _modelChecker.hasAnnotationOfExact(fieldElement);
    if (isElModelField) {
      return _modelChecker
              .firstAnnotationOfExact(fieldElement)!
              .getField('merge')!
              .toBoolValue() ??
          false;
    }
    // 判断当前字段类型是否包含了 merge 方法
    if (fieldElement.methods.map((method) => method.name).contains('merge')) {
      return true;
    }
  }
  return false;
}
