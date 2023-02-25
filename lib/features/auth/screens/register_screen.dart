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

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Register',
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Image.asset(
                    'assets/images/logo/logo_transparent.png',
                    height: size.height * 0.25,
                  ),
                  const SizedBox(
                    height: defaultPadding * 2,
                  ),
                  TextFormField(
                    cursorColor: kPrimaryColor,
                    autocorrect: false,
                    controller: _email,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder().copyWith(
                          borderSide: const BorderSide(color: kPrimaryColor)),
                      prefixIcon: const Icon(Icons.email),
                      labelText: 'Email',
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  TextFormField(
                    cursorColor: kPrimaryColor,
                    controller: _password,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder().copyWith(
                          borderSide: const BorderSide(color: kPrimaryColor)),
                      prefixIcon: const Icon(Icons.password),
                      labelText: 'Password',
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  TextFormField(
                    cursorColor: kPrimaryColor,
                    controller: _confirmPassword,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder().copyWith(
                          borderSide: const BorderSide(color: kPrimaryColor)),
                      prefixIcon: const Icon(Icons.password),
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
                              value == 0
                                  ? await ref
                                      .read(authControllerProvider)
                                      .sendEmailVerification(context)
                                      .then(
                                        (value) => value == 0
                                            ? Navigator.of(context).pushNamed(
                                                VerifyEmailScreen.routeName)
                                            : null,
                                      )
                                  : null;
                            },
                          );
                        } else {
                          Utils.showMessage(
                              context: context,
                              message: "Passwords don't match");
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
