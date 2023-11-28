import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class EvidenceCard extends StatelessWidget {
  const EvidenceCard({
    super.key,
    required this.evidence,
  });

  final Evidence evidence;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(
        USpace.space12,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: UColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: UColors.gray200,
        ),
        boxShadow: const [
          BoxShadow(
            color: UColors.gray200,
            blurRadius: 8,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl: evidence.path,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) {
              return const Icon(Icons.error);
            },
            height: 200,
          ),
          ListTile(
            contentPadding: const EdgeInsets.all(0),
            title: Text(evidence.name),
            subtitle: evidence.description != null
                ? Text(evidence.description!)
                : null,
          )
        ],
      ),
    );
  }
}
