import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:kamakoti/authentication/scrapper_login_screen.dart';

class ScraperRegister extends StatefulWidget {
  const ScraperRegister({super.key});

  @override
  @override
  State<ScraperRegister> createState() => _ScraperRegisterState();}

class _ScraperRegisterState extends State<ScraperRegister> {
  final _formKey = GlobalKey<FormState>();
  final _sidController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scraper Register Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form (
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
                          .createUserWithEmailAndPassword(
                        email: _sidController.text,
                        password: _passwordController.text,
                      );

                      // Create a new scraper in the Realtime Database
                      final database = FirebaseDatabase.instance;
                      final scraperRef = database.ref('scrapers/${userCredential.user?.uid}');
                      await scraperRef.set({
                        'sid': _sidController.text,
                        'password': _passwordController.text,
                      });

                      // Navigate to Scraper Login screen
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const ScraperLoginScreen()),
                      );
                    } on FirebaseAuthException catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(e.message ?? 'Registration failed')),
                      );
                    }
                  }
                },
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}