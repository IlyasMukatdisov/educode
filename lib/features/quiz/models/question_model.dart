// ignore_for_file: public_member_api_docs, sort_constructors_first
class Question {
  final int id;
  final String title;
  final Map<String, bool> options;

  Question({
    required this.id,
    required this.title,
    required this.options,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'options': options,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'] as int,
      title: map['title'] as String,
      options: Map<String, bool>.from(
        (map['options'] as Map<String, bool>),
      ),
    );
  }

  @override
  String toString() => 'Question(id: $id, title: $title, options: $options)';
}
