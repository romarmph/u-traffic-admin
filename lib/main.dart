import 'package:u_traffic_admin/views/wrapper.dart';

import 'config/exports/flutter.dart';
import 'config/exports/packages.dart';

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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "U-Traffic Admin",
      home: Wrapper(),
    );
  }
}
