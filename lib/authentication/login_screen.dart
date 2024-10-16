import 'package:flutter/material.dart';
import 'package:kamakoti/authentication/scrapper_login_screen.dart';
import 'package:kamakoti/utilities/asset_manager.dart'; // Assuming this is correct
import 'package:kamakoti/authentication/admin_login_screen.dart';
import 'package:kamakoti/authentication/start_page.dart'; // Assuming this is correct
import 'package:firebase_auth/firebase_auth.dart'; // Add this for Firebase Authentication

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  @override
  State<LoginScreen> createState() => _LoginScreenState();}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const StartPage()),
            );
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true, // Extend content behind AppBar
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage(AssetManager.bgImage), // Replace with actual path
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.8),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: Center( // Center the login elements
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(AssetManager.admin), // Replace with the actual path
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // Navigate to AdminLoginScreen and sign in with Firebase
                  await FirebaseAuth.instance.signInAnonymously();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AdminLoginScreen()),
                  );
                },
                child: const Text('ADMIN'),
              ),
              const SizedBox(height: 20),
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(AssetManager.scraper), // Replace with the actual path
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // Navigate to ScraperLoginScreen and sign in with Firebase
                  await FirebaseAuth.instance.signInAnonymously();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ScraperLoginScreen()),
                  );
                },
                child: const Text('SCRAPER'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}