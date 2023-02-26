// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educode/model/course.dart';
import 'package:educode/utils/constants.dart';
import 'package:educode/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseRepositoryProvider = Provider(
  (ref) => FirebaseRepository(firestore: FirebaseFirestore.instance),
);

class FirebaseRepository {
  final FirebaseFirestore firestore;

  FirebaseRepository({
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
}
