import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class CurrenAdminButton extends ConsumerWidget {
  const CurrenAdminButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final admin = ref.watch(currentAdminProvider);
    return Row(
      children: [
        Text(
          "${admin.firstName} ${admin.lastName}",
          style: const TextStyle(
            color: UColors.gray500,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          width: USpace.space8,
        ),
        CircleAvatar(
          minRadius: 32,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: admin.photoUrl,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: USpace.space12,
        ),
        IconButton(
          onPressed: () {
            SideSheet.right(
              context: context,
              width: MediaQuery.of(context).size.width * 0.3,
              body: Text("Body"),
            );
          },
          icon: const Badge(
            label: Text('1'),
            child: Icon(Icons.notifications),
          ),
        ),
        const SizedBox(
          width: USpace.space12,
        ),
      ],
    );
  }
}
