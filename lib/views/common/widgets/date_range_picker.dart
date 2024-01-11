import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class UDateRangePickerDialog extends ConsumerWidget {
  const UDateRangePickerDialog({
    super.key,
    this.onSubmit,
    this.hideDropdown = false,
  });

  final bool hideDropdown;
  final dynamic Function(Object?)? onSubmit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 500,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          USpace.space8,
        ),
        color: UColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Visibility(
            visible: !hideDropdown,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                StatusTypeDropDown(
                  statusList: const [
                    'Date Issued',
                    'Due Date',
                  ],
                  onChanged: (value) {
                    ref.read(dateType.notifier).state = value!;
                  },
                  value: ref.watch(dateType),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 400,
            width: 400,
            child: SfDateRangePicker(
              selectionMode: DateRangePickerSelectionMode.range,
              showActionButtons: true,
              onCancel: () {
                Navigator.pop(context);
              },
              headerStyle: const DateRangePickerHeaderStyle(
                textAlign: TextAlign.center,
              ),
              onSubmit: onSubmit,
            ),
          ),
        ],
      ),
    );
  }
}
