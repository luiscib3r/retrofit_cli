// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_endpoint.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiEndpoint _$ApiEndpointFromJson(Map<String, dynamic> json) => ApiEndpoint(
      name: json['name'] as String,
      method: $enumDecode(_$ApiMethodEnumMap, json['method']),
      url: json['url'] as String,
      payload: json['payload'] == null
          ? null
          : ClassType.fromJson(json['payload'] as Map<String, dynamic>),
      response: ClassType.fromJson(json['response'] as Map<String, dynamic>),
      headers: (json['headers'] as List<dynamic>)
          .map((e) => EndpointHeader.fromJson(e as Map<String, dynamic>))
          .toList(),
      paths: (json['paths'] as List<dynamic>)
          .map((e) => EndpointPath.fromJson(e as Map<String, dynamic>))
          .toList(),
      emptyArgs: json['emptyArgs'] as bool,
      open: json['open'] as String? ?? '{',
      close: json['close'] as String? ?? '}',
    );

Map<String, dynamic> _$ApiEndpointToJson(ApiEndpoint instance) =>
    <String, dynamic>{
      'name': instance.name,
      'method': _$ApiMethodEnumMap[instance.method]!,
      'url': instance.url,
      'payload': instance.payload?.toJson(),
      'response': instance.response.toJson(),
      'headers': instance.headers.map((e) => e.toJson()).toList(),
      'paths': instance.paths.map((e) => e.toJson()).toList(),
      'emptyArgs': instance.emptyArgs,
      'open': instance.open,
      'close': instance.close,
    };

const _$ApiMethodEnumMap = {
  ApiMethod.GET: 'GET',
  ApiMethod.POST: 'POST',
  ApiMethod.PUT: 'PUT',
  ApiMethod.DELETE: 'DELETE',
};
