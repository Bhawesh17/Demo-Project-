import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/services/db_helper.dart';
import '../models/vehicle_type_model.dart';
import '../provider/FormProvider.dart';


class ModelScreen extends StatefulWidget {
  const ModelScreen({super.key});

  @override
  State<ModelScreen> createState() => _ModelScreenState();
}

class _ModelScreenState extends State<ModelScreen> {
  VehicleItem? selectedModel;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final form = Provider.of<FormProvider>(context);
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final void Function() nextPage = args['nextPage'];
    final void Function() prevPage = args['prevPage'];

    final vehicleType = form.vehicleTypes.firstWhere(
          (type) => type.wheels == form.selectedWheels,
    );
    final modelList = vehicleType.vehicles;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Select a Vehicle Model',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),

          ...modelList.map((model) {
            return RadioListTile<VehicleItem>(
              title: Text(model.name),
              value: model,
              groupValue: selectedModel,
              onChanged: (value) async {
                setState(() {
                  selectedModel = value;
                  isLoading = true;
                });
                await form.fetchVehicleDetail(value!.id);
                await DBHelper.instance.saveData('vehicleModelName', value.name);
                await DBHelper.instance.saveData('vehicleModelId', value.id);
                await DBHelper.instance.saveData('imageUrl', form.selectedVehicleDetail?.image.publicURL ?? '');
                setState(() {
                  isLoading = false;
                });
              },
            );
          }).toList(),

          if (isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),

          if (!isLoading && form.selectedVehicleDetail != null)
            Column(
              children: [
                const SizedBox(height: 16),
                Image.network(
                  form.selectedVehicleDetail!.image.publicURL,
                  height: 150,
                  fit: BoxFit.contain,
                ),
              ],
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
                onPressed: selectedModel == null ? null : nextPage,
                child: const Text('Next'),
              ),
            ],
          )
        ],
      ),
    );
  }
}