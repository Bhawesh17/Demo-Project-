// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingItem _$BookingItemFromJson(Map<String, dynamic> json) => BookingItem(
  id: json['id'] as String,
  vehicleId: json['vehicleId'] as String,
  startDate: json['startDate'] as String,
  endDate: json['endDate'] as String,
);

Map<String, dynamic> _$BookingItemToJson(BookingItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'vehicleId': instance.vehicleId,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
    };
