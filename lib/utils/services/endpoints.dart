class Endpoints {
  static const String baseUrl = 'https://octalogic-test-frontend.vercel.app/api/v1';
  static const String vehicleTypes = '/vehicleTypes';
  static String vehicleDetails(String id) => '/vehicles/$id';
  static String bookingDates(String id) => '/bookings/$id';
// submit endpoint is not mentioned, assume `/submit` or similar if needed
}
