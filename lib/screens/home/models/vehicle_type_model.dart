import 'package:json_annotation/json_annotation.dart';

part 'vehicle_type_model.g.dart';

@JsonSerializable()
class VehicleTypeResponse {
  final List<VehicleType> data;
  final String message;
  final int status;

  VehicleTypeResponse({
    required this.data,
    required this.message,
    required this.status,
  });

  factory VehicleTypeResponse.fromJson(Map<String, dynamic> json) =>
      _$VehicleTypeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleTypeResponseToJson(this);
}

@JsonSerializable()
class VehicleType {
  final String id;
  final String name;
  final int wheels;
  final String type;
  final List<VehicleItem> vehicles;

  VehicleType({
    required this.id,
    required this.name,
    required this.wheels,
    required this.type,
    required this.vehicles,
  });

  factory VehicleType.fromJson(Map<String, dynamic> json) =>
      _$VehicleTypeFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleTypeToJson(this);
}

@JsonSerializable()
class VehicleItem {
  final String id;
  final String name;
  final String vehicleTypeId;

  VehicleItem({
    required this.id,
    required this.name,
    required this.vehicleTypeId,
  });

  factory VehicleItem.fromJson(Map<String, dynamic> json) =>
      _$VehicleItemFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleItemToJson(this);
}
