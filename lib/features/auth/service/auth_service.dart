// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:educode/features/auth/models/auth_user.dart';
import 'package:educode/features/auth/provider/auth_provider.dart';

class AuthService implements AuthProvider {
  final AuthProvider provider;

  AuthService({
    required this.provider,
  });

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) =>
      provider.createUser(
        email: email,
        password: password,
      );

  @override
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<void> initialize() => provider.initialize();

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) =>
      provider.logIn(
        email: email,
        password: password,
      );

  @override
  Future<void> logOut() => provider.logOut();

  @override
  Future<void> sendEmailVerification() => provider.sendEmailVerification();

  @override
  Future<void> sendPasswordReset({
    required String toEmail,
  }) =>
      provider.sendPasswordReset(
        toEmail: toEmail,
      );
}
