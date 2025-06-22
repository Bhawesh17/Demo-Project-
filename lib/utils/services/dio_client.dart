
import 'package:dio/dio.dart';
import '../../screens/home/models/booking_model.dart';
import '../../screens/home/models/vehicle_detail_model.dart';
import '../../screens/home/models/vehicle_type_model.dart';
import 'dio_exception.dart';
import 'endpoints.dart';
import 'interceptors/logger_interceptor.dart';

class DioClient {
  DioClient()
      : _dio = Dio(
          BaseOptions(
            baseUrl: Endpoints.baseUrl,
            responseType: ResponseType.json,
          ),
        )..interceptors.addAll([
            LoggerInterceptor(),
          ]);

  late final Dio _dio;


  Future<List<VehicleType>> getVehicleTypes() async {
    try {
      final response = await _dio.get('/vehicleTypes');
      final parsed = VehicleTypeResponse.fromJson(response.data);
      return parsed.data;
    } on DioException catch (e) {
      final errorMessage = CustomDioException.fromDioError(e).toString();
      throw errorMessage;
    } catch (e) {
      throw 'Unexpected error: $e';
    }
  }

  Future<VehicleDetailModel> getVehicleDetail(String vehicleId) async {
    try {
      final response = await _dio.get('/vehicles/$vehicleId');
      return VehicleDetailModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      final errorMessage = CustomDioException.fromDioError(e).toString();
      throw errorMessage;
    } catch (e) {
      throw 'Unexpected error: $e';
    }
  }

  Future<List<BookingItem>> getBookings(String vehicleId) async {
    try {
      final response = await _dio.get('/bookings/$vehicleId');
      final List list = response.data['data'];
      return list.map((e) => BookingItem.fromJson(e)).toList();
    } on DioException catch (e) {
      final errorMessage = CustomDioException.fromDioError(e).toString();
      throw errorMessage;
    } catch (e) {
      throw 'Unexpected error: $e';
    }
  }


}


