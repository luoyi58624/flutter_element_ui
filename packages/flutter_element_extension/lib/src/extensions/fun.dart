import 'dart:async';

final List<String> _throttleKeyList = [];
final Map<String, Timer> _debounceKeyMap = {};

extension ElFunExtension on Function {
  /// 节流函数扩展，在一定时间内忽略多次点击事件
  /// * wait 节流时间(毫秒)
  /// * key 如果目标函数已经定义，那么你可以忽略此参数，但如果是匿名函数，你必须手动添加一个标识符
  ///
  /// 最简单的例子:
  /// ```dart
  /// void addCount() {
  ///   setState(() {
  ///     count++;
  ///   });
  /// }
  /// ElevatedButton(
  ///   onPressed: addCount.throttle(1000),
  ///   child: Text('count: $count'),
  /// )
  /// ```
  ///
  /// 带有参数的例子:
  /// ```dart
  /// void addCount(int value) {
  ///   setState(() {
  ///     count+=value;
  ///   });
  /// }
  /// ElevatedButton(
  ///   onPressed: (() => addCount2(100)).throttle(1000, 'addCount'),
  ///   child: Text('count: $count'),
  /// )
  /// ```
  ///
  /// 带有参数且获取返回值的例子:
  /// ```dart
  /// void addCount(int value) {
  ///   setState(() {
  ///     count+=value;
  ///   });
  /// }
  /// ElevatedButton(
  ///   onPressed: (() {
  ///     int result = addCount3(100);
  ///     i(result, '得到结果');
  ///   }).throttle(1000, 'addCount'),
  ///   child: Text('count: $count'),
  /// )
  /// ```
  dynamic throttle(int wait, {String? key}) {
    if (wait <= 0) return this;
    key ??= hashCode.toString();
    return () {
      if (_throttleKeyList.contains(key)) return;
      _throttleKeyList.add(key!);
      Timer(Duration(milliseconds: wait), () => _throttleKeyList.remove(key));
      this();
    };
  }

  /// 防抖函数扩展，如果在指定时间内多次执行函数，那么会忽略掉它，并重置等待时间，当等待时间结束后再执行函数
  /// * wait 节流时间(毫秒)
  /// * key 如果目标函数已经定义，那么你可以忽略此参数，但如果是匿名函数，你必须手动添加一个标识符
  /// * leading 是否在等待时间之前执行一次，默认false
  /// * trailing 是否在等待时间结束后执行，默认true
  dynamic debounce(int wait,
      {String? key, bool leading = false, bool trailing = true}) {
    if (wait <= 0) return this;
    key ??= hashCode.toString();

    return () {
      if (_debounceKeyMap.containsKey(key)) {
        _debounceKeyMap[key!]!.cancel();
        _debounceKeyMap[key] = Timer(Duration(milliseconds: wait), () {
          _debounceKeyMap.remove(key);
          if (trailing) this();
        });
        return;
      } else {
        if (leading) this();
        _debounceKeyMap[key!] = Timer(Duration(milliseconds: wait), () {
          _debounceKeyMap.remove(key);
          if (trailing) this();
        });
      }
    };
  }
}
