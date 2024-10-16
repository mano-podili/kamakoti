import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:kamakoti/main_screen/assign_scraper_to_task_screem.dart';

class ScrapersToAssignScreen extends StatefulWidget {
  @override
  _ScrapersToAssignScreenState createState() => _ScrapersToAssignScreenState();
}

class _ScrapersToAssignScreenState extends State<ScrapersToAssignScreen> {
  final database = FirebaseDatabase.instance;
  List<RegisteredScraper> _unassignedScrapers = [];

  @override
  void initState() {
    super.initState();
    _loadUnassignedScrapers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scrapers to Assign')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _unassignedScrapers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_unassignedScrapers[index].scraperId),
                  trailing: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AssignScraperToTaskScreen()),
                      );
                    },
                    child: const Text('Assign'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _loadUnassignedScrapers() async {
    final unassignedScrapersRef = database.ref('registeredScrapers');
    final unassignedScrapersSnapshot = await unassignedScrapersRef.get();

    if (unassignedScrapersSnapshot.exists) {
      final value = unassignedScrapersSnapshot.value;
      if (value != null && value is Map) {
        _unassignedScrapers = value.entries
            .map((entry) => RegisteredScraper.fromJson(entry.value as Map<String, dynamic>))
            .toList();
        setState(() {});
      }
    }
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