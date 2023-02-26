// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educode/model/my_course.dart';
import 'package:educode/utils/constants.dart';
import 'package:educode/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final myCoursesRepositoryProvider = Provider(
  (ref) => MyCoursesRepository(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
  ),
);

class MyCoursesRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  MyCoursesRepository({
    required this.firestore,
    required this.auth,
  });

  Future<int> addCourses({
    required List<MyCourse> myCourses,
    required BuildContext context,
  }) async {
    try {
      String userId = auth.currentUser!.uid;

      for (var course in myCourses) {
        await firestore
            .collection(usersCollection)
            .doc(userId)
            .collection(myCoursesCollection)
            .doc(course.course.id)
            .set(
              course.toMap(),
            );
      }

      return 0;
    } catch (e) {
      Utils.showMessage(context: context, message: e.toString());
      return 1;
    }
  }

  Future<List<MyCourse>> getCourses({required BuildContext context}) async {
    List<MyCourse> myCourses = [];
    try {
      String userId = auth.currentUser!.uid;

      var snapshot = await firestore
          .collection(usersCollection)
          .doc(userId)
          .collection(myCoursesCollection)
          .get();
      for (var doc in snapshot.docs) {
        final myCourse = MyCourse.fromMap(doc.data());
        myCourses.add(myCourse);
      }
      return myCourses;
    } catch (e) {
      Utils.showMessage(context: context, message: e.toString());
    }
    return myCourses;
  }
}
