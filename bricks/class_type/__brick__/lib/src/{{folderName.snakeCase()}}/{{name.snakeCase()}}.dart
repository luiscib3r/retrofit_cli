import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:{{apiName.snakeCase()}}_api/{{apiName.snakeCase()}}_api.dart';

part '{{name.snakeCase()}}.g.dart';

@JsonSerializable(explicitToJson: true)
class {{name.pascalCase()}} extends Equatable {
  const {{name.pascalCase()}}({
    {{#fields}}
    required this.{{name.camelCase()}},
    {{/fields}}
  });

  factory {{name.pascalCase()}}.fromJson(Map<String, dynamic> json) => _${{name.pascalCase()}}FromJson(json);

  Map<String, dynamic> toJson() => _${{name.pascalCase()}}ToJson(this);

  {{#fields}}
  @JsonKey(name: '{{name}}')
  final {{#isList}}List<{{/isList}}{{^type.isPrimitive}}{{type.name.pascalCase()}}{{/type.isPrimitive}}{{#type.isPrimitive}}{{type.name}}{{/type.isPrimitive}}{{#isList}}>{{/isList}} {{name.camelCase()}};
  {{/fields}}

  @override
  List<Object?> get props => [
    {{#fields}}
      {{name.camelCase()}},
    {{/fields}}
  ];

  @override
  bool? get stringify => true;
}
