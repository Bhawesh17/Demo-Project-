// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleTypeResponse _$VehicleTypeResponseFromJson(Map<String, dynamic> json) =>
    VehicleTypeResponse(
      data:
          (json['data'] as List<dynamic>)
              .map((e) => VehicleType.fromJson(e as Map<String, dynamic>))
              .toList(),
      message: json['message'] as String,
      status: (json['status'] as num).toInt(),
    );

Map<String, dynamic> _$VehicleTypeResponseToJson(
  VehicleTypeResponse instance,
) => <String, dynamic>{
  'data': instance.data,
  'message': instance.message,
  'status': instance.status,
};

VehicleType _$VehicleTypeFromJson(Map<String, dynamic> json) => VehicleType(
  id: json['id'] as String,
  name: json['name'] as String,
  wheels: (json['wheels'] as num).toInt(),
  type: json['type'] as String,
  vehicles:
      (json['vehicles'] as List<dynamic>)
          .map((e) => VehicleItem.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$VehicleTypeToJson(VehicleType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'wheels': instance.wheels,
      'type': instance.type,
      'vehicles': instance.vehicles,
    };

VehicleItem _$VehicleItemFromJson(Map<String, dynamic> json) => VehicleItem(
  id: json['id'] as String,
  name: json['name'] as String,
  vehicleTypeId: json['vehicleTypeId'] as String,
);

Map<String, dynamic> _$VehicleItemToJson(VehicleItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'vehicleTypeId': instance.vehicleTypeId,
    };
