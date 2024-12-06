import 'package:flutter_test/flutter_test.dart';

import 'element_generates/models/clone_model.dart';

/// Dart 序列化测试，序列化接口没有什么好测试的地方，这里只做对象克隆测试
void dartSerializeTest() {
  group('Cloneable Test', () {
    test('clone test1', () {
      final user1 = CloneModel(name: 'hihi', age: 20);
      final user2 = CloneModel(name: 'hihi', age: 20);
      expect(user1 != user2, isTrue);
      user2.name = 'xx';
      expect(user1.name, 'hihi');
      expect(user2.name, 'xx');
    });

    test('clone test2', () {
      final user1 = CloneModel2(name: 'hihi', age: 20);
      final user2 = user1;
      expect(user1 == user2, isTrue);
      user2.name = 'xx';
      expect(user1.name, 'xx');
      expect(user2.name, 'xx');
    });

    test('clone test3', () {
      final user1 = CloneModel2(name: 'hihi', age: 20);
      final user2 = user1.clone(); // 调用 clone 方法
      expect(user1 == user2, isFalse); // 对象不相等，符合预期
      user2.name = 'xx';
      expect(user1.name, 'hihi');
      expect(user2.name, 'xx');
    });

    /// 测试覆写了 hashCode、equals 的实体类
    test('clone test4', () {
      final user1 = CloneModel3(name: 'hihi', age: 20);
      final user2 = user1.clone(); // 调用 clone 方法
      expect(user1 == user2, isTrue); // 因为覆写了 equals，所以比较对象相等，符号预期
      user2.name = 'xx';
      expect(user1.name, 'hihi'); // 修改 user2 不会影响 user1
      expect(user2.name, 'xx');
    });
  });
}
