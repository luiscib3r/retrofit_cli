import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit_cli/src/entities/entities.dart';

part 'field_type.g.dart';

@JsonSerializable(explicitToJson: true)
class FieldType extends Equatable {
  const FieldType({
    required this.name,
    required this.type,
    required this.isList,
  });

  factory FieldType.fromJson(Map<String, dynamic> json) =>
      _$FieldTypeFromJson(json);

  Map<String, dynamic> toJson() => _$FieldTypeToJson(this);

  final String name;
  final ClassType type;
  final bool isList;

  @override
  List<Object?> get props => [
        name,
        type,
        isList,
      ];

  @override
  bool? get stringify => true;
}
