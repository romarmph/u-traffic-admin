import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/theme/data/dark_theme.dart';
import 'package:u_traffic_admin/config/theme/data/light_theme.dart';
import 'config/exports/exports.dart';
import 'package:calendar_view/calendar_view.dart';

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
    return CalendarControllerProvider(
      controller: EventController(),
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: "U-Traffic Admin",
        themeMode: themeMode,
        darkTheme: darkTheme,
        theme: lightTheme,
        onGenerateInitialRoutes: (initialRoute) {
          return [
            MaterialPageRoute(
              builder: (context) => const Wrapper(),
            ),
          ];
        },
        onGenerateRoute: onGenerateRoute,
      ),
    );
  }
}
