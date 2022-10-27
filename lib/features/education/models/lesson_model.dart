class LessonModel {
  final int id;
  final String name;
  final String text;
  final String codeExample;

  LessonModel({
    required this.id,
    required this.name,
    required this.text,
    required this.codeExample,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'text': text,
      'codeExample': codeExample,
    };
  }

  factory LessonModel.fromMap(Map<String, dynamic> map) {
    return LessonModel(
      id: map['id'] as int,
      name: map['name'] as String,
      text: map['text'] as String,
      codeExample: map['codeExample'] as String,
    );
  }
}
