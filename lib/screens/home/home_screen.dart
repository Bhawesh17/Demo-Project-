import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_rental/screens/home/provider/FormProvider.dart';


class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final PageController _pageController = PageController();

  final List<Widget> _pages = const [

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<FormProvider>(
        builder: (context, form, _) {
          return PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: _pages,
          );
        },
      ),
    );
  }
}
