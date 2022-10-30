
import 'package:educode/utils/constants.dart';
import 'package:hive/hive.dart';

part 'course_model.g.dart';

@HiveType(typeId: courseModelId)
class CourseModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String description;

  CourseModel({
    required this.id,
    required this.name,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
    };
  }

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
    );
  }
}
