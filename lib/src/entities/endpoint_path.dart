// ignore_for_file: constant_identifier_names

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:yaml/yaml.dart';

part 'endpoint_path.g.dart';

@JsonSerializable(explicitToJson: true)
class EndpointPath extends Equatable {
  const EndpointPath({
    required this.name,
    required this.type,
  });

  factory EndpointPath.fromYaml(YamlMap doc) => EndpointPath(
        name: doc.keys.first as String,
        type: pathTypeFromString(doc.values.first as String),
      );

  factory EndpointPath.fromJson(Map<String, dynamic> json) =>
      _$EndpointPathFromJson(json);

  Map<String, dynamic> toJson() => _$EndpointPathToJson(this);

  final String name;
  final PathType type;

  static PathType pathTypeFromString(String value) {
    switch (value.trim().toLowerCase()) {
      case 'string':
        return PathType.String;
      case 'int':
        return PathType.int;
      default:
        throw UnrecognizedPathType(value);
    }
  }

  @override
  List<Object?> get props => [name, type];
}

enum PathType {
  String,
  int;
}

class UnrecognizedPathType implements Exception {
  UnrecognizedPathType(this.type);

  final String type;

  @override
  String toString() {
    return 'Path type $type are not recognized.';
  }
}
