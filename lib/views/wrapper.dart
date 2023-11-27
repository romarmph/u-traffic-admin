import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class Wrapper extends ConsumerWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(authStreamProvider).when(
          data: (user) {
            if (user == null) {
              return const LoginPage();
            }

            return ref.watch(getCurrentAdmin).when(
                  data: (admin) {
                    if (admin.status == EmployeeStatus.suspended) {
                      return const LoginErrorPage(
                        title: 'Account Suspended',
                        message:
                            'Your account has been suspended. Please contact your administrator.',
                      );
                    }

                    if (admin.status == EmployeeStatus.terminated) {
                      return const LoginErrorPage(
                        title: 'Account Terminated',
                        message:
                            'Your account has been terminated. Please contact your administrator.',
                      );
                    }
                    ref.watch(enforcerProvider);
                    ref.watch(enforcerSchedProvider);
                    ref.watch(availableEnforcerProvider);
                    ref.watch(availableEnforcerStreamProvider);
                    ref.watch(trafficPostProvider);
                    return const HomePage();
                  },
                  error: (error, stackTrace) {
                    return const LoginErrorPage();
                  },
                  loading: () => const LoginLoadingPage(),
                );
          },
          error: (error, stackTrace) {
            return const LoginErrorPage();
          },
          loading: () => const LoginLoadingPage(),
        );
  }
}
