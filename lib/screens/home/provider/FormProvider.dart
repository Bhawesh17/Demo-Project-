import 'package:flutter/material.dart';
import '../../../utils/services/dio_client.dart';
import '../models/booking_model.dart';
import '../models/vehicle_detail_model.dart';
import '../models/vehicle_type_model.dart';

class FormProvider with ChangeNotifier {
  // Form values
  String? firstName;
  String? lastName;
  int? selectedWheels;
  String? selectedVehicleTypeId;
  String? selectedVehicleModelId;
  DateTimeRange? selectedDateRange;

  VehicleType? selectedVehicleType; // ✅ NEW
  VehicleDetailModel? selectedVehicleDetail;

  List<VehicleType> vehicleTypes = [];
  List<int> availableWheels = [];
  List<BookingItem> bookedRanges = [];

  int currentStep = 0;

  void updateName(String first, String last) {
    firstName = first;
    lastName = last;
    notifyListeners();
  }

  Future<void> fetchVehicleTypes() async {
    try {
      vehicleTypes = await DioClient().getVehicleTypes();
      availableWheels = vehicleTypes.map((e) => e.wheels).toSet().toList()..sort();
      notifyListeners();
    } catch (e) {
      print('Failed to fetch vehicle types: $e');
    }
  }

  Future<void> fetchVehicleDetail(String id) async {
    try {
      selectedVehicleDetail = await DioClient().getVehicleDetail(id);
      notifyListeners();
    } catch (e) {
      print('Error fetching vehicle detail: $e');
    }
  }




  Future<void> fetchBookingsForSelectedVehicle() async {
    if (selectedVehicleDetail == null) return;

    try {
      bookedRanges = await DioClient().getBookings(selectedVehicleDetail!.id);
      notifyListeners();
    } catch (e) {
      print('Error fetching bookings: $e');
    }
  }






}
