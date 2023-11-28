import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class EvidenceDrawer extends ConsumerWidget {
  const EvidenceDrawer({
    super.key,
    required this.ticketNumber,
  });

  final int ticketNumber;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: UColors.white,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Evidence',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: ref.watch(getAllEvidenceStreamProvider(ticketNumber)).when(
              data: (evidences) {
                return ListView.separated(
                  itemCount: evidences.length,
                  itemBuilder: (context, index) {
                    final evidence = evidences[index];
                    return GestureDetector(
                      onTap: () => _viewImage(context, evidence),
                      child: EvidenceCard(
                        evidence: evidence,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: USpace.space12,
                    );
                  },
                );
              },
              error: (error, stackTrace) {
                return const Center(
                  child: Text(
                    'Error fetching ticket. Please try again later.',
                  ),
                );
              },
              loading: () {
                return Container(
                  color: UColors.white,
                  child: const Center(
                    child: LinearProgressIndicator(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _viewImage(BuildContext context, Evidence evidence) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          surfaceTintColor: UColors.white,
          title: Column(
            children: [
              Text(
                evidence.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (evidence.description != null)
                Text(
                  evidence.description!,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
            ],
          ),
          content: SizedBox(
            width: 500,
            height: 500,
            child: CachedNetworkImage(
              imageUrl: evidence.path,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) {
                return const Icon(Icons.error);
              },
              height: 200,
            ),
          ),
          contentPadding: const EdgeInsets.all(USpace.space12),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            )
          ],
          actionsPadding: const EdgeInsets.all(USpace.space12),
          backgroundColor: UColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        );
      },
    );
  }
}
