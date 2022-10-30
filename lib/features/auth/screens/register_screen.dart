import 'dart:async';
import 'dart:math';

import 'package:educode/features/auth/controller/auth_controller.dart';
import 'package:educode/features/auth/screens/verify_email.dart';
import 'package:educode/utils/constants.dart';
import 'package:educode/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  static const String routeName = '/register-screen';
  const RegisterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<RegisterScreen> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _confirmPassword;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Register',
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/logo_transparent.png'),
                  const SizedBox(
                    height: defaultPadding * 2,
                  ),
                  TextFormField(
                    autocorrect: false,
                    controller: _email,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                      labelText: 'Email',
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  TextFormField(
                    controller: _password,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.password),
                      labelText: 'Password',
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  TextFormField(
                    controller: _confirmPassword,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.password),
                      labelText: 'Confirm Password',
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding * 2,
                  ),
                  SizedBox(
                    width: size.width,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_password.text.trim() ==
                            _confirmPassword.text.trim()) {
                          await ref
                              .read(authControllerProvider)
                              .createUser(
                                  email: _email.text.trim(),
                                  password: _password.text.trim(),
                                  context: context)
                              .then(
                            (value) async {
                              await ref
                                  .read(authControllerProvider)
                                  .sendEmailVerification(context)
                                  .then(
                                    (value) => Navigator.of(context)
                                        .pushNamed(VerifyEmailScreen.routeName),
                                  );
                            },
                          );
                        } else {
                          showSnackBar(
                              context: context, text: "Passwords don't match");
                        }
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
