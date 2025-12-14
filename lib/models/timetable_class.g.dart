// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timetable_class.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TimetableClassAdapter extends TypeAdapter<TimetableClass> {
  @override
  final int typeId = 1;

  @override
  TimetableClass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TimetableClass(
      subjectName: fields[0] as String,
      day: fields[1] as int,
      slot: fields[2] as String,
      startTime: fields[3] as String,
      endTime: fields[4] as String,
      room: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TimetableClass obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.subjectName)
      ..writeByte(1)
      ..write(obj.day)
      ..writeByte(2)
      ..write(obj.slot)
      ..writeByte(3)
      ..write(obj.startTime)
      ..writeByte(4)
      ..write(obj.endTime)
      ..writeByte(5)
      ..write(obj.room);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimetableClassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
