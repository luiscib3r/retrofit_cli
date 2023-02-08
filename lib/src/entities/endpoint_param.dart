// ignore_for_file: constant_identifier_names

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:yaml/yaml.dart';

part 'endpoint_param.g.dart';

@JsonSerializable(explicitToJson: true)
class EndpointParam extends Equatable {
  const EndpointParam({
    required this.name,
    required this.type,
  });

  factory EndpointParam.fromYaml(YamlMap doc) => EndpointParam(
        name: doc.keys.first as String,
        type: paramTypeFromString(doc.values.first as String),
      );

  factory EndpointParam.fromJson(Map<String, dynamic> json) =>
      _$EndpointParamFromJson(json);

  Map<String, dynamic> toJson() => _$EndpointParamToJson(this);

  final String name;
  final ParamType type;

  static ParamType paramTypeFromString(String value) {
    switch (value.trim().toLowerCase()) {
      case 'string':
        return ParamType.String;
      case 'int':
        return ParamType.int;
      case 'double':
        return ParamType.double;
      default:
        throw UnrecognizedPathType(value);
    }
  }

  @override
  List<Object?> get props => [name, type];
}

enum ParamType {
  String,
  int,
  double,
}

class UnrecognizedPathType implements Exception {
  UnrecognizedPathType(this.type);

  final String type;

  @override
  String toString() {
    return 'Path type $type are not recognized.';
  }
}
