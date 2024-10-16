import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class CompletedTasksSection extends StatefulWidget {
  const CompletedTasksSection({super.key});

  @override
  @override
  State<CompletedTasksSection> createState() => _CompletedTasksSectionState();}

class _CompletedTasksSectionState extends State<CompletedTasksSection> {
  final database = FirebaseDatabase.instance;
  List<CompletedTask> _completedTasks = [];

  @override
  void initState() {
    super.initState();
    _loadCompletedTasks();
  }

  Future<void> _loadCompletedTasks() async {
    final completedTasksRef = database.ref('completedTasks');
    final completedTasksSnapshot = await completedTasksRef.get();

    if (completedTasksSnapshot.exists) {
      final data = completedTasksSnapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        _completedTasks = data.entries
            .map((entry) => CompletedTask.fromJson(entry.value as Map<String, dynamic>))
            .toList();
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Completed Tasks'),
        Expanded(
          child: ListView.builder(
            itemCount: _completedTasks.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_completedTasks[index].taskId),
              );
            },
          ),
        ),
      ],
    );
  }
}

class CompletedTask {
  final String taskId;

  CompletedTask({required this.taskId});

  factory CompletedTask.fromJson(Map<String, dynamic> json) {
    return CompletedTask(
      taskId: json['taskId'],
    );
  }
}