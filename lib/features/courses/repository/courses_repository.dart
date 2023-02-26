// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educode/model/course.dart';
import 'package:educode/utils/constants.dart';
import 'package:educode/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseCourseRepositoryProvider = Provider(
  (ref) => CoursesRepository(firestore: FirebaseFirestore.instance),
);

class CoursesRepository {
  final FirebaseFirestore firestore;

  CoursesRepository({
    required this.firestore,
  });

  void setCourses({
    required List<Course> courses,
    required BuildContext context,
  }) async {
    try {
      for (var course in courses) {
        await firestore
            .collection(coursesCollection)
            .doc(course.id.toString())
            .set(course.toMap());
      }
    } catch (e) {
      Utils.showMessage(context: context, message: e.toString());
    }
  }

  Future<List<Course>> getCourses({required BuildContext context}) async {
    List<Course> courses = [];
    try {
      var snapshot = await firestore.collection(coursesCollection).get();
      for (var doc in snapshot.docs) {
        final course = Course.fromMap(doc.data());
        courses.add(course);
      }
    } catch (e) {
      Utils.showMessage(context: context, message: e.toString());
    }
    return courses;
  }
}
