import 'package:educode/utils/constants.dart';
import 'package:hive/hive.dart';

part 'lesson_model.g.dart';

@HiveType(typeId: lessonModelId)
class LessonModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final int courseId;
  @HiveField(2)
  final int sectionId;
  @HiveField(3)
  final String name;
  @HiveField(4)
  final String text;
  @HiveField(5)
  final String codeExample;
  @HiveField(6)
  final String codeLanguage;

  LessonModel({
    required this.id,
    required this.courseId,
    required this.sectionId,
    required this.name,
    required this.text,
    required this.codeExample,
    required this.codeLanguage,
  });

  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'courseId': courseId,
      'sectionId': sectionId,
      'name': name,
      'text': text,
      'codeExample': codeExample,
      'codeLanguage': codeLanguage,
    };
  }

  factory LessonModel.fromMap(Map<String, dynamic> map) {
    return LessonModel(
      id: map['id'] as int,
      courseId: map['courseId'] as int,
      sectionId: map['sectionId'] as int,
      name: map['name'] as String,
      text: map['text'] as String,
      codeExample: map['codeExample'] as String,
      codeLanguage: map['codeLanguage'] as String,
    );
  }
}
