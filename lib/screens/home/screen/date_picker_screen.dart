import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../utils/services/db_helper.dart';
import '../models/booking_model.dart';
import '../provider/FormProvider.dart';
import '../home_screen.dart';

class DatePickerScreen extends StatefulWidget {
  const DatePickerScreen({super.key});

  @override
  State<DatePickerScreen> createState() => _DatePickerScreenState();
}

class _DatePickerScreenState extends State<DatePickerScreen> {
  final Set<DateTime> _selectedDates = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBookings();
  }

  Future<void> _loadBookings() async {
    final form = Provider.of<FormProvider>(context, listen: false);
    await form.fetchBookingsForSelectedVehicle();
    setState(() => isLoading = false);
  }

  bool _isDateBooked(DateTime date, List<BookingItem> bookedRanges) {
    return bookedRanges.any((booking) {
      final start = DateTime.parse(booking.startDate);
      final end = DateTime.parse(booking.endDate);
      return date.isAfter(start.subtract(const Duration(days: 1))) &&
          date.isBefore(end.add(const Duration(days: 1)));
    });
  }

  @override
  Widget build(BuildContext context) {
    final form = Provider.of<FormProvider>(context);
    final booked = form.bookedRanges;
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final void Function() prevPage = args['prevPage'];

    return Scaffold(
      appBar: AppBar(title: const Text("Select Booking Dates")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          TableCalendar(
            firstDay: DateTime.now(),
            lastDay: DateTime.now().add(const Duration(days: 60)),
            focusedDay: DateTime.now(),
            calendarFormat: CalendarFormat.month,
            availableGestures: AvailableGestures.all,
            selectedDayPredicate: (day) =>
                _selectedDates.any((d) => isSameDay(d, day)),
            onDaySelected: (selectedDay, _) {
              if (_isDateBooked(selectedDay, booked)) return;

              setState(() {
                if (_selectedDates.contains(selectedDay)) {
                  _selectedDates.remove(selectedDay);
                } else {
                  _selectedDates.add(selectedDay);
                }
              });
            },
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, _) {
                final isBooked = _isDateBooked(day, booked);
                final isSelected = _selectedDates.contains(day);

                return Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: isBooked
                        ? Colors.red.withOpacity(0.7)
                        : isSelected
                        ? Colors.green
                        : null,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${day.day}',
                    style: TextStyle(
                      color: isBooked || isSelected
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: prevPage,
                icon: const Icon(Icons.arrow_back),
                label: const Text("Back"),
              ),
              ElevatedButton(
                onPressed: _selectedDates.isEmpty
                    ? null
                    : () async {
                  // Convert selected dates to comma-separated string
                  final selected = _selectedDates
                      .map((d) =>
                  d.toIso8601String().split('T').first)
                      .join(',');

                  // Save to DB
                  await DBHelper.instance
                      .saveData('selectedDates', selected);

                  // Show success dialog then go to home
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Booking Successful ✅'),
                      content: const Text(
                        'Due to a server error, your booking could not be synced.\n\n'
                            'It will be automatically synced once the server is available.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop(); // Close the dialog
                            Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (_) => const HomeScreen()),
                                  (route) => false,
                            );
                          },
                          child: const Text('OK'),
                        )
                      ],
                    ),
                  );

                },
                child: const Text("Submit Booking"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
