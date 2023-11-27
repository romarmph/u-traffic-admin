import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class CreateVehicleTypeForm extends ConsumerStatefulWidget {
  const CreateVehicleTypeForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      CreateVehicleTypeFormState();
}

class CreateVehicleTypeFormState extends ConsumerState<CreateVehicleTypeForm> {
  final _formKey = GlobalKey<FormState>();
  final _typeName = TextEditingController();
  bool _isHidden = false;
  bool _isPublic = true;

  void _createVehicleType() async {
    if (_formKey.currentState!.validate()) {
      final currentAdmin = ref.read(currentAdminProvider);
      final vehicleType = VehicleType(
        id: null,
        typeName: _typeName.text,
        dateCreated: Timestamp.now(),
        createdBy: currentAdmin.id!,
        isCommon: false,
        isPublic: _isPublic,
        isHidden: _isHidden,
      );

      try {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.loading,
          title: 'Creating Vehicle Type',
          text: 'Please wait...',
        );
        await VehicleTypeDatabase.instance.addVehicleType(vehicleType);
        Navigator.pop(navigatorKey.currentContext!);
      } catch (e) {
        await QuickAlert.show(
          context: navigatorKey.currentContext!,
          type: QuickAlertType.error,
          title: 'Error',
          text: 'Failed to create vehicle type',
        );
        Navigator.pop(navigatorKey.currentContext!);
        return;
      }

      Navigator.pop(navigatorKey.currentContext!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: 400,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: UColors.white,
        borderRadius: BorderRadius.circular(USpace.space12),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Vehicle Type Details',
              style: const UTextStyle().textxlfontmedium,
            ),
            const SizedBox(
              height: USpace.space16,
            ),
            TextFormField(
              controller: _typeName,
              decoration: const InputDecoration(
                labelText: "Vehicle Type Name",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a vehicle type name';
                }
                return null;
              },
            ),
            const SizedBox(
              height: USpace.space16,
            ),
            SwitchListTile(
              value: _isHidden,
              onChanged: (value) {
                setState(() {
                  _isHidden = value;
                });
              },
              title: const Text('Set as Hidden'),
            ),
            SwitchListTile(
              value: _isPublic,
              onChanged: (value) {
                setState(() {
                  _isPublic = value;
                });
              },
              title: const Text('Public'),
            ),
            SwitchListTile(
              value: !_isPublic,
              onChanged: (value) {
                setState(() {
                  _isPublic = !value;
                });
              },
              title: const Text('Private'),
            ),
            const Spacer(),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: _createVehicleType,
                  child: const Text('Create'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
