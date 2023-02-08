// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'endpoint_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EndpointParam _$EndpointParamFromJson(Map<String, dynamic> json) =>
    EndpointParam(
      name: json['name'] as String,
      type: $enumDecode(_$ParamTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$EndpointParamToJson(EndpointParam instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': _$ParamTypeEnumMap[instance.type]!,
    };

const _$ParamTypeEnumMap = {
  ParamType.String: 'String',
  ParamType.int: 'int',
  ParamType.double: 'double',
};
