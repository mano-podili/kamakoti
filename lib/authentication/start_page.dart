import 'package:flutter/material.dart';
import 'package:kamakoti/utilities/asset_manager.dart';
import 'package:kamakoti/authentication/login_screen.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetManager.bgImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AssetManager.centreImage),
              const SizedBox(height: 30),
              Image.asset(AssetManager.logo),
              const SizedBox(height: 60),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the LoginScreen using Navigator.push
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50, vertical: 15),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text("START"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}