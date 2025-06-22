// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleDetailModel _$VehicleDetailModelFromJson(Map<String, dynamic> json) =>
    VehicleDetailModel(
      id: json['id'] as String,
      name: json['name'] as String,
      vehicleTypeId: json['vehicleTypeId'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      image: VehicleImage.fromJson(json['image'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VehicleDetailModelToJson(VehicleDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'vehicleTypeId': instance.vehicleTypeId,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'image': instance.image,
    };

VehicleImage _$VehicleImageFromJson(Map<String, dynamic> json) => VehicleImage(
  key: json['key'] as String,
  publicURL: json['publicURL'] as String,
);

Map<String, dynamic> _$VehicleImageToJson(VehicleImage instance) =>
    <String, dynamic>{'key': instance.key, 'publicURL': instance.publicURL};
