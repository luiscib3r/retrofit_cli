// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'endpoint_path.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EndpointPath _$EndpointPathFromJson(Map<String, dynamic> json) => EndpointPath(
      name: json['name'] as String,
      type: $enumDecode(_$PathTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$EndpointPathToJson(EndpointPath instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': _$PathTypeEnumMap[instance.type]!,
    };

const _$PathTypeEnumMap = {
  PathType.String: 'String',
  PathType.int: 'int',
};
