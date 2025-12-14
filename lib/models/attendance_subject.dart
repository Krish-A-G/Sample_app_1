import 'package:hive/hive.dart';

part 'attendance_subject.g.dart';

@HiveType(typeId: 0)
class AttendanceSubject extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  int attended;

  @HiveField(2)
  int total;

  AttendanceSubject({
    required this.name,
    this.attended = 0,
    this.total = 0,
  });

  double get percentage {
    if (total == 0) return 0;
    return (attended / total) * 100;
  }
}
