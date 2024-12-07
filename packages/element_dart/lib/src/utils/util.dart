import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import 'package:archive/archive.dart';
import 'package:path/path.dart' as p;
import 'package:crypto/crypto.dart' as crypto;

import 'logger.dart';

class DartUtil {
  DartUtil._();

  static final Codec<String, String> _base64Codec = utf8.fuse(base64);

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
    return ['String', 'num', 'int', 'double', 'bool'].contains(typeString);
  }

  /// 将动态类型转换成实际基础类型：String、int、double、num、bool，如果
  /// * strict 如果为true，对于非基础类型将一律返回null
  static dynamic dynamicToBaseType(dynamic value, [bool? strict]) {
    String type = value.runtimeType.toString();
    if (type == 'String') {
      dynamic v = int.tryParse(value);
      if (v != null) return v;
      v = double.tryParse(value);
      if (v != null) return v;
      v = bool.tryParse(value);
      if (v != null) return v;
      return value;
    }
    if (type == 'int') return value;
    if (type == 'double') return value;
    if (type == 'bool') return value;
    if (type == 'num') return value;
    return strict == true ? null : value;
  }

  /// 安全解析String，如果传递的value为空，则返回一个默认值
  static String safeString(dynamic value, [String defaultValue = '']) {
    if (isEmpty(value)) {
      return defaultValue;
    } else {
      return value.toString();
    }
  }

  /// 安全解析int，如果传递的value不是num类型，则返回默认值
  static int safeInt(dynamic value, [int defaultValue = 0]) {
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
  static double safeDouble(dynamic value, [double defaultValue = 0.0]) {
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
  static bool safeBool(dynamic value, [bool defaultValue = false]) {
    if (value is String) {
      try {
        return bool.parse(value, caseSensitive: false);
      } catch (e) {
        return false;
      }
    } else if (value is bool) {
      return value;
    }
    return defaultValue;
  }

  /// 安全解析List，若解析失败则返回空List
  static List<T> safeList<T>(dynamic value, [List<T> defaultValue = const []]) {
    if (value is List) {
      try {
        return value.cast<T>();
      } catch (e) {
        w(e, 'List case $T 转换失败，将返回空[]');
        return defaultValue;
      }
    } else {
      return defaultValue;
    }
  }

  /// 安全解析日期，支持字符串、时间戳等格式解析，如果格式不正确则返回defaultValue，
  /// 如果defaultValue为空，则会返回当前时间。
  static DateTime safeDate(dynamic value, [dynamic defaultValue]) {
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
    dynamic value2, [
    CompareType compareType = CompareType.equal,
  ]) {
    return _compareResult(compareType, safeDouble(value1) - safeDouble(value2));
  }

  /// 安全地比较两个日期，允许传入2个任意类型的数据，它们都会安全地转化为DateTime类型进行比较
  static bool compareDate(
    dynamic date1,
    dynamic date2, [
    CompareType compareType = CompareType.equal,
  ]) {
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
    DateTime date2, [
    CompareType compareType = CompareType.equal,
  ]) {
    return compareDate(date1, date2, compareType) ? date1 : date2;
  }

  /// 获取date1和date2相差的时间，单位：毫秒
  static int diffDate(dynamic date1, dynamic date2) {
    return ((safeDate(date1).millisecondsSinceEpoch -
            safeDate(date2).millisecondsSinceEpoch))
        .truncate();
  }

  /// 获取date1和date2相差的天数
  static int diffDay(dynamic date1, dynamic date2) {
    return ((safeDate(date1).millisecondsSinceEpoch -
                safeDate(date2).millisecondsSinceEpoch) /
            1000 /
            60 /
            60 /
            24)
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

  /// 以指定格式解析日期
  static String formatDate(
    dynamic value, [
    String format = 'yyyy-MM-dd HH:mm:ss',
  ]) {
    var dateTime = safeDate(value);
    if (format.contains('yy')) {
      String year = dateTime.year.toString();
      if (format.contains('yyyy')) {
        format = format.replaceAll('yyyy', year);
      } else {
        format = format.replaceAll(
            'yy', year.substring(year.length - 2, year.length));
      }
    }

    format = _comFormat(dateTime.month, format, 'M', 'MM');
    format = _comFormat(dateTime.day, format, 'd', 'dd');
    format = _comFormat(dateTime.hour, format, 'H', 'HH');
    format = _comFormat(dateTime.minute, format, 'm', 'mm');
    format = _comFormat(dateTime.second, format, 's', 'ss');
    format = _comFormat(dateTime.millisecond, format, 'S', 'SSS');

    return format;
  }

  static String _comFormat(
      int value, String format, String single, String full) {
    if (format.contains(single)) {
      if (format.contains(full)) {
        format =
            format.replaceAll(full, value < 10 ? '0$value' : value.toString());
      } else {
        format = format.replaceAll(single, value.toString());
      }
    }
    return format;
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

  /// 获取地址中的文件名
  static String? getUrlFileName(String? url) => p.basename(url ?? '');

  /// 获取地址中的文件名但不包含扩展名
  static String? getUrlFileNameNoExtension(String? url) =>
      p.basenameWithoutExtension(url ?? '');

  /// 获取文件名后缀
  static String? getFileSuffix(String fileName) {
    String suffixName = p.extension(fileName);
    if (!isEmpty(suffixName) && suffixName.startsWith('.')) {
      return suffixName.replaceFirst('.', '');
    } else {
      return null;
    }
  }

  /// 判断文件是否是图片
  static bool isImage(String fileName, [List<String>? ext]) =>
      (ext ?? ['jpg', 'jpeg', 'png', 'gif', 'bmp'])
          .contains(getFileSuffix(fileName));

  /// 判断文件是否是静态图片
  static bool isStaticImage(String fileName, [List<String>? ext]) =>
      (ext ?? ['jpg', 'jpeg', 'png']).contains(getFileSuffix(fileName));

  /// 判断文件是否是视频
  static bool isVideo(String fileName, [List<String>? ext]) =>
      (ext ?? ['mkv', 'mp4', 'avi', 'mov', 'wmv', 'mpg', 'mpeg'])
          .contains(getFileSuffix(fileName));

  /// 判断文件是否是音频
  static bool isAudio(String fileName, [List<String>? ext]) =>
      (ext ?? ['mp3', 'wav', 'wma', 'amr', 'ogg'])
          .contains(getFileSuffix(fileName));

  /// 判断文件是否是PPT
  static bool isPPT(String fileName) =>
      ['ppt', 'pptx'].contains(getFileSuffix(fileName));

  /// 判断文件是否是Word
  static bool isWord(String fileName) =>
      ['doc', 'docx'].contains(getFileSuffix(fileName));

  /// 判断文件是否是Excel
  static bool isExcel(String fileName) =>
      ['xls', 'xlsx'].contains(getFileSuffix(fileName));

  /// 判断是否是邮箱
  static bool isEmail(String s) => hasMatch(s,
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  /// 判断是否是手机号
  static bool isPhoneNumber(String s) {
    if (s.length > 16 || s.length < 9) return false;
    return hasMatch(s, r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');
  }

  /// 是否是 http 地址
  static bool isHttp(String url) => url.startsWith('http');

  static bool hasMatch(String? value, String pattern) {
    return (value == null) ? false : RegExp(pattern).hasMatch(value);
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

  /// 使用md5加密字符串
  static String md5(String str) =>
      crypto.md5.convert(utf8.encode(str)).toString();

  /// 字符串转base64
  static String toBase64(String str) => _base64Codec.encode(str);

  /// base64转字符串
  static String formBase64(String base64Str) => _base64Codec.decode(base64Str);

  /// 将字符串编码压缩
  static String encodeString(String str) {
    List<int> stringBytes = utf8.encode(str);
    List<int> gzipBytes = GZipEncoder().encode(stringBytes)!;
    return base64UrlEncode(gzipBytes);
  }

  /// 将字符串编码压缩
  static String decodeString(String str) {
    List<int> stringBytes = base64Url.decode(str);
    List<int> gzipBytes = GZipDecoder().decodeBytes(stringBytes);
    return utf8.decode(gzipBytes);
  }

  /// 给定一个包含任意类型的变量数组，判断内部变量是否仅有一个元素不为null
  /// * allowAllNull 允许所有变量均为null，默认 true
  static bool listOnlyOne(
    List values, {
    bool allowAllNull = true,
  }) {
    final l = values.where((e) => e != null).length;
    return allowAllNull ? l == 0 || l == 1 : l == 1;
  }

  static final List<String> _throttleKeyList = [];

  /// 创建一个节流函数，忽略指定时间内的多次调用
  /// * wait 节流时间(毫秒)
  /// * key 如果是匿名函数，请添加一个标识符，否则无法识别是否是同一个函数执行
  static dynamic throttle(
      Function fun,
      int wait, {
        String? key,
      }) {
    assert(wait > 0);
    key ??= fun.hashCode.toString();

    return () {
      if (_throttleKeyList.contains(key)) return;
      fun();
      _throttleKeyList.add(key!);
      Timer(Duration(milliseconds: wait), () {
        _throttleKeyList.remove(key);
      });
    };
  }

  static final Map<String, Timer> _debounceTimerMap = {};

  /// 创建一个防抖函数，如果在指定时间内多次执行函数，那么会忽略掉它，并重置等待时间，当等待时间结束后再执行函数
  /// * wait 防抖时间(毫秒)
  /// * key 如果是匿名函数，请添加一个标识符，否则无法识别是否是同一个函数执行
  static dynamic debounce(
      Function fun,
      int wait, {
        String? key,
      }) {
    assert(wait > 0);
    key ??= fun.hashCode.toString();
    return () {
      if (_debounceTimerMap.containsKey(key)) {
        _debounceTimerMap[key!]!.cancel();
        _debounceTimerMap[key] = Timer(Duration(milliseconds: wait), () {
          fun();
          _debounceTimerMap.remove(key);
        });
        return;
      } else {
        _debounceTimerMap[key!] = Timer(Duration(milliseconds: wait), () {
          fun();
          _debounceTimerMap.remove(key);
        });
      }
    };
  }
}

/// 比较两个值的条件类型
enum CompareType {
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

bool _compareResult(CompareType compareType, num result) {
  switch (compareType) {
    case CompareType.equal:
      return result == 0;
    case CompareType.less:
      return result < 0;
    case CompareType.lessEqual:
      return result <= 0;
    case CompareType.than:
      return result > 0;
    case CompareType.thanEqual:
      return result >= 0;
  }
}
