import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

final sourceTicketProvider = StateProvider.autoDispose<Ticket?>((ref) {
  return null;
});

class CompareTicketPage extends ConsumerStatefulWidget {
  const CompareTicketPage({
    super.key,
    required this.relatedTicketId,
  });

  final String relatedTicketId;

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
    final source = ref.watch(sourceTicketProvider);
    return PageContainer(
      route: Routes.ticketRelated,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CompareTicketColumn(
                          ticketId: source!.id!,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            ListTile(
                              title: Text('Related: ${widget.relatedTicketId}'),
                              trailing: IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class CompareTicketColumn extends ConsumerWidget {
  const CompareTicketColumn({
    super.key,
    required this.ticketId,
  });

  final String ticketId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: UColors.gray100,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ref.watch(getTicketByIdFutureProvider(ticketId)).when(
        data: (data) {
          return Column(
            children: [
              ListTile(
                title: Text('Source: ${data.id}'),
                trailing: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {},
                ),
              ),
            ],
          );
        },
        error: (error, stackTrace) {
          return const Center(
            child: Text(
              'Error fetching ticket',
            ),
          );
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
