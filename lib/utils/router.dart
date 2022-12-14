import 'package:educode/features/auth/screens/login_screen.dart';
import 'package:educode/features/auth/screens/register_screen.dart';
import 'package:educode/features/auth/screens/reset_password_screen.dart';
import 'package:educode/features/auth/screens/verify_email.dart';
import 'package:educode/features/auth/screens/welcome_screen.dart';
import 'package:educode/features/education/screens/courses_screen.dart';
import 'package:educode/features/education/screens/debug_screen.dart';
import 'package:educode/features/education/screens/lesson_screen.dart';
import 'package:educode/features/education/screens/lessons_screen.dart';
import 'package:educode/features/education/screens/sections_screen.dart';
import 'package:educode/features/tests/screens/test_sections.dart';
import 'package:educode/features/tests/screens/tests_courses.dart';
import 'package:educode/features/tests/screens/tests_screen.dart';
import 'package:educode/utils/screens/error_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );
    case RegisterScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const RegisterScreen(),
      );
    case ResetPasswordScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const ResetPasswordScreen(),
      );
    case VerifyEmailScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const VerifyEmailScreen(),
      );
    case WelcomeScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const WelcomeScreen(),
      );
    case CoursesScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const CoursesScreen(),
      );
    case CoursesTestsScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const CoursesTestsScreen(),
      );
    case DebugScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const DebugScreen(),
      );
    case SectionsScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final int id = arguments['courseId'];
      return MaterialPageRoute(
        builder: (context) => SectionsScreen(id),
      );
    case SectionsTestsScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final int id = arguments['courseId'];
      return MaterialPageRoute(
        builder: (context) => SectionsTestsScreen(id),
      );
    case LessonsScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final int courseId = arguments['courseId'];
      final int sectionId = arguments['sectionId'];
      return MaterialPageRoute(
        builder: (context) => LessonsScreen(
          courseId: courseId,
          sectionId: sectionId,
        ),
      );
    case TestsScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final int courseId = arguments['courseId'];
      final int sectionId = arguments['sectionId'];
      return MaterialPageRoute(
        builder: (context) => TestsScreen(
          courseId: courseId,
          sectionId: sectionId,
        ),
      );
    case LessonScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final int courseId = arguments['courseId'];
      final int sectionId = arguments['sectionId'];
      final int lessonId = arguments['lessonId'];
      return MaterialPageRoute(
        builder: (context) => LessonScreen(
          courseId: courseId,
          sectionId: sectionId,
          lessonId: lessonId,
        ),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: ErrorScreen(errorMessage: 'Page does not exists'),
        ),
      );
  }
}
