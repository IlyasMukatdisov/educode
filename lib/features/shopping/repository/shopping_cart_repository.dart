// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:educode/model/course.dart';
import 'package:educode/utils/constants.dart';
import 'package:educode/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseShoppingCartRepositoryProvider = Provider(
  (ref) => ShoppingCartRepository(
      firestore: FirebaseFirestore.instance, auth: FirebaseAuth.instance),
);

class ShoppingCartRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  ShoppingCartRepository({required this.firestore, required this.auth});

  // returns 0 if successful 1 if exception 2 if already in cart
  Future<int> addCourse({
    required Course course,
    required BuildContext context,
  }) async {
    try {
      String userId = auth.currentUser!.uid;

      var snapshot = await firestore
          .collection(usersCollection)
          .doc(userId)
          .collection(shoppingCartCollection)
          .doc(course.id)
          .get();
      if (snapshot.exists) {
        return 2;
      }

      await firestore
          .collection(usersCollection)
          .doc(userId)
          .collection(shoppingCartCollection)
          .doc(course.id)
          .set(course.toMap());

      return 0;
    } catch (e) {
      Utils.showMessage(context: context, message: e.toString());
      return 1;
    }
  }

  void deleteCourse({
    required Course course,
    required BuildContext context,
  }) async {
    try {
      String userId = auth.currentUser!.uid;
      await firestore
          .collection(usersCollection)
          .doc(userId)
          .collection(shoppingCartCollection)
          .doc(course.id)
          .delete();
    } catch (e) {
      Utils.showMessage(context: context, message: e.toString());
    }
  }

  void clearCart({
    required BuildContext context,
  }) async {
    try {
      String userId = auth.currentUser!.uid;
      await firestore
          .collection(usersCollection)
          .doc(userId)
          .collection(shoppingCartCollection)
          .get()
          .then(
        (snapshot) {
          for (var doc in snapshot.docs) {
            doc.reference.delete();
          }
        },
      );
    } catch (e) {
      Utils.showMessage(context: context, message: e.toString());
    }
  }

  Future<List<Course>> getCourses({required BuildContext context}) async {
    List<Course> courses = [];
    try {
      String userId = auth.currentUser!.uid;
      List<Course> courses = [];
      var snapshot = await firestore
          .collection(usersCollection)
          .doc(userId)
          .collection(shoppingCartCollection)
          .get();
      for (var doc in snapshot.docs) {
        final course = Course.fromMap(doc.data());
        courses.add(course);
      }
      return courses;
    } catch (e) {
      Utils.showMessage(context: context, message: e.toString());
    }
    return courses;
  }
}
