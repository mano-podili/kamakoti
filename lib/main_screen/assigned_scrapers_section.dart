import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class AssignedScrapersSection extends StatefulWidget {
  const AssignedScrapersSection({super.key});

  @override
  @override
  State<AssignedScrapersSection> createState() => _AssignedScrapersSectionState();}

class _AssignedScrapersSectionState extends State<AssignedScrapersSection> {
  final database = FirebaseDatabase.instance;
  List<AssignedScraper> _assignedScrapers = [];

  @override
  void initState() {
    super.initState();
    _loadAssignedScrapers();
  }

  Future<void> _loadAssignedScrapers() async {
    final assignedScrapersRef = database.ref('assignedScrapers');
    final assignedScrapersSnapshot = await assignedScrapersRef.get();

    if (assignedScrapersSnapshot.exists) {
      final value = assignedScrapersSnapshot.value;
      if (value != null && value is Map) {
        _assignedScrapers = value.entries
            .map((entry) => AssignedScraper.fromJson(entry.value as Map<String, dynamic>))
            .toList();
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Task Assigned Scrapers'),
        Expanded(
          child: ListView.builder(
            itemCount: _assignedScrapers.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_assignedScrapers[index].scraperId),
                subtitle: Text(_assignedScrapers[index].taskId),
              );
            },
          ),
        ),
      ],
    );
  }
}

class AssignedScraper {
  final String scraperId;
  final String taskId;

  AssignedScraper({required this.scraperId, required this.taskId});

  factory AssignedScraper.fromJson(Map<String, dynamic> json) {
    return AssignedScraper(
      scraperId: json['scraperId'],
      taskId: json['taskId'],
    );
  }
}