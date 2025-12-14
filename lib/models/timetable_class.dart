import 'package:hive/hive.dart';

part 'timetable_class.g.dart';

@HiveType(typeId: 1)
class TimetableClass extends HiveObject {
  @HiveField(0)
  String subjectName;

  @HiveField(1)
  int day; // DateTime.monday - DateTime.sunday

  @HiveField(2)
  String slot; // TG1+G1

  @HiveField(3)
  String startTime; // 09:51

  @HiveField(4)
  String endTime; // 10:30

  @HiveField(5)
  String room; // PRP 429

  TimetableClass({
    required this.subjectName,
    required this.day,
    required this.slot,
    required this.startTime,
    required this.endTime,
    required this.room,
  });
}
