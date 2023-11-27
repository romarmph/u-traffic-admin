import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class EnforcerInformationContainer extends ConsumerWidget {
  const EnforcerInformationContainer({
    super.key,
    required this.enforcerId,
  });

  final String enforcerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if(enforcerId.isEmpty) {
      return const Center(
        child: Text('No enforcer assigned'),
      );
    }

    return Container(
      padding: const EdgeInsets.all(USpace.space16),
      decoration: BoxDecoration(
        border: Border.all(
          color: UColors.gray300,
        ),
        borderRadius: BorderRadius.circular(
          USpace.space8,
        ),
      ),
      child: ref.watch(enforcerProviderById(enforcerId)).when(
        data: (data) {
          return Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: CachedNetworkImageProvider(
                  data.photoUrl,
                ),
              ),
              const SizedBox(
                width: USpace.space16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${data.firstName} ${data.middleName} ${data.lastName} ${data.suffix}',
                    style: const TextStyle(
                      color: UColors.gray400,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(
                    height: USpace.space8,
                  ),
                  Text(
                    data.email,
                    style: const TextStyle(
                      color: UColors.gray400,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
        error: (e, s) {
          return const Center(
            child: Text('Error fetching data'),
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
