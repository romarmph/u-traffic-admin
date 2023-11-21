import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class AssignableEnforcerListView extends ConsumerWidget {
  const AssignableEnforcerListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(availableEnforcerStreamProvider).when(
          data: (data) {
            final query = ref.watch(unassignedEnforcerSearchProvider);

            data = _searchEnforcer(data, query);

            if (data.isEmpty && query.isNotEmpty) {
              return const Center(
                child: Text('Enforcer not found'),
              );
            }

            if (data.isEmpty && query.isEmpty) {
              return const Center(
                child: Text('No available enforcer'),
              );
            }

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final Enforcer enforcer = data[index];
                bool isSelected = ref.watch(selectedEnforcerProvider) != null
                    ? ref.watch(selectedEnforcerProvider)!.id == enforcer.id
                    : false;
                final String name =
                    '${enforcer.firstName} ${enforcer.middleName} ${enforcer.lastName}';
                return EnforcerSelectionTile(
                  isSelected: isSelected,
                  onChanged: (value) {
                    if (value!) {
                      ref.read(selectedEnforcerProvider.notifier).state =
                          enforcer;
                    } else {
                      ref.read(selectedEnforcerProvider.notifier).state = null;
                    }
                  },
                  name: name,
                  employeeNumber: enforcer.employeeNumber,
                  photoUrl: enforcer.photoUrl,
                );
              },
            );
          },
          error: (error, stackTrace) {
            return const Center(
              child: Text('Error'),
            );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        );
  }

  List<Enforcer> _searchEnforcer(
    List<Enforcer> enforcers,
    String query,
  ) {
    if (query.isEmpty) {
      return enforcers;
    }

    return enforcers.where((element) {
      final name =
          '${element.firstName} ${element.middleName} ${element.lastName} ${element.suffix}';
      return name.toLowerCase().contains(query.toLowerCase()) ||
          element.employeeNumber.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}
