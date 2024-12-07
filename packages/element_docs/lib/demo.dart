import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

@immutable
class Person extends Equatable {
  const Person(this.name, this.age);

  final String name;
  final int age;

  @override
  List<Object> get props => [name];
}
