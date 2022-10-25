
class CourseModel {
  final int id;
  final String name;
  final int numberOfSections;
  final String description;

  CourseModel({
    required this.id,
    required this.name,
    required this.numberOfSections,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'numberOfSections': numberOfSections,
      'description': description,
    };
  }

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      id: map['id'] as int,
      name: map['name'] as String,
      numberOfSections: map['numberOfSections'] as int,
      description: map['description'] as String,
    );
  }

}
