import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/attendance_subject.dart';
import '../services/notification_service.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<AttendanceSubject>('attendance');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addSubjectDialog(context),
        child: const Icon(Icons.add),
      ),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box<AttendanceSubject> box, _) {
          if (box.isEmpty) {
            return const Center(
              child: Text('No subjects added'),
            );
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final subject = box.getAt(index)!;
              final percent = subject.percentage;
              final isSafe = percent >= 75;

              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.circle,
                    color: isSafe ? Colors.green : Colors.red,
                    size: 12,
                  ),
                  title: Text(subject.name),
                  subtitle: Text(
                    '${subject.attended}/${subject.total} '
                        '(${percent.toStringAsFixed(1)}%)',
                    style: TextStyle(
                      color: isSafe ? Colors.green : Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        tooltip: 'Attended',
                        icon: const Icon(Icons.check),
                        onPressed: () {
                          subject.attended++;
                          subject.total++;
                          subject.save();
                        },
                      ),
                      IconButton(
                        tooltip: 'Missed',
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          subject.total++;
                          subject.save();

                          if (subject.percentage < 75) {
                            NotificationService.showLowAttendance(
                              subject.name,
                              subject.percentage,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _addSubjectDialog(BuildContext context) {
    final controller = TextEditingController();
    final box = Hive.box<AttendanceSubject>('attendance');

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add Subject'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Subject Name',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final name = controller.text.trim();
              if (name.isNotEmpty) {
                box.add(
                  AttendanceSubject(name: name),
                );
              }
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
