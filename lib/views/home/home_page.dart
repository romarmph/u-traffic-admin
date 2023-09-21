import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
          },
          child: const Text('Logout'),
        ),
      ),
    );
  }
}
