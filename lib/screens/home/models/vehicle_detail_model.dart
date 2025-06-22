import 'package:json_annotation/json_annotation.dart';

part 'vehicle_detail_model.g.dart';

@JsonSerializable()
class VehicleDetailModel {
  final String id;
  final String name;
  final String vehicleTypeId;
  final String createdAt;
  final String updatedAt;
  final VehicleImage image;

  VehicleDetailModel({
    required this.id,
    required this.name,
    required this.vehicleTypeId,
    required this.createdAt,
    required this.updatedAt,
    required this.image,
  });

  factory VehicleDetailModel.fromJson(Map<String, dynamic> json) =>
      _$VehicleDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleDetailModelToJson(this);
}

@JsonSerializable()
class VehicleImage {
  final String key;
  final String publicURL;

  VehicleImage({required this.key, required this.publicURL});

  factory VehicleImage.fromJson(Map<String, dynamic> json) =>
      _$VehicleImageFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleImageToJson(this);
}
