// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educode/features/tests/models/question_model.dart';
import 'package:educode/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final testsRepositoryProvider = Provider(
  (ref) => TestsRepository(firebaseFirestore: FirebaseFirestore.instance),
);

class TestsRepository {
  final FirebaseFirestore firebaseFirestore;

  TestsRepository({
    required this.firebaseFirestore,
  });

  void setTest(
      {required String questionId,
      required String courseId,
      required String sectionId,
      required String title,
      required List<String> answers,
      required String correctAnswer}) async {
    try {
      Question question = Question(
          id: int.parse(questionId),
          courseId: int.parse(courseId),
          sectionId: int.parse(sectionId),
          title: title,
          answers: answers,
          correctAnswer: correctAnswer);

      firebaseFirestore
          .collection(coursesCollection)
          .doc(courseId)
          .collection(sectionsCollection)
          .doc(sectionId)
          .collection(testsCollection)
          .doc(questionId)
          .set(question.toMap());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<List<Question>> getTests({
    required String courseId,
    required String sectionId,
  }) async {
    List<Question> tests = [];
    try {
      var snapshot = await firebaseFirestore
          .collection(coursesCollection)
          .doc(courseId)
          .collection(sectionsCollection)
          .doc(sectionId)
          .collection(testsCollection)
          .get();
      for (var doc in snapshot.docs) {
        debugPrint(doc.data().toString());
        tests.add(Question.fromMap(doc.data()));
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return tests;
  }
}
