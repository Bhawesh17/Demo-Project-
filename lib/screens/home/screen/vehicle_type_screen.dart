import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/services/db_helper.dart';
import '../provider/FormProvider.dart';


class WheelsScreen extends StatefulWidget {
  const WheelsScreen({super.key});

  @override
  State<WheelsScreen> createState() => _WheelsScreenState();
}

class _WheelsScreenState extends State<WheelsScreen> {
  int? selected;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadVehicleTypes();
  }

  Future<void> _loadVehicleTypes() async {
    final form = Provider.of<FormProvider>(context, listen: false);
    await form.fetchVehicleTypes();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final form = Provider.of<FormProvider>(context);
    final wheelsOptions = form.availableWheels;
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final void Function() nextPage = args['nextPage'];
    final void Function() prevPage = args['prevPage'];

    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Select Number of Wheels',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          ...wheelsOptions.map((wheel) {
            return RadioListTile<int>(
              title: Text('$wheel Wheels'),
              value: wheel,
              groupValue: selected,
              onChanged: (value) {
                setState(() {
                  selected = value;
                });
              },
            );
          }).toList(),
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
                onPressed: selected == null
                    ? null
                    : () async{
                  final selectedType = form.vehicleTypes.firstWhere(
                        (type) => type.wheels == selected,
                  );
                  form.selectedWheels = selected;
                  form.selectedVehicleTypeId = selectedType.id;
                  form.selectedVehicleType = selectedType;
                  await DBHelper.instance.saveData('selectedWheels', selected.toString());

                  nextPage();
                },
                child: const Text('Next'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
