import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/theme/data/dark_theme.dart';
import 'package:u_traffic_admin/config/theme/data/light_theme.dart';
import 'config/exports/exports.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: UTrafficAdmin(),
    ),
  );
}

class UTrafficAdmin extends ConsumerWidget {
  const UTrafficAdmin({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: "U-Traffic Admin",
      themeMode: themeMode,
      darkTheme: darkTheme,
      theme: lightTheme,
      initialRoute: Routes.home,
      routes: {
        Routes.home: (context) => const Wrapper(),
        Routes.login: (context) => const LoginPage(),
      },
    );
  }
}
