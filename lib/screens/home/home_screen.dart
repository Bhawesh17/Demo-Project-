import 'package:flutter/material.dart';
import 'package:vehicle_rental/screens/home/screen/vehicle_type_screen.dart';
import 'package:vehicle_rental/utils/services/db_helper.dart';
import 'package:vehicle_rental/utils/shared_preferences/shared_prefs.dart';
import 'screen/name_screen.dart';
import 'screen/wheels_screen.dart';
import 'screen/model_screen.dart';
import 'screen/date_picker_screen.dart';
import 'phone_input_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _controller = PageController();
  bool showPreview = true;
  Map<String, String> dbData = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDbData();
  }

  Future<void> _loadDbData() async {
    try {
      final data = await DBHelper.instance.loadAllData();
      setState(() {
        dbData = data;
        isLoading = false;
      });
    } catch (e) {
      debugPrint("Error loading DB data: $e");
      setState(() {
        isLoading = false;
        dbData = {};
      });
    }
  }

  void nextPage() {
    _controller.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void prevPage() {
    _controller.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Widget _buildWithNav(Widget screen) {
    return Navigator(
      onGenerateRoute: (_) => MaterialPageRoute(
        builder: (_) => screen,
        settings: RouteSettings(arguments: {
          'nextPage': nextPage,
          'prevPage': prevPage,
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      _buildWithNav(const NameScreen()),
      _buildWithNav(const WheelsScreen()),
      _buildWithNav(const ModelScreen()),
      _buildWithNav(const DatePickerScreen()),
    ];

    if (showPreview) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Booking Summary'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                await SharedPrefs().isLogin('0');
                if (!mounted) return;
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const PhoneInputScreen()),
                      (route) => false,
                );
              },
            ),
          ],
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : dbData.isEmpty
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("No booking data found."),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    showPreview = false;
                  });
                },
                child: const Text("Start Booking"),
              )
            ],
          ),
        )
            : SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (dbData['imageUrl'] != null && dbData['imageUrl']!.isNotEmpty)
                    Image.network(
                      dbData['imageUrl']!,
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Name: ${dbData['firstName']} ${dbData['lastName']}",
                            style: const TextStyle(fontSize: 18)),
                        const SizedBox(height: 8),
                        Text("Wheels: ${dbData['selectedWheels']}",
                            style: const TextStyle(fontSize: 18)),
                        const SizedBox(height: 8),
                        Text("Model: ${dbData['vehicleModelName']}",
                            style: const TextStyle(fontSize: 18)),
                        const SizedBox(height: 8),
                        Text("Dates: ${dbData['selectedDates']}",
                            style: const TextStyle(fontSize: 18)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showPreview = false;
                    });
                  },
                  child: const Text("Edit / Start Booking"),
                ),
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: PageView(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
      ),
    );
  }
}
