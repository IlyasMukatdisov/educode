import 'package:educode/debug/screens/debug_screen.dart';
import 'package:educode/features/auth/controller/auth_controller.dart';
import 'package:educode/features/auth/screens/verify_email.dart';
import 'package:educode/features/courses/screens/home/courses_home_screen.dart';
import 'package:educode/features/intro/screens/intro_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var currentUser = ref.watch(authControllerProvider).currentUser;

    if (currentUser == null) {
      return const IntroScreen();
    } else {
      if (currentUser.emailVerified) {
        // return const CoursesHomeScreen();
        return const CoursesHomeScreen();
      } else {
        return const VerifyEmailScreen();
      }
    }
  }
}
