import 'package:educode/features/auth/bloc/auth_bloc.dart';
import 'package:educode/features/auth/bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<AuthBloc>().add(const AuthEventBackToWelcome());
        return false;
      },
      child: const Center(
        child: Text('Register'),
      ),
    );
  }
}
