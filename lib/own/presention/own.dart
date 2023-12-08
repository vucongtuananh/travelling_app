import 'package:flutter/material.dart';
import 'package:travelling_app/login/data/auth/fire_auth.dart';

class OwnDetailScreen extends StatelessWidget {
  const OwnDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Auth _auth = Auth();
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: () => _auth.logOut(), child: Text("")),
      ),
    );
  }
}
