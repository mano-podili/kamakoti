import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../main_screen/scraper_screen.dart';
import 'scraper_register.dart'; // Import the ScraperRegister screen

class ScraperLoginScreen extends StatefulWidget {
  const ScraperLoginScreen({super.key});

  @override
  @override
  State<ScraperLoginScreen> createState() => _ScraperLoginScreenState();}

class _ScraperLoginScreenState extends State<ScraperLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _sidController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scraper Login Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _sidController,
                decoration: const InputDecoration(
                  labelText: 'Scraper ID',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a Scraper ID';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Scraper Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    try {
                      UserCredential userCredential = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                        email: _sidController.text,
                        password: _passwordController.text,
                      );

                      // Check if the scraper ID exists in the Realtime Database
                      final database = FirebaseDatabase.instance;
                      final scraperRef = database.ref('scrapers/${userCredential.user?.uid}');
                      final scraperSnapshot = await scraperRef.get();

                      if (scraperSnapshot.exists) {
                        // Navigate to Scraper Screen
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const ScraperScreen()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Scraper ID not found')),
                        );
                      }
                    } on FirebaseAuthException catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(e.message ?? 'Login failed')),
                      );
                    }
                  }
                },
                child: const Text('Login'),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  // Navigate to Scraper Register screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ScraperRegister()),
                  );
                },
                child: const Text('Register as a new scraper'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}