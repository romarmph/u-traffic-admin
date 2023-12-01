import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

final sourceTicketProvider = StateProvider<Ticket?>((ref) {
  return null;
});

class CompareTicketPage extends ConsumerStatefulWidget {
  const CompareTicketPage({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CompareTicketPageState();
}

class _CompareTicketPageState extends ConsumerState<CompareTicketPage> {
  @override
  void dispose() {
    if (mounted) {
      ref.invalidate(sourceTicketProvider);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      route: Routes.ticketRelated,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
