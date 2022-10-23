import 'dart:io';

import 'package:educode/features/auth/screens/login_screen.dart';
import 'package:educode/features/auth/screens/register_screen.dart';
import 'package:educode/features/auth/screens/reset_password_screen.dart';
import 'package:educode/features/auth/screens/verify_email.dart';
import 'package:educode/features/auth/screens/welcome_screen.dart';
import 'package:educode/features/education/screens/edducation_screen.dart';
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
    case EducationScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const EducationScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: ErrorScreen(errorMessage: 'Page does not exists'),
        ),
      );
  }
}
