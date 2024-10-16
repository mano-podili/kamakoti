import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class TaskStatusAndProgressScreen extends StatefulWidget {
  final RegisteredScraper scraper;

  TaskStatusAndProgressScreen({required this.scraper});

  @override
  _TaskStatusAndProgressScreenState createState() => _TaskStatusAndProgressScreenState();
}

class _TaskStatusAndProgressScreenState extends State<TaskStatusAndProgressScreen> {
  final database = FirebaseDatabase.instance;
  String _taskStatus = '';
  int _progress = 0;

  @override
  void initState() {
    super.initState();
    // Fetch task status and progress from Firebase
    _fetchTaskStatusAndProgress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Status and Progress'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'Task Status: $_taskStatus',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Progress: $_progress%',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            LinearProgressIndicator(
              value: _progress / 100,
            ),
          ],
        ),
      ),
    );
  }

  void _fetchTaskStatusAndProgress() async {
    // Fetch task status and progress from Firebase
    final taskStatusRef = database.ref('tasks/${widget.scraper.scraperId}');
    final taskStatusSnapshot = await taskStatusRef.get();

    if (taskStatusSnapshot.exists) {
      final data = taskStatusSnapshot.value as Map<dynamic, dynamic>;
      setState(() {
        _taskStatus = data['taskStatus'] ?? 'Unknown';
        _progress = data['progress'] ?? 0;
      });
    } else {
      setState(() {
        _taskStatus = 'No task found';
        _progress = 0;
      });
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