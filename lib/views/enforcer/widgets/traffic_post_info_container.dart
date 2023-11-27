import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class TrafficPostInformationContainer extends ConsumerWidget {
  const TrafficPostInformationContainer({
    super.key,
    required this.trafficPostId,
  });

  final String trafficPostId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (trafficPostId.isEmpty) {
      return const Center(
        child: Text('No traffic post assigned'),
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
      child: ref.watch(trafficPostProviderById(trafficPostId)).when(
        data: (data) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: UColors.blue500,
                child: Text(
                  data.number.toString(),
                  style: const TextStyle(
                    color: UColors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(
                width: USpace.space16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.name,
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
                    data.location.address,
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
