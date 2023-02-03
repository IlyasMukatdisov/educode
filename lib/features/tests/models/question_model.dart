import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Question {
  final int id;
  final int courseId;
  final int sectionId;
  final String title;
  final List<String> answers;
  final String correctAnswer;
  Question(
      {required this.id,
      required this.courseId,
      required this.sectionId,
      required this.title,
      required this.answers,
      required this.correctAnswer});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'courseId': courseId,
      'sectionId': sectionId,
      'title': title,
      'answers': answers,
      'correctAnswer': correctAnswer,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
        id: map['id'] as int,
        courseId: map['courseId'] as int,
        sectionId: map['sectionId'] as int,
        title: map['title'] as String,
        answers: List<String>.from((map['answers'])
          ..add(map['correctAnswer'] as String)
          ..shuffle()),
        correctAnswer: map['correctAnswer'] as String);
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source) as Map<String, dynamic>);
}
