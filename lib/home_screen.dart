import 'package:educode/features/auth/controller/auth_controller.dart';
import 'package:educode/features/auth/screens/login_screen.dart';
import 'package:educode/features/auth/screens/verify_email.dart';
import 'package:educode/features/auth/screens/welcome_screen.dart';
import 'package:educode/features/education/screens/courses_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var currentUser = ref.watch(authControllerProvider).currentUser;
    if (currentUser == null) {
      return const WelcomeScreen();
    } else {
      if (currentUser.emailVerified) {
        return const CoursesScreen();
      } else {
        return const VerifyEmailScreen();
      }
    }
  }
}
