// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassType _$ClassTypeFromJson(Map<String, dynamic> json) => ClassType(
      name: json['name'] as String,
      fields: (json['fields'] as List<dynamic>)
          .map((e) => FieldType.fromJson(e as Map<String, dynamic>))
          .toList(),
      isList: json['isList'] as bool,
      isPrimitive: json['isPrimitive'] as bool,
    );

Map<String, dynamic> _$ClassTypeToJson(ClassType instance) => <String, dynamic>{
      'name': instance.name,
      'fields': instance.fields.map((e) => e.toJson()).toList(),
      'isList': instance.isList,
      'isPrimitive': instance.isPrimitive,
    };
