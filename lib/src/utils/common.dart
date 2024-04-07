part of flutter_element_ui;

/// 基本类型字符串
const _baseTypeString = ['String', 'num', 'int', 'double', 'bool'];

/// 比较两个值的条件类型
enum _CompareType {
  /// 小于
  less,

  /// 小于等于
  lessEqual,

  /// 等于
  equal,

  /// 大于等于
  thanEqual,

  /// 大于
  than,
}

class _ElUtil {
  _ElUtil._();

  /// 判断一个变量是否为空，例如：null、''、[]、{}
  ///
  /// checkNum - 若为true，则判断数字是否为0
  /// checkString - 若为true，则判断字符串是否为 'null'
  static bool isEmpty(
    dynamic value, {
    bool? checkNum,
    bool? checkString,
  }) {
    if (null == value) {
      return true;
    } else if (value is String) {
      var str = value.trim();
      if (checkString == true) {
        return str.isEmpty || str == 'null';
      } else {
        return str.isEmpty;
      }
    } else if (checkNum == true && value is num) {
      return value == 0;
    } else if (value is List) {
      return value.isEmpty;
    } else if (value is Map) {
      return value.isEmpty;
    } else if (value is Object) {
      return value == {};
    } else {
      return false;
    }
  }

  /// 判断变量是否是基本数据类型
  static bool isBaseType(dynamic value) {
    return (value is num || value is String || value is bool);
  }

  /// 检查传入的类型字符串是否是基本类型字符串
  static bool isBaseTypeString(String typeString) {
    return _baseTypeString.contains(typeString);
  }

  /// 获取Map-key泛型类型
  static String getMapKeyType(dynamic value) {
    if (value is Map) {
      var strList = value.runtimeType.toString().split(',');
      return strList.first.trim().replaceAll('_Map<', '');
    } else {
      return 'dynamic';
    }
  }

  /// 获取Map-value泛型类型
  static String getMapValueType(Map value) {
    var typeString = value.runtimeType.toString();
    var index = typeString.indexOf(',');
    var str = typeString.substring(index + 1, typeString.length).trim();
    return str.substring(0, str.length - 1);
  }

  /// 将动态类型转换成基础数据类型，转换后的值可以安全使用case确定类型。
  /// 注意：dart中的List、Map等集合的cast方法只是用于编译时，当实际变量类型并非cast的目标类型，则会报运行时错误。
  static dynamic dynamicToTargetType(dynamic value, String type) {
    if (type == 'String') {
      return safeString(value);
    } else if (type == 'num' || type == 'double') {
      return safeDouble(value);
    } else if (type == 'int') {
      return safeInt(value);
    } else if (type == 'bool') {
      return safeBool(value);
    } else {
      return null;
    }
  }

  static List<T> concatArray<T>(List<T> sourceList, List<T> newList) {
    sourceList.addAll(newList);
    return sourceList;
  }

  /// 安全解析String，如果传递的value为空，则返回一个默认值
  static String safeString(
    dynamic value, {
    String defaultValue = '',
    String? suffixText, // 字符串后缀文字 (如果返回的字符串不为空)
  }) {
    if (isEmpty(value)) {
      return defaultValue;
    } else {
      if (suffixText == null) {
        return value.toString();
      } else {
        return value.toString() + suffixText;
      }
    }
  }

  /// 安全解析int，如果传递的value不是num类型，则返回默认值
  static int safeInt(dynamic value, {int defaultValue = 0}) {
    if (value is int) {
      return value.isNaN ? defaultValue : value;
    } else if (value is double) {
      return int.parse(value.toString());
    } else if (value is String && int.tryParse(value) != null) {
      return int.parse(value);
    } else {
      return defaultValue;
    }
  }

  /// 安全解析double，如果传递的value不是num类型，则返回默认值
  static double safeDouble(dynamic value, {double defaultValue = 0.0}) {
    if (value is double) {
      return value.isNaN ? defaultValue : value;
    } else if (value is int) {
      return double.parse(value.toString());
    } else if (value is String && double.tryParse(value) != null) {
      return double.parse(value);
    } else {
      return defaultValue;
    }
  }

  /// 安全解析bool类型
  static bool safeBool(dynamic value) {
    if (value is String) {
      try {
        return bool.parse(value, caseSensitive: false);
      } catch (e) {
        return false;
      }
    } else if (value is bool) {
      return value;
    } else if (value == null) {
      return false;
    } else {
      return bool.tryParse(value, caseSensitive: false) ?? false;
    }
  }

  /// 安全解析List
  static List<T> safeList<T>(dynamic value, List<T> defaultValue) {
    if (value is List) {
      return value.cast<T>();
    } else {
      return defaultValue;
    }
  }

  /// 安全解析日期，支持字符串、时间戳等格式解析，如果格式不正确则返回defaultValue，
  /// 如果defaultValue为空，则会返回当前时间。
  static DateTime safeDate(
    dynamic value, {
    dynamic defaultValue,
  }) {
    if (isEmpty(value)) {
      return _defaultDate(defaultValue);
    } else if (value is String) {
      var date = DateTime.tryParse(value);
      return date ?? _defaultDate(defaultValue);
    } else if (value is int) {
      return DateTime.fromMillisecondsSinceEpoch(value);
    } else if (value is DateTime) {
      return value;
    } else {
      return _defaultDate(defaultValue);
    }
  }

  static DateTime _defaultDate(dynamic value) {
    if (isEmpty(value)) {
      return DateTime.now();
    } else if (value is String) {
      var date = DateTime.tryParse(value);
      return date ?? DateTime.now();
    } else if (value is DateTime) {
      return value;
    } else {
      return DateTime.now();
    }
  }

  /// 安全地比较两个字符
  static bool compareString(dynamic value1, dynamic value2) {
    return safeString(value1) == safeString(value2);
  }

  /// 安全地比较两个数字：小于、等于、大于、小于等于、大于等于。
  static bool compareNum(
    dynamic value1,
    dynamic value2, {
    _CompareType compareType = _CompareType.equal,
  }) {
    return _compareResult(compareType, safeDouble(value1) - safeDouble(value2));
  }

  /// 安全地比较两个日期，允许传入2个任意类型的数据，它们都会安全地转化为DateTime类型进行比较
  static bool compareDate(
    dynamic date1,
    dynamic date2, {
    _CompareType compareType = _CompareType.equal,
  }) {
    late int result; // 比较结果
    int nullValue1 = isEmpty(date1) ? 0 : 1;
    int nullValue2 = isEmpty(date2) ? 0 : 1;

    // 如果有一个值为空，则直接获取比较结果
    if (nullValue1 == 0 || nullValue2 == 0) {
      result = nullValue1 - nullValue2;
    } else {
      DateTime? dateTime1;
      DateTime? dateTime2;
      if (date1 is String) {
        dateTime1 = DateTime.tryParse(date1);
      } else if (date1 is DateTime) {
        dateTime1 = date1;
      } else {
        throw Exception('传入的date1类型错误');
      }
      if (date2 is String) {
        dateTime2 = DateTime.tryParse(date2);
      } else if (date2 is DateTime) {
        dateTime2 = date2;
      } else {
        throw Exception('传入的date2类型错误');
      }
      if (dateTime1 != null && dateTime2 != null) {
        result = dateTime1.compareTo(dateTime2);
      } else {
        result = (dateTime1 == null ? 0 : 1) - (dateTime2 == null ? 0 : 1);
      }
    }
    return _compareResult(compareType, result);
  }

  /// 比较两个日期，如果为true，则返回date1，否则返回date2。
  static DateTime getCompareDate(
    DateTime date1,
    DateTime date2, {
    _CompareType compareType = _CompareType.equal,
  }) {
    return compareDate(date1, date2, compareType: compareType) ? date1 : date2;
  }

  /// 获取date1和date2相差的时间，单位：毫秒
  static int diffDate(
    dynamic date1,
    dynamic date2,
  ) {
    return ((safeDate(date1).millisecondsSinceEpoch - safeDate(date2).millisecondsSinceEpoch)).truncate();
  }

  /// 获取date1和date2相差的天数
  static int diffDay(
    dynamic date1,
    dynamic date2,
  ) {
    return ((safeDate(date1).millisecondsSinceEpoch - safeDate(date2).millisecondsSinceEpoch) / 1000 / 60 / 60 / 24)
        .truncate();
  }

  /// 时间戳转倒计时
  static String millisecondToCountDown(int milliseconds) {
    assert(milliseconds > 0, '时间戳必须大于0');
    var duration = Duration(milliseconds: milliseconds);
    int days = duration.inDays;
    int hours = duration.inHours.remainder(24);
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);
    String hourText = hours.toString().padLeft(2, '0');
    String minuteText = minutes.toString().padLeft(2, '0');
    String secondText = seconds.toString().padLeft(2, '0');
    if (days > 0) {
      return '$days天$hourText时$minuteText分$secondText秒';
    } else if (hours > 0) {
      return '$hourText时$minuteText分$secondText秒';
    } else if (minutes > 0) {
      return '$minuteText分$secondText秒';
    } else {
      return '$secondText秒';
    }
  }

  /// 格式化大小
  static String formatSize(size) {
    if (size == null || size == '' || size == 0) {
      return '0KB';
    }
    const unitArr = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
    int index;
    var $size = safeDouble(size);
    index = (math.log($size) / math.log(1024)).floor();
    return '${($size / math.pow(1024, index)).toStringAsFixed(2)}${unitArr[index]}';
  }

  /// 判断list集合中是否包含满足某个条件的元素
  static bool listContains<E>(List<E> list, bool Function(E element) action) {
    for (var listItem in list) {
      if (action(listItem)) {
        return true;
      }
    }
    return false;
  }

  /// 拼接上级地址，返回新的path，主要过滤新地址尾部多余的/
  static String joinParentPath(String path, [String? parentPath]) {
    String $path = parentPath != null ? parentPath + path : path;
    if ($path.endsWith('/') && parentPath != null) {
      $path = $path.substring(0, $path.length - 1);
    }
    return $path;
  }

  /// 循环获取列表的内容，如果其索引大于列表的长度，则重头开始继续获取
  static T loopGetListContent<T>(List<T> list, int index) {
    if (index <= 0) {
      return list[0];
    } else if (index < list.length) {
      return list[index];
    } else {
      return loopGetListContent(list, index - list.length);
    }
  }
}

bool _compareResult(_CompareType compareType, num result) {
  switch (compareType) {
    case _CompareType.equal:
      return result == 0;
    case _CompareType.less:
      return result < 0;
    case _CompareType.lessEqual:
      return result <= 0;
    case _CompareType.than:
      return result > 0;
    case _CompareType.thanEqual:
      return result >= 0;
  }
}
