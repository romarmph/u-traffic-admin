import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';
import 'package:u_traffic_admin/views/ticket/compare_ticket_page.dart';
import 'package:u_traffic_admin/views/ticket/related_tickets_page.dart';

class TicketDetails extends ConsumerWidget {
  const TicketDetails({
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
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: UColors.gray100,
                      borderRadius: BorderRadius.circular(USpace.space8),
                    ),
                    width: 300,
                    child: ref.watch(relatedTicketsStreamProvider(ticket)).when(
                      data: (data) {
                        return ListTile(
                          onTap: () async {
                            await Future.delayed(
                              const Duration(milliseconds: 100),
                              () => ref
                                  .read(sourceTicketProvider.notifier)
                                  .state = ticket,
                            );

                            Navigator.of(navigatorKey.currentContext!).push(
                              MaterialPageRoute(
                                builder: (context) => RelatedTicketsPage(
                                  ticket: ticket,
                                ),
                              ),
                            );
                          },
                          title: Text(
                            "Related tickets found:",
                            style: const UTextStyle()
                                .leadingnonetextlgfontsemibold,
                          ),
                          subtitle: const Text('Tap to view'),
                          trailing: Text(
                            data.length.toString(),
                            style: const UTextStyle().textlgfontmedium,
                          ),
                        );
                      },
                      error: (error, stackTrace) {
                        return Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: UColors.red500,
                            borderRadius: BorderRadius.circular(USpace.space8),
                          ),
                          child: const Text(
                            "Error fetching related tickets.",
                            style: TextStyle(
                              color: UColors.white,
                            ),
                          ),
                        );
                      },
                      loading: () {
                        return const LoginLoadingPage();
                      },
                    ),
                  ),
                  const SizedBox(
                    width: USpace.space16,
                  ),
                  UElevatedButton(
                    onPressed: () {
                      scaffoldKey.currentState!.openEndDrawer();
                    },
                    child: const Text("View Evidence"),
                  ),
                  const SizedBox(
                    width: USpace.space16,
                  ),
                  Visibility(
                    visible: ticket.getStatus.toLowerCase() == "unpaid",
                    child: UElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: UColors.red500,
                        foregroundColor: UColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(USpace.space8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: USpace.space24,
                          horizontal: USpace.space24,
                        ),
                        textStyle: const UTextStyle().textbasefontmedium,
                      ),
                      onPressed: () async {
                        final bool value = await QuickAlert.show(
                          context: context,
                          type: QuickAlertType.confirm,
                          title: "Cancel Ticket",
                          text: "Are you sure you want to cancel this ticket?",
                          onConfirmBtnTap: () async {
                            Navigator.of(context).pop(true);
                          },
                          onCancelBtnTap: () {
                            Navigator.of(context).pop(false);
                          },
                        );

                        if (!value) {
                          return;
                        }

                        QuickAlert.show(
                          context: navigatorKey.currentContext!,
                          type: QuickAlertType.loading,
                          title: "Cancelling Ticket",
                          text: "Please wait while we cancel the ticket.",
                        );

                        try {
                          await TicketDatabase.instance.updateTicketStatus(
                            id: ticket.id!,
                            status: TicketStatus.cancelled,
                          );
                        } catch (e) {
                          QuickAlert.show(
                            context: navigatorKey.currentContext!,
                            type: QuickAlertType.error,
                            title: "Error",
                            text: "An error occured while cancelling ticket.",
                          );

                          return;
                        }

                        Navigator.of(navigatorKey.currentContext!).pop();

                        await QuickAlert.show(
                          context: navigatorKey.currentContext!,
                          type: QuickAlertType.success,
                          title: "Success",
                          text: "Ticket has been cancelled.",
                        ).then((value) => Navigator.of(context).pop());
                      },
                      child: const Text("Cancel Ticket"),
                    ),
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
                        titleStyle: TextStyle(
                          color: _statusColor(ticket.getStatus),
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
                                children: _buildViolationsList(),
                              ),
                            ),
                            Visibility(
                              visible:
                                  ticket.getStatus.toLowerCase() == "unpaid",
                              child: _buildViolationsListFooter(),
                            ),
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

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case "unpaid":
        return UColors.red500;
      case "paid":
        return UColors.green500;
      case "cancelled":
        return UColors.gray500;
      case "refunded":
        return UColors.yellow500;
      case "submitted":
        return UColors.blue500;
      case "expired":
        return UColors.red500;
      default:
        return UColors.red500;
    }
  }

  List<Widget> _buildViolationsList() {
    List<Widget> ticketViolations = [];

    for (var violation in ticket.issuedViolations) {
      ticketViolations.add(
        ListTile(
          title: Text(
            violation.violation,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: UColors.gray500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Row(
            children: [
              Text(
                violation.penalty,
                style: const TextStyle(
                  fontSize: 14,
                  color: UColors.gray500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: USpace.space4,
              ),
              Text(
                violation.offense == 1
                    ? '1st Offense'
                    : violation.offense == 2
                        ? '2nd Offense'
                        : '3rd Offense',
                style: TextStyle(
                  fontSize: 14,
                  color: violation.offense == 1
                      ? UColors.green500
                      : violation.offense == 2
                          ? UColors.yellow500
                          : UColors.red500,
                ),
              ),
            ],
          ),
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
              // showDialog(
              //   context: navigatorKey.currentContext!,
              //   builder: (context) {
              //     return Dialog(
              //       insetPadding: EdgeInsets.zero,
              //       child: PaymentForm(),
              //     );
              //   },
              // );
              goToPaymentProcessPage(ticket);
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

class PaymentForm extends ConsumerStatefulWidget {
  const PaymentForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PaymentFormState();
}

class _PaymentFormState extends ConsumerState<PaymentForm> {
  final _oRNumberController = TextEditingController();
  final _confirmORNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: UColors.white,
        borderRadius: BorderRadius.circular(USpace.space12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Payment Form",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Instructions to fill up the physical form first
          const SizedBox(
            height: USpace.space16,
          ),
          const Text(
            "Please fill up the Official Receipt then use the OR Number to pay this ticket.",
            style: TextStyle(
              fontSize: 14,
              color: UColors.gray500,
            ),
          ),
          const SizedBox(
            height: USpace.space16,
          ),
          TextFormField(
            controller: _oRNumberController,
            decoration: const InputDecoration(
              labelText: "OR Number",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: USpace.space16,
          ),
          TextFormField(
            controller: _confirmORNumberController,
            decoration: const InputDecoration(
              labelText: "Confirm OR Number",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: USpace.space16,
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
            onPressed: () async {},
            child: const Text(
              "Submit",
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
