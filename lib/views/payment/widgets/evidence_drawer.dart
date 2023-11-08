import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class EvidenceDrawer extends ConsumerWidget {
  const EvidenceDrawer({
    super.key,
    required this.ticketID,
  });

  final String ticketID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final evidences = ref.watch(getAllEvidenceProvider(ticketID));

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Text(
            'Evidence',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: ListView.separated(
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
          content: SizedBox(
            width: 500,
            height: 500,
            child: CachedNetworkImage(
              width: 500,
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
