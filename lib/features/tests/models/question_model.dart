import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Question {
  final int id;
  final int courseId;
  final int sectionId;
  final String title;
  final Map<String, bool> options;

  Question({
    required this.id,
    required this.courseId,
    required this.sectionId,
    required this.title,
    required this.options,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'courseId': courseId,
      'sectionId': sectionId,
      'title': title,
      'options': options,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'] as int,
      courseId: map['courseId'] as int,
      sectionId: map['sectionId'] as int,
      title: map['title'] as String,
      options: Map<String, bool>.from(map['options'] ),
    );
  }

  
}
