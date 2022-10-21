// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';

class AuthUser {
  final String id;
  final String name;
  final String email;
  final bool isEmailVerified;

  AuthUser({
    required this.id,
    required this.name,
    required this.email,
    required this.isEmailVerified,
  });

  factory AuthUser.fromFirebase(User user) => AuthUser(
      id: user.uid,
      name: user.displayName ?? 'user',
      email: user.email!,
      isEmailVerified: user.emailVerified);
}
