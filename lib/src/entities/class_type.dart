import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit_cli/src/entities/entities.dart';

part 'class_type.g.dart';

@JsonSerializable(explicitToJson: true)
class ClassType extends Equatable {
  const ClassType({
    required this.name,
    required this.fields,
    required this.isList,
    required this.isPrimitive,
  });

  factory ClassType.fromJson(Map<String, dynamic> json) =>
      _$ClassTypeFromJson(json);

  factory ClassType.build(
    String name,
    Map<String, dynamic> json, {
    required bool isList,
  }) =>
      ClassType(
        name: name,
        fields: json.keys
            .map(
              (e) => FieldType(
                name: e,
                type: ClassType.buildFromDynamic(
                  e,
                  json[e],
                  isList: json[e] is List,
                ),
                isList: json[e] is List,
              ),
            )
            .toList(),
        isList: isList,
        isPrimitive: false,
      );

  factory ClassType.buildFromDynamic(
    String fieldName,
    dynamic fieldValue, {
    required bool isList,
  }) {
    if (fieldValue is Map) {
      return ClassType.build(
        fieldName,
        fieldValue as Map<String, dynamic>,
        isList: isList,
      );
    }

    if (fieldValue is List) {
      if (fieldValue.isNotEmpty) {
        return ClassType.buildFromDynamic(
          fieldName,
          fieldValue.first,
          isList: true,
        );
      }
    }

    return ClassType(
      name: fieldValue.runtimeType.toString(),
      fields: const [],
      isList: isList,
      isPrimitive: true,
    );
  }

  Map<String, dynamic> toJson() => _$ClassTypeToJson(this);

  final String name;
  final List<FieldType> fields;
  final bool isList;
  final bool isPrimitive;

  @override
  List<Object?> get props => [
        name,
        fields,
        isList,
        isPrimitive,
      ];

  @override
  bool? get stringify => true;
}
