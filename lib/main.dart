import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_rental/screens/home/phone_input_screen.dart';
import 'package:vehicle_rental/screens/home/provider/FormProvider.dart';
import 'package:vehicle_rental/utils/shared_preferences/shared_prefs.dart';
import 'screens/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FormProvider()),
      ],
      child: MaterialApp(
        title: 'Vehicle Rental App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: SharedPrefs().getLogin() == '1'
            ? const HomeScreen()
            : const PhoneInputScreen(),
      ),
    );
  }
}
