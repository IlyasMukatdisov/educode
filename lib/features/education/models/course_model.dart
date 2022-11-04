import 'package:hive/hive.dart';

import 'package:educode/utils/constants.dart';

part 'course_model.g.dart';

@HiveType(typeId: courseModelId)
class CourseModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String imagePath;

  CourseModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'imagePath': imagePath,
    };
  }

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      imagePath: map['imagePath'] as String,
    );
  }
}
