// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LessonModelAdapter extends TypeAdapter<LessonModel> {
  @override
  final int typeId = 3;

  @override
  LessonModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LessonModel(
      id: fields[0] as int,
      courseId: fields[1] as int,
      sectionId: fields[2] as int,
      name: fields[3] as String,
      text: fields[4] as String,
      codeExample: fields[5] as String,
      codeLanguage: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LessonModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.courseId)
      ..writeByte(2)
      ..write(obj.sectionId)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.text)
      ..writeByte(5)
      ..write(obj.codeExample)
      ..writeByte(6)
      ..write(obj.codeLanguage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LessonModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
