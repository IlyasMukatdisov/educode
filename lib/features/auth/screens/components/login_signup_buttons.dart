import 'package:educode/features/auth/bloc/auth_bloc.dart';
import 'package:educode/features/auth/bloc/auth_event.dart';
import 'package:educode/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginAndSignUpButtons extends StatelessWidget {
  const LoginAndSignUpButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            context.read<AuthBloc>().add(const AuthEventWelcomeLogin());
          },
          style:
              ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
          child: Text(
            "Login".toUpperCase(),
          ),
        ),
        const SizedBox(height: defaultPadding * 2),
        ElevatedButton(
          onPressed: () {
            context.read<AuthBloc>().add(const AuthEventWelcomeRegister());
          },
          style:
              ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
          child: Text(
            "Sign Up".toUpperCase(),
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
