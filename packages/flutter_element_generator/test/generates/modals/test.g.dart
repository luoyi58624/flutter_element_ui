// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../modals/test.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

TestModel _fromJson(Map<String, dynamic> json) => TestModel(
      id: (json['id'] ?? '').toString(),
      username: json['username']?.toString(),
      books: num.tryParse(json['books'].toString()) ?? 0.0,
      users: num.tryParse(json['users'].toString()),
      age: int.tryParse((json['user_age'] ?? 20).toString()) ?? 0,
      money: int.tryParse(json['money'].toString()),
      isSon:
          bool.tryParse((json['isSon'] ?? json['is_son']).toString()) ?? false,
      isDog: bool.tryParse((json['isDog'] ?? json['is_dog']).toString()),
      width: double.tryParse(json['width'].toString()) ?? 0.0,
      maxHeight:
          double.tryParse((json['maxHeight'] ?? json['max_height']).toString()),
      peoples: ElSerializeUtil.safeList<String>(
              json['peoples'], 'TestModel', 'peoples') ??
          [],
      myList: ElSerializeUtil.safeList<dynamic>(
          (json['myList'] ?? json['my_list']), 'TestModel', 'myList'),
      numList: ElSerializeUtil.safeList<num>(
              (json['numList'] ?? json['num_list']), 'TestModel', 'numList') ??
          [],
      myMap: ElSerializeUtil.safeMap<dynamic>(
              (json['myMap'] ?? json['my_map']), 'TestModel', 'myMap') ??
          {},
      userModel: (json['userModel'] ?? json['user_model']),
    );

extension TestModelExtension on TestModel {
  Map<String, dynamic> _toJson() {
    return {
      'id': id,
      'username': username,
      'books': books,
      'users': users,
      'user_age': age,
      'money': money,
      'is_son': isSon,
      'is_dog': isDog,
      'width': width,
      'max_height': maxHeight,
      'peoples': peoples,
      'my_list': myList,
      'num_list': numList,
      'my_map': myMap,
      'user_model': userModel,
    };
  }

  TestModel copyWith({
    String? id,
    String? username,
    num? books,
    num? users,
    int? age,
    int? money,
    bool? isSon,
    bool? isDog,
    double? width,
    double? maxHeight,
    List<String>? peoples,
    List<dynamic>? myList,
    List<num>? numList,
    Map<String, dynamic>? myMap,
    UserModel? userModel,
  }) {
    return TestModel(
      id: id ?? this.id,
      username: username ?? this.username,
      books: books ?? this.books,
      users: users ?? this.users,
      age: age ?? this.age,
      money: money ?? this.money,
      isSon: isSon ?? this.isSon,
      isDog: isDog ?? this.isDog,
      width: width ?? this.width,
      maxHeight: maxHeight ?? this.maxHeight,
      peoples: peoples ?? this.peoples,
      myList: myList ?? this.myList,
      numList: numList ?? this.numList,
      myMap: myMap ?? this.myMap,
      userModel: this.userModel.merge(userModel),
    );
  }

  TestModel merge([TestModel? other]) {
    if (other == null) return this;
    return copyWith(
      id: other.id,
      username: other.username,
      books: other.books,
      users: other.users,
      age: other.age,
      money: other.money,
      isSon: other.isSon,
      isDog: other.isDog,
      width: other.width,
      maxHeight: other.maxHeight,
      peoples: other.peoples,
      myList: other.myList,
      numList: other.numList,
      myMap: other.myMap,
      userModel: userModel.merge(other.userModel),
    );
  }

  String _toString() {
    return 'TestModel{id: $id,username: $username,books: $books,users: $users,age: $age,money: $money,isSon: $isSon,isDog: $isDog,width: $width,maxHeight: $maxHeight,peoples: $peoples,myList: $myList,numList: $numList,myMap: $myMap,userModel: $userModel}';
  }
}
