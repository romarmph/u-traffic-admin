import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class PayTicketDetailView extends ConsumerWidget {
  const PayTicketDetailView({
    super.key,
    required this.ticket,
    required this.constraints,
    required this.scaffoldKey,
  });

  final Ticket ticket;
  final BoxConstraints constraints;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appBarHeight = AppBar().preferredSize.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: UColors.white,
                borderRadius: BorderRadius.circular(USpace.space16),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const UBackButton(),
                  const SizedBox(
                    width: USpace.space16,
                  ),
                  Text(
                    "Ticket Number: ",
                    style: const UTextStyle().leadingnonetextlgfontsemibold,
                  ),
                  Text(
                    ticket.ticketNumber.toString(),
                    style: const UTextStyle().textlgfontmedium,
                  ),
                  const Spacer(),
                  UElevatedButton(
                    onPressed: () {
                      scaffoldKey.currentState!.openEndDrawer();
                    },
                    child: const Text("View Evidence"),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(USpace.space20),
          child: Container(
            height: constraints.maxHeight - 100 - appBarHeight - 16,
            padding: const EdgeInsets.all(USpace.space16),
            decoration: BoxDecoration(
              color: UColors.white,
              borderRadius: BorderRadius.circular(USpace.space12),
            ),
            child: Column(
              children: [
                Container(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "Driver Details",
                              style: const UTextStyle().textlgfontsemibold,
                              // textAlign: TextAlign.start,
                            ),
                            const SizedBox(
                              height: USpace.space12,
                            ),
                            PreviewListTile(
                              title: ticket.driverName ?? "",
                              subtitle: 'Driver Name',
                            ),
                            const SizedBox(
                              height: USpace.space8,
                            ),
                            PreviewListTile(
                              title: ticket.licenseNumber ?? "",
                              subtitle: 'License Number',
                            ),
                            const SizedBox(
                              height: USpace.space8,
                            ),
                            PreviewListTile(
                              title: ticket.birthDate == null
                                  ? ""
                                  : ticket.birthDate!.toAmericanDate,
                              subtitle: 'Birtth Date',
                            ),
                            const SizedBox(
                              height: USpace.space8,
                            ),
                            PreviewListTile(
                              title: ticket.address ?? "",
                              subtitle: 'Address',
                            ),
                            const SizedBox(
                              height: USpace.space8,
                            ),
                            PreviewListTile(
                              title: ticket.phone ?? "",
                              subtitle: 'Phone Number',
                            ),
                            const SizedBox(
                              height: USpace.space8,
                            ),
                            PreviewListTile(
                              title: ticket.email ?? "",
                              subtitle: 'Email',
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: USpace.space16,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "Vehicle Details",
                              style: const UTextStyle().textlgfontsemibold,
                              // textAlign: TextAlign.start,
                            ),
                            const SizedBox(
                              height: USpace.space8,
                            ),
                            PreviewListTile(
                              title: ref
                                  .watch(vehicleTypesProvider)
                                  .where((element) =>
                                      element.id == ticket.vehicleTypeID)
                                  .first
                                  .typeName,
                              subtitle: 'Vehicle Type',
                            ),
                            const SizedBox(
                              height: USpace.space8,
                            ),
                            PreviewListTile(
                              title: ticket.plateNumber ?? "",
                              subtitle: 'Plate Number',
                            ),
                            const SizedBox(
                              height: USpace.space8,
                            ),
                            PreviewListTile(
                              title: ticket.conductionOrFileNumber ?? "",
                              subtitle: 'Conduction Number / File Number',
                            ),
                            const SizedBox(
                              height: USpace.space8,
                            ),
                            PreviewListTile(
                              title: ticket.chassisNumber ?? "",
                              subtitle: 'Chassis Number',
                            ),
                            const SizedBox(
                              height: USpace.space8,
                            ),
                            PreviewListTile(
                              title: ticket.engineNumber ?? "",
                              subtitle: 'Engine Number',
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: USpace.space16,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Violations',
                              style: const UTextStyle().textlgfontsemibold,
                              // textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
