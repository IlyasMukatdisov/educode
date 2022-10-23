// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:educode/features/auth/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authControllerProvider = Provider(
  (ref) {
    final authRepository = ref.watch(authRepositoryProvider);
    return AuthController(repository: authRepository);
  },
);

class AuthController {
  final AuthRepository repository;

  AuthController({
    required this.repository,
  });

  User? get currentUser => repository.currentUser;

  Future<void> createUser({
    required String email,
    required String password,
    required BuildContext context,
  }) =>
      repository.createUser(email: email, password: password, context: context);

  Future<void> logOut(BuildContext context) => repository.logOut(context);

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) =>
      repository.signInWithEmailAndPassword(
          email: email, password: password, context: context);

  Future<void> sendEmailVerification(BuildContext context) =>
      repository.sendEmailVerification(context);

  Future<void> sendPasswordReset({
    required String toEmail,
    required BuildContext context,
  }) =>
      repository.sendPasswordReset(toEmail: toEmail, context: context);
}
