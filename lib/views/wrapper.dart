import '../config/exports/flutter.dart';
import '../config/exports/packages.dart';
import '../config/exports/riverpod.dart';
import '../config/exports/views.dart';

class Wrapper extends ConsumerWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStateChanges = ref.watch(authStateChangesProvider);
    return authStateChanges.when(
      data: (user) {
        if (user == null) {
          return const LoginPage();
        }

        return const HomePage();
      },
      error: (error, stackTrace) {
        return Text('Error: $error');
      },
      loading: () => const CircularProgressIndicator(),
    );
  }
}
