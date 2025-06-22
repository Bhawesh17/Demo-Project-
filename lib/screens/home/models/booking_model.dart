import 'package:json_annotation/json_annotation.dart';

part 'booking_model.g.dart';

@JsonSerializable()
class BookingItem {
  final String id;
  final String vehicleId;
  final String startDate;
  final String endDate;

  BookingItem({
    required this.id,
    required this.vehicleId,
    required this.startDate,
    required this.endDate,
  });

  factory BookingItem.fromJson(Map<String, dynamic> json) =>
      _$BookingItemFromJson(json);

  Map<String, dynamic> toJson() => _$BookingItemToJson(this);
}
