import 'package:flutter/material.dart';
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

class UTrafficAdmin extends StatelessWidget {
  const UTrafficAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "U-Traffic Admin",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: UColors.blue600,
        ),
        useMaterial3: true,
        fontFamily: GoogleFonts.inter().fontFamily,
        elevatedButtonTheme: elevatedButtonTheme,
        inputDecorationTheme: inputDecorationTheme,
        textButtonTheme: textButtonTheme,
        floatingActionButtonTheme: fabTheme,
        appBarTheme: appBarTheme,
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            textStyle: const UTextStyle().textbasefontmedium,
            side: const BorderSide(
              color: UColors.blue500,
              width: 1.5,
            ),
            foregroundColor: UColors.blue500,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        scaffoldBackgroundColor: UColors.white,
      ),
      initialRoute: Routes.home,
      routes: {
        Routes.home: (context) => const Wrapper(),
        Routes.login: (context) => const LoginPage(),
      },
    );
  }
}
