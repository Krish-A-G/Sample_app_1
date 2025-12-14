import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/timetable_class.dart';
import 'add_timetable_screen.dart';

class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<TimetableClass>('timetable');
    final today = DateTime.now().weekday;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Today's Classes"),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Class',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddTimetableScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box<TimetableClass> box, _) {
          final todayClasses = box.values
              .where((c) => c.day == today)
              .toList()
            ..sort(
                  (a, b) => a.startTime.compareTo(b.startTime),
            );

          if (todayClasses.isEmpty) {
            return const Center(
              child: Text(
                'No classes today 🎉',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            itemCount: todayClasses.length,
            itemBuilder: (context, index) {
              final cls = todayClasses[index];

              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                child: ListTile(
                  title: Text(
                    cls.subjectName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    '${cls.slot} • ${cls.startTime}-${cls.endTime}\n'
                        'Room: ${cls.room}',
                  ),
                  isThreeLine: true,

                  // ✏️ TAP → EDIT
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AddTimetableScreen(
                          existingClass: cls,
                        ),
                      ),
                    );
                  },

                  // 🗑 LONG PRESS → DELETE
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Delete Class'),
                        content: const Text(
                          'Are you sure you want to delete this class?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () =>
                                Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              cls.delete();
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Delete',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
