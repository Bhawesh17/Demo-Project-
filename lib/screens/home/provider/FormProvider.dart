import 'package:flutter/material.dart';

class FormProvider with ChangeNotifier {
  final PageController pageController = PageController();

  // Form values
  String? firstName;
  String? lastName;
  int? selectedWheels;
  String? selectedVehicleTypeId;
  String? selectedVehicleModelId;
  DateTimeRange? selectedDateRange;

  int currentStep = 0;

  void nextPage() {
    if (currentStep < 4) {
      currentStep++;
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    }
  }

  void updateName(String first, String last) {
    firstName = first;
    lastName = last;
    notifyListeners();
  }


}
