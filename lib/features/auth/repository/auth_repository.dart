import 'package:educode/features/my_courses/repository/my_courses_repository.dart';
import 'package:educode/features/shopping/repository/shopping_cart_repository.dart';
import 'package:educode/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(auth: FirebaseAuth.instance),
);

class AuthRepository {
  final FirebaseAuth auth;

  AuthRepository({
    required this.auth,
  });

  User? get currentUser => auth.currentUser;

  Future<int> createUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        return 0;
      } else {
        throw FirebaseAuthException(code: 'operation-not-allowed');
      }
    } on FirebaseAuthException catch (e) {
      Utils.showMessage(
          context: context, message: e.message ?? "Can't create user");
      return 1;
    } catch (e) {
      Utils.showMessage(context: context, message: e.toString());
      return 1;
    }
  }

  Future<int> logOut(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    try {
      if (user != null) {
        await FirebaseAuth.instance.signOut();
        return 0;
      } else {
        throw Exception('User not signed in');
      }
    } catch (e) {
      Utils.showMessage(context: context, message: e.toString());
      return 1;
    }
  }

  Future<int> signInWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      if (currentUser != null) {
        return 0;
      } else {
        throw FirebaseAuthException(code: 'user-not-found');
      }
    } on FirebaseAuthException catch (e) {
      Utils.showMessage(
          message: e.message ?? "Can't sign in", context: context);
      return 1;
    }
  }

  Future<int> sendEmailVerification(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    try {
      if (user != null) {
        await user.sendEmailVerification();
        return 0;
      } else {
        throw Exception('User not logged in');
      }
    } catch (e) {
      Utils.showMessage(context: context, message: e.toString());
      return 1;
    }
  }

  Future<int> sendPasswordReset(
      {required String toEmail, required BuildContext context}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: toEmail);
      return 0;
    } on FirebaseAuthException catch (e) {
      Utils.showMessage(
          context: context,
          message: e.message ?? "Can't send password reset to your email");
      return 1;
    } catch (e) {
      Utils.showMessage(context: context, message: e.toString());
      return 1;
    }
  }
}
