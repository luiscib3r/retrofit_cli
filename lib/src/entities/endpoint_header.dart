import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'endpoint_header.g.dart';

@JsonSerializable(explicitToJson: true)
class EndpointHeader extends Equatable {
  const EndpointHeader(this.name);

  factory EndpointHeader.fromJson(Map<String, dynamic> json) =>
      _$EndpointHeaderFromJson(json);

  Map<String, dynamic> toJson() => _$EndpointHeaderToJson(this);

  final String name;

  @override
  List<Object?> get props => [name];
}
