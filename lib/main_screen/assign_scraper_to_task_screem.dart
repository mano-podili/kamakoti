import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class AssignScraperToTaskScreen extends StatefulWidget {
  const AssignScraperToTaskScreen({super.key});

  @override
  State<AssignScraperToTaskScreen> createState() => _AssignScraperToTaskScreenState();
}

class _AssignScraperToTaskScreenState extends State<AssignScraperToTaskScreen> {
  final database = FirebaseDatabase.instance;
  List<RegisteredScraper> _unassignedScrapers = [];
  String _selectedScraperId = '';
  String _digNo = '';
  String _noOfPages = '';
  String _instructions = '';

  @override
  void initState() {
    super.initState();
    _loadUnassignedScrapers();
  }

  Future<void> _loadUnassignedScrapers() async {
    final unassignedScrapersRef = database.ref('registeredScrapers');
    final unassignedScrapersSnapshot = await unassignedScrapersRef.get();

    if (unassignedScrapersSnapshot.exists) {
      final data = unassignedScrapersSnapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        _unassignedScrapers = data.entries
            .map((entry) => RegisteredScraper.fromJson(entry.value as Map<String, dynamic>))
            .toList();
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Assign Scraper to Task')),
      body: Column(
        children: [
          const Text('Unassigned Scrapers'),
          Expanded(
            child: ListView.builder(
              itemCount: _unassignedScrapers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_unassignedScrapers[index].scraperId),
                  onTap: () {
                    setState(() {
                      _selectedScraperId = _unassignedScrapers[index].scraperId;
                    });
                  },
                );
              },
            ),
          ),
          const Text('Task Details'),
          TextFormField(
            decoration: const InputDecoration(labelText: 'DIG No:'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter DIG No:';
              }
              return null;
            },
            onSaved: (value) => _digNo = value!,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'No. of Pages:'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter No. of Pages:';
              }
              return null;
            },
            onSaved: (value) => _noOfPages = value!,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Instructions:'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter Instructions:';
              }
              return null;
            },
            onSaved: (value) => _instructions = value!,
          ),
          ElevatedButton(
            onPressed: () {
              if (_selectedScraperId.isNotEmpty &&
                  _digNo.isNotEmpty &&
                  _noOfPages.isNotEmpty &&
                  _instructions.isNotEmpty) {
                // Assign scraper to task
                final assignedScrapersRef = database.ref('assignedScrapers');
                assignedScrapersRef.push().set({
                  'scraperId': _selectedScraperId,
                  'taskId': _digNo,
                  'noOfPages': _noOfPages,
                  'instructions': _instructions,
                });

                // Send notification to scraper
                final scraperNotificationsRef = database.ref('scraperNotifications');
                scraperNotificationsRef.push().set({
                  'scraperId': _selectedScraperId,
                  'message': 'You have been assigned a new task.',
                });

                Navigator.of(context).pop();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please fill in all fields')),
                );
              }
            },
            child: const Text('Assign'),
          ),
        ],
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