import 'package:educode/utils/constants.dart';
import 'package:hive/hive.dart';

part 'section_model.g.dart';

@HiveType(typeId: sectionModelId)
class SectionModel extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final int courseId;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final String description;

  SectionModel({
    required this.id,
    required this.courseId,
    required this.name,
    required this.description,
  });

  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'courseId': courseId,
      'name': name,
      'description': description,
    };
  }

  factory SectionModel.fromMap(Map<String, dynamic> map) {
    return SectionModel(
      id: map['id'] as int,
      courseId: map['courseId'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
    );
  }
}
