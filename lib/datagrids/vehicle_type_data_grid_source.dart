import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class VehicleDataGridSource extends DataGridSource {
  VehicleDataGridSource(
    this.vehicleTypes,
    this.ref,
  ) {
    _buildDataGridRows();
  }
  WidgetRef ref;
  List<VehicleType> vehicleTypes = [];
  List<DataGridRow> _vehicleTypeRows = [];

  @override
  List<DataGridRow> get rows => _vehicleTypeRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map((cell) {
        if (cell.columnName == VehicleTypeGridFields.actions) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            alignment: Alignment.center,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(4),
                side: const BorderSide(
                  color: UColors.blue500,
                ),
              ),
              onPressed: () {
                showDialog(
                  context: navigatorKey.currentContext!,
                  builder: (context) {
                    return Dialog(
                      child: VehicleTypeView(
                        vehicleTypeId: cell.value.toString(),
                      ),
                    );
                  },
                );
              },
              child: const Text('View'),
            ),
          );
        }

        if (cell.columnName == VehicleTypeGridFields.dateCreated ||
            cell.columnName == VehicleTypeGridFields.dateEdited) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            alignment: Alignment.center,
            child: Text(
              cell.value.toString().toDateTime.toTimestamp.toAmericanDate,
              overflow: TextOverflow.ellipsis,
            ),
          );
        }

        if (cell.columnName == VehicleTypeGridFields.isPublic) {
          final bool isPublic = cell.value == 'Public';
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            alignment: Alignment.center,
            child: Chip(
              padding: const EdgeInsets.all(4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              side: BorderSide.none,
              backgroundColor: isPublic ? UColors.orange500 : UColors.purple500,
              label: Text(
                cell.value,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: UColors.white,
                  fontSize: 12,
                ),
              ),
            ),
          );
        }

        if (cell.columnName == VehicleTypeGridFields.isHidden) {
          final bool isHidden = cell.value == 'Hidden';
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            alignment: Alignment.center,
            child: Chip(
              padding: const EdgeInsets.all(4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide.none,
              ),
              side: BorderSide.none,
              backgroundColor: isHidden ? UColors.red500 : UColors.green500,
              label: Text(
                cell.value,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: UColors.white,
                  fontSize: 12,
                ),
              ),
            ),
          );
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          alignment: Alignment.center,
          child: Text(
            cell.value.toString(),
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
    );
  }

  void _buildDataGridRows() {
    _vehicleTypeRows = vehicleTypes.map<DataGridRow>((vehicleType) {
      return DataGridRow(
        cells: [
          DataGridCell<String>(
            columnName: VehicleTypeGridFields.vehicleType,
            value: vehicleType.typeName,
          ),
          DataGridCell<String>(
            columnName: VehicleTypeGridFields.isPublic,
            value: vehicleType.isPublic ? 'Public' : 'Private',
          ),
          DataGridCell<String>(
            columnName: VehicleTypeGridFields.isHidden,
            value: vehicleType.isHidden ? 'Hidden' : 'Active',
          ),
          DataGridCell<DateTime>(
            columnName: VehicleTypeGridFields.dateCreated,
            value: vehicleType.dateCreated.toDate(),
          ),
          DataGridCell<String>(
            columnName: VehicleTypeGridFields.actions,
            value: vehicleType.id,
          ),
        ],
      );
    }).toList();
  }
}

class VehicleTypeView extends ConsumerWidget {
  const VehicleTypeView({
    super.key,
    required this.vehicleTypeId,
  });

  final String vehicleTypeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: UColors.white,
      ),
      padding: const EdgeInsets.all(16),
      child: ref.watch(vehicleTypeByIdStream(vehicleTypeId)).when(
          data: (vehicleType) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Vehicle Type Details',
              style: const UTextStyle().textxlfontmedium,
            ),
            PreviewListTile(
              title: vehicleType.typeName,
              subtitle: 'Vehicle Type',
            ),
            const SizedBox(height: 16),
            PreviewListTile(
              title: vehicleType.isPublic ? 'Public' : 'Private',
              subtitle: 'Category',
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Hidden'),
              value: vehicleType.isHidden,
              onChanged: null,
            ),
            const SizedBox(height: 16),
            const Text(
              'Created By',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            ref.watch(getAdminByIdStream(vehicleType.createdBy)).when(
              data: (admin) {
                return PreviewListTile(
                  title: '${admin.firstName} ${admin.lastName}',
                  subtitle: vehicleType.dateCreated.toAmericanDate,
                );
              },
              error: (error, stackTrace) {
                return Text(error.toString());
              },
              loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
            const Text(
              'Edited By',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            vehicleType.editedBy.isNotEmpty
                ? ref.watch(getAdminByIdStream(vehicleType.editedBy)).when(
                    data: (admin) {
                      return PreviewListTile(
                        title: '${admin.firstName} ${admin.lastName}',
                        subtitle: vehicleType.dateCreated.toAmericanDate,
                      );
                    },
                    error: (error, stackTrace) {
                      return Text(error.toString());
                    },
                    loading: () {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  )
                : const SizedBox.shrink(),
            const SizedBox(height: 16),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text('Close'),
                ),
                const SizedBox(width: 16),
                FilledButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    showDialog(
                      context: navigatorKey.currentContext!,
                      builder: (context) {
                        return Dialog(
                          child: ref
                              .watch(vehicleTypeByIdStream(vehicleTypeId))
                              .when(
                            data: (vehicleType) {
                              return VehicleTypeUpdateForm(
                                vehicleType: vehicleType,
                              );
                            },
                            error: (error, stackTrace) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: UColors.white,
                                ),
                                padding: const EdgeInsets.all(16),
                                child: Text(error.toString()),
                              );
                            },
                            loading: () {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: UColors.white,
                                ),
                                padding: const EdgeInsets.all(16),
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                  child: const Text('Update'),
                ),
              ],
            ),
          ],
        );
      }, error: (error, stackTrace) {
        return Text(error.toString());
      }, loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}

class VehicleTypeUpdateForm extends ConsumerStatefulWidget {
  const VehicleTypeUpdateForm({
    super.key,
    required this.vehicleType,
  });

  final VehicleType vehicleType;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      VehicleTypeUpdateFormState();
}

class VehicleTypeUpdateFormState extends ConsumerState<VehicleTypeUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final _typeName = TextEditingController();
  bool _isHidden = false;
  bool _isPublic = true;

  void _updateVehicleType() async {
    if (_formKey.currentState!.validate()) {
      final currentAdmin = ref.read(currentAdminProvider);
      final vehicleType = widget.vehicleType.copyWith(
        dateEdited: Timestamp.now(),
        typeName: _typeName.text,
        isHidden: _isHidden,
        isPublic: _isPublic,
        editedBy: currentAdmin.id,
      );

      try {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.loading,
          title: 'Updating Vehicle Type',
          text: 'Please wait...',
        );
        await VehicleTypeDatabase.instance.updateVehicleType(vehicleType);
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

      await QuickAlert.show(
        context: navigatorKey.currentContext!,
        type: QuickAlertType.success,
        title: 'Success',
        text: 'Vehicle type updated successfully',
      );

      Navigator.pop(navigatorKey.currentContext!);
    }
  }

  @override
  void initState() {
    super.initState();
    _typeName.text = widget.vehicleType.typeName;
    _isHidden = widget.vehicleType.isHidden;
    _isPublic = widget.vehicleType.isPublic;
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
                  onPressed: _updateVehicleType,
                  child: const Text('Update'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
