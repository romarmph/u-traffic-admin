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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Ticket Details",
                  style: const UTextStyle().textlgfontsemibold,
                  textAlign: TextAlign.start,
                ),
                Row(
                  children: [
                    Expanded(
                      child: PreviewListTile(
                        title: ticket.violationPlace.getAddress,
                        subtitle: 'Violation Location',
                      ),
                    ),
                    Expanded(
                      child: PreviewListTile(
                        title: ticket.violationDateTime.toAmericanDate,
                        subtitle: 'Violation Date',
                      ),
                    ),
                    Expanded(
                      child: PreviewListTile(
                        title: ticket.dateCreated.toAmericanDate,
                        subtitle: 'Date Issued',
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: PreviewListTile(
                        title: ticket.dateCreated.addSevenDays.toAmericanDate,
                        subtitle: 'Expiration Date',
                      ),
                    ),
                    Expanded(
                      child: PreviewListTile(
                        title: ticket.enforcerName,
                        subtitle: 'Enforcer Name',
                      ),
                    ),
                    Expanded(
                      child: PreviewListTile(
                        title: ticket.getStatus.toUpperCase(),
                        subtitle: 'Status',
                        titleStyle: const TextStyle(
                          color: UColors.red400,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Driver Details",
                        style: const UTextStyle().textlgfontsemibold,
                        // textAlign: TextAlign.start,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Vehicle Details",
                        style: const UTextStyle().textlgfontsemibold,
                        // textAlign: TextAlign.start,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Violations",
                        style: const UTextStyle().textlgfontsemibold,
                        // textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: USpace.space12,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
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
                              const SizedBox(
                                height: USpace.space8,
                              ),
                              PreviewListTile(
                                title: ticket.vehicleOwner ?? "",
                                subtitle: 'Vehicle Owner',
                              ),
                              const SizedBox(
                                height: USpace.space8,
                              ),
                              PreviewListTile(
                                title: ticket.vehicleOwnerAddress ?? "",
                                subtitle: 'Vehicle Owner Address',
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: USpace.space16,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: ListView(
                                children: _buildViolationsList(ref),
                              ),
                            ),
                            _buildViolationsListFooter()
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildViolationsList(WidgetRef ref) {
    final violations = ref.watch(violationsProvider);
    List<Widget> ticketViolations = [];

    for (var element in ticket.violationsID) {
      final violation = violations.where((e) => e.id == element).first;
      ticketViolations.add(
        ListTile(
          title: Text(violation.name),
          trailing: Text(
            "${violation.fine} PHP",
            style: const TextStyle(
              color: UColors.red400,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      );
    }

    return ticketViolations;
  }

  Widget _buildViolationsListFooter() {
    return Container(
      padding: const EdgeInsets.all(USpace.space16),
      decoration: BoxDecoration(
          color: UColors.white,
          borderRadius: BorderRadius.circular(USpace.space12),
          boxShadow: const [
            BoxShadow(
              color: UColors.gray300,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ]),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              "Total Fine",
              style: TextStyle(
                color: UColors.red400,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Text(
            "${ticket.totalFine} PHP",
            style: const TextStyle(
              color: UColors.red400,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            width: USpace.space16,
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: UColors.green500,
              foregroundColor: UColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 24,
              ),
            ),
            onPressed: () {
              goToPaymentProcessPage(
                ticket,
              );
            },
            child: const Text(
              "Pay Ticket",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
