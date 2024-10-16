import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:kamakoti/main_screen/assign_scraper_to_task_screem.dart';
import 'assigned_scrapers_section.dart'; // Import your AssignedScrapersSection
import 'completed_tasks_section.dart'; // Import your CompletedTasksSection
//import 'assign_scraper_to_task_screen.dart'; // Import your AssignScraperToTaskScreen

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  @override
  State<AdminScreen> createState() => _AdminScreenState();}

class _AdminScreenState extends State<AdminScreen> {
  final database = FirebaseDatabase.instance;
  List<RegisteredScraper> _registeredScrapers = [];

  @override
  void initState() {
    super.initState();
    _loadRegisteredScrapers();
  }

  Future<void> _loadRegisteredScrapers() async {
    final registeredScrapersRef = database.ref('registeredScrapers');
    final registeredScrapersSnapshot = await registeredScrapersRef.get();

    if (registeredScrapersSnapshot.exists) {
      final data = registeredScrapersSnapshot.value;
      if (data != null && data is Map) {
        _registeredScrapers = data.entries
            .map((entry) => RegisteredScraper.fromJson(entry.value as Map<String, dynamic>))
            .toList();
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Screen')),
      body: Row(
        children: [
          Expanded(
            child: AssignedScrapersSection(),
          ),
          Expanded(
            child: CompletedTasksSection(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AssignScraperToTaskScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class RegisteredScraper {
  final String scraperId;

  RegisteredScraper({required this.scraperId});

  factory RegisteredScraper.fromJson(Map<String, dynamic> json) {
    return RegisteredScraper(
      scraperId: json['scraperId'],
    );
  }
}