import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'services/notification_service.dart';
import 'screens/attendance_screen.dart';
import 'screens/home_screen.dart';

import 'models/attendance_subject.dart';
import 'models/timetable_class.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(AttendanceSubjectAdapter());
  Hive.registerAdapter(TimetableClassAdapter());

  await Hive.openBox<AttendanceSubject>('attendance');
  await Hive.openBox<TimetableClass>('timetable');
  await NotificationService.init();


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}


