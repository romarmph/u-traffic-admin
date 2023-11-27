import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class AttachTicketCard extends StatelessWidget {
  const AttachTicketCard({
    super.key,
    required this.ticket,
  });

  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      color: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      child: ListTile(
        tileColor: UColors.white,
        onTap: () {
          goToTicketView(
            ticket.id!,
            Routes.complaints,
          );
        },
        visualDensity: VisualDensity.comfortable,
        leading: CircleAvatar(
          radius: 14,
          child: Text(
            ticket.issuedViolations.length.toString(),
            style: const UTextStyle()
                .textsmfontmedium
                .copyWith(color: UColors.gray700),
          ),
        ),
        title: Text(
          'Ticket ${ticket.ticketNumber.toString()}',
          style: const UTextStyle()
              .textbasefontmedium
              .copyWith(color: UColors.gray700, fontSize: 16),
        ),
        subtitle: Text(
          'Issued: ${ticket.dateCreated.toAmericanDate}',
          overflow: TextOverflow.ellipsis,
          style: const UTextStyle()
              .textsmfontmedium
              .copyWith(color: UColors.gray500),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: ticket.status == TicketStatus.paid
                    ? UColors.green400
                    : UColors.red400,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                ticket.status == TicketStatus.paid ? 'Paid' : 'Unpaid',
                style: const TextStyle(
                  color: UColors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            Text(
              '₱${getTotalFine(ticket.issuedViolations)}',
              style: const UTextStyle()
                  .textbasefontmedium
                  .copyWith(color: UColors.gray700),
            ),
          ],
        ),
      ),
    );
  }

  String getTotalFine(List<IssuedViolation> violations) {
    var totalFine = 0;

    for (var violation in violations) {
      totalFine += violation.fine as int;
    }

    return totalFine.toString();
  }
}
