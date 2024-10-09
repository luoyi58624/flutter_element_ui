// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../models/json_serializable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) => Person(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      doubleField: (json['doubleField'] as num).toDouble(),
      listField: json['listField'] as List<dynamic>? ??
          [
            'hello',
            'world',
            ['xx']
          ],
      mapField: json['mapField'] as Map<String, dynamic>? ??
          {
            'name': 'hihi',
            'child': {'age': 20}
          },
      time:
          json['time'] == null ? null : DateTime.parse(json['time'] as String),
      son: json['son'] == null
          ? null
          : Son.fromJson(json['son'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'doubleField': instance.doubleField,
      'listField': instance.listField,
      'mapField': instance.mapField,
      'time': instance.time?.toIso8601String(),
      'son': instance.son,
    };

Son _$SonFromJson(Map<String, dynamic> json) => Son(
      name: json['name'] as String,
    );

Map<String, dynamic> _$SonToJson(Son instance) => <String, dynamic>{
      'name': instance.name,
    };
