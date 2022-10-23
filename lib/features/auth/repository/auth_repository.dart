// ignore_for_file: public_member_api_docs, sort_constructors_first

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

  Future<void> createUser({
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
        return;
      } else {
        throw FirebaseAuthException(code: 'operation-not-allowed');
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, text: e.message ?? "Can't create user");
    } catch (e) {
      showSnackBar(context: context, text: e.toString());
    }
  }

  Future<void> logOut(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    try {
      if (user != null) {
        await FirebaseAuth.instance.signOut();
      } else {
        throw Exception('User not signed in');
      }
    } catch (e) {
      showSnackBar(context: context, text: e.toString());
    }
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      if (currentUser != null) {
        return;
      } else {
        throw FirebaseAuthException(code: 'user-not-found');
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(text: e.message ?? "Can't sign in", context: context);
    }
  }

  Future<void> sendEmailVerification(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    try {
      if (user != null) {
        await user.sendEmailVerification();
      } else {
        throw Exception('User not logged in');
      }
    } catch (e) {
      showSnackBar(context: context, text: e.toString());
    }
  }

  Future<void> sendPasswordReset(
      {required String toEmail, required BuildContext context}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: toEmail);
    } on FirebaseAuthException catch (e) {
      showSnackBar(
          context: context,
          text: e.message ?? "Can't send password reset to your email");
    } catch (e) {
      showSnackBar(context: context, text: e.toString());
    }
  }
}
