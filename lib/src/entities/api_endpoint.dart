import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mason/mason.dart';
import 'package:retrofit_cli/src/entities/entities.dart';
import 'package:yaml/yaml.dart';

part 'api_endpoint.g.dart';

@JsonSerializable(explicitToJson: true)
class ApiEndpoint extends Equatable {
  const ApiEndpoint({
    required this.name,
    required this.method,
    required this.url,
    required this.payload,
    required this.response,
    required this.headers,
    required this.paths,
    required this.params,
    required this.emptyArgs,
    this.open = '{',
    this.close = '}',
  });

  factory ApiEndpoint.fromYaml(
    YamlMap doc, {
    required Logger logger,
  }) {
    try {
      final name = doc['name'] as String;

      final payload =
          doc['payload'] != null ? json.decode(doc['payload'] as String) : null;

      final response = json.decode(doc['response'] as String);

      final headers =
          doc['headers'] != null ? doc['headers'] as YamlList : null;

      final paths = doc['paths'] != null ? doc['paths'] as YamlList : null;

      final params = doc['params'] != null ? doc['params'] as YamlList : null;

      return ApiEndpoint(
        name: name,
        method: ApiMethod.fromString(doc['method'] as String),
        url: doc['url'] as String,
        payload: payload != null
            ? ClassType.buildFromDynamic(
                '${name}Payload',
                payload,
                isList: payload is List,
              )
            : null,
        response: ClassType.buildFromDynamic(
          '${name}Response',
          response,
          isList: response is List,
        ),
        headers: headers != null
            ? headers.nodes.map((e) => EndpointHeader(e.toString())).toList()
            : const [],
        paths: paths != null
            ? paths.nodes
                .map((e) => EndpointParam.fromYaml(e as YamlMap))
                .toList()
            : const [],
        params: params != null
            ? params.nodes
                .map((e) => EndpointParam.fromYaml(e as YamlMap))
                .toList()
            : const [],
        emptyArgs: paths == null &&
            payload == null &&
            headers == null &&
            params == null,
      );
    } on FormatException catch (e) {
      logger
        ..err('\n${e.message}. Check your json definitions\n')
        ..err('Endpoint: ${doc['name']}')
        ..err('Payload: ')
        ..err(doc['payload'].toString())
        ..err('Response: ')
        ..err(doc['response'].toString());

      rethrow;
    }
  }

  factory ApiEndpoint.fromJson(Map<String, dynamic> json) =>
      _$ApiEndpointFromJson(json);

  Map<String, dynamic> toJson() => _$ApiEndpointToJson(this);

  final String name;
  final ApiMethod method;
  final String url;
  final ClassType? payload;
  final ClassType response;
  final List<EndpointHeader> headers;
  final List<EndpointParam> paths;
  final List<EndpointParam> params;
  final bool emptyArgs;
  // Curly
  final String open;
  final String close;

  @override
  List<Object?> get props => [
        name,
        method,
        url,
        payload,
        response,
        headers,
        paths,
        params,
        emptyArgs,
        open,
        close,
      ];

  @override
  bool? get stringify => true;
}
