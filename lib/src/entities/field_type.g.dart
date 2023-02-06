// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'field_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FieldType _$FieldTypeFromJson(Map<String, dynamic> json) => FieldType(
      name: json['name'] as String,
      type: ClassType.fromJson(json['type'] as Map<String, dynamic>),
      isList: json['isList'] as bool,
    );

Map<String, dynamic> _$FieldTypeToJson(FieldType instance) => <String, dynamic>{
      'name': instance.name,
      'type': instance.type.toJson(),
      'isList': instance.isList,
    };
