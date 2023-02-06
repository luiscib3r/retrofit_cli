// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_setup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiSetup _$ApiSetupFromJson(Map<String, dynamic> json) => ApiSetup(
      name: json['name'] as String,
      endpoints: (json['endpoints'] as List<dynamic>)
          .map((e) => ApiEndpoint.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ApiSetupToJson(ApiSetup instance) => <String, dynamic>{
      'name': instance.name,
      'endpoints': instance.endpoints.map((e) => e.toJson()).toList(),
    };
