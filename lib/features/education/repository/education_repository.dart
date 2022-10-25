// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educode/features/education/models/course_model.dart';
import 'package:educode/utils/constants.dart';
import 'package:educode/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final educationRepositoryProvider = Provider(
  (ref) => EducationRepository(firestore: FirebaseFirestore.instance),
);

class EducationRepository {
  final FirebaseFirestore firestore;

  EducationRepository({
    required this.firestore,
  });

  void setCourses(
      {required List<CourseModel> courses,
      required BuildContext context}) async {
    try {
      for (var course in courses) {
        await firestore
            .collection(coursesCollection)
            .doc(course.id.toString())
            .set(course.toMap());
      }
    } catch (e) {
      showSnackBar(context: context, text: e.toString());
    }
  }

  Future<List<CourseModel>> getCourses({required BuildContext context}) async {
    List<CourseModel> courses = [];
    try {
      var snapshot = await firestore.collection(coursesCollection).get();
      for (var doc in snapshot.docs) {
        final course = CourseModel.fromMap(doc.data());
        courses.add(course);
      }
    } catch (e) {
      showSnackBar(context: context, text: e.toString());
    }
    return courses;
  }
}
