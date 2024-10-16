import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kamakoti/authentication/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(KamakotiApp());
}

class KamakotiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}
