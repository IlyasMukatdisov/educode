import 'package:educode/features/auth/bloc/auth_event.dart';
import 'package:educode/features/auth/bloc/auth_state.dart';
import 'package:educode/features/auth/screens/login_screen.dart';
import 'package:educode/features/auth/screens/register_screen.dart';
import 'package:educode/features/auth/screens/reset_password_screen.dart';
import 'package:educode/features/auth/screens/verify_email.dart';
import 'package:educode/features/auth/screens/welcome_screen.dart';
import 'package:educode/features/education/screens/edu_screen.dart';
import 'package:educode/generated/l10n.dart';
import 'package:educode/utils/overlays/loading/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/auth/bloc/auth_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isLoading) {
          LoadingScreen().show(
            context: context,
            text: state.loadingText ?? AppLocalizations.current.wait_moment,
          );
        } else {
          LoadingScreen().hide();
        }
      },
      builder: (context, state) {
        if (state is AuthStateWelcome) {
          return const WelcomeScreen();
        }
        if (state is AuthStateLoggedIn) {
          return const EducationScreen();
        }
        if (state is AuthStateNeedsVerification) {
          return const VerifyEmailScreen();
        }
        if (state is AuthStateLoggedOut) {
          return const LoginScreen();
        }
        if (state is AuthStateRegistering) {
          return const RegisterScreen();
        }
        if (state is AuthStateForgotPassword) {
          return const ResetPasswordScreen();
        }
        return Container(
          color: Colors.red,
        );
      },
    );
  }
}
