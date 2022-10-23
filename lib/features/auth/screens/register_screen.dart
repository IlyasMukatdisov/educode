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

  bool showEmailLabel = false;
  bool showPasswordLabel = false;
  bool showConfirmPasswordLabel = false;

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
        title: Text(
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
                  Image.asset('assets/logo.png'),
                  const SizedBox(
                    height: defaultPadding * 2,
                  ),
                  TextFormField(
                    autocorrect: false,
                    onChanged: (value) {
                      setState(() {
                        showEmailLabel = value.isNotEmpty ? true : false;
                      });
                    },
                    controller: _email,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.email),
                      labelText: showEmailLabel ? 'Email' : null,
                      hintText: 'Email',
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        showPasswordLabel = value.isNotEmpty ? true : false;
                      });
                    },
                    controller: _password,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.password),
                      labelText: showPasswordLabel ? 'Password' : null,
                      hintText: 'Password',
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        showConfirmPasswordLabel =
                            value.isNotEmpty ? true : false;
                      });
                    },
                    controller: _confirmPassword,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.password),
                      labelText:
                          showConfirmPasswordLabel ? 'Confirm Password' : null,
                      hintText: 'Confirm Password',
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
