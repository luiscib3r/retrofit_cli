import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mason/mason.dart';
import 'package:retrofit_cli/src/entities/entities.dart';
import 'package:yaml/yaml.dart';

part 'api_setup.g.dart';

@JsonSerializable(explicitToJson: true)
class ApiSetup extends Equatable {
  const ApiSetup({
    required this.name,
    required this.endpoints,
  });

  factory ApiSetup.fromYaml(
    YamlMap doc, {
    required Logger logger,
  }) =>
      ApiSetup(
        name: doc['name'] as String,
        endpoints: (doc['endpoints'] as YamlList)
            .nodes
            .map((e) => ApiEndpoint.fromYaml(e as YamlMap, logger: logger))
            .toList(),
      );

  factory ApiSetup.fromJson(Map<String, dynamic> json) =>
      _$ApiSetupFromJson(json);

  Map<String, dynamic> toJson() => _$ApiSetupToJson(this);

  List<Map<String, dynamic>> get responses => endpoints.map((e) {
        _extractModels(e.response);
        final context = {
          'apiName': name,
          'folderName': 'responses',
        };
        return e.response.toJson()..addAll(context);
      }).toList();

  Map<String, dynamic> get responsesFiles => {
        'folderName': 'responses',
        'files': endpoints.map((e) {
          return {'name': e.response.name};
        }).toList(),
      };

  List<Map<String, dynamic>> get payloads =>
      endpoints.where((e) => e.payload != null).map((e) {
        _extractModels(e.payload!);
        final context = {
          'apiName': name,
          'folderName': 'payloads',
        };
        return e.payload!.toJson()..addAll(context);
      }).toList();

  Map<String, dynamic> get payloadsFiles => {
        'folderName': 'payloads',
        'files': endpoints.where((e) => e.payload != null).map((e) {
          return {'name': e.payload!.name};
        }).toList(),
      };

  List<Map<String, dynamic>> get models => _models.map((e) {
        final context = {
          'apiName': name,
          'folderName': 'models',
        };
        return e.toJson()..addAll(context);
      }).toList();

  Map<String, dynamic> get modelsFiles => {
        'folderName': 'models',
        'files': _models.map((e) {
          return {'name': e.name};
        }).toList(),
      };

  final String name;
  final List<ApiEndpoint> endpoints;

  static final Set<ClassType> _models = {};

  static void _extractModels(ClassType classType) {
    for (final fieldType in classType.fields) {
      if (!fieldType.type.isPrimitive) {
        _models.add(fieldType.type);
        _extractModels(fieldType.type);
      }
    }
  }

  @override
  List<Object?> get props => [
        name,
        endpoints,
      ];

  @override
  bool get stringify => true;
}
