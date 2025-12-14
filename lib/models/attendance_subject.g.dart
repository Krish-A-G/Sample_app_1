// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_subject.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AttendanceSubjectAdapter extends TypeAdapter<AttendanceSubject> {
  @override
  final int typeId = 0;

  @override
  AttendanceSubject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AttendanceSubject(
      name: fields[0] as String,
      attended: fields[1] as int,
      total: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, AttendanceSubject obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.attended)
      ..writeByte(2)
      ..write(obj.total);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttendanceSubjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
