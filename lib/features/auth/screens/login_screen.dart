import 'package:educode/features/auth/controller/auth_controller.dart';
import 'package:educode/features/auth/screens/register_screen.dart';
import 'package:educode/features/auth/screens/reset_password_screen.dart';
import 'package:educode/features/education/screens/courses_screen.dart';
import 'package:educode/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const String routeName = '/login-screen';

  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
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
                    height: defaultPadding * 2,
                  ),
                  SizedBox(
                    width: size.width,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () async {
                        await ref
                            .read(authControllerProvider)
                            .signInWithEmailAndPassword(
                                email: _email.text.trim(),
                                password: _password.text.trim(),
                                context: context)
                            .then(
                              (value) => Navigator.of(context)
                                  .pushNamedAndRemoveUntil(
                                      CoursesScreen.routeName,
                                      (route) => false),
                            );
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  SizedBox(
                    width: size.width,
                    height: 45,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, ResetPasswordScreen.routeName);
                      },
                      child: const Text(
                        'Forget password? Restore it here',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width,
                    height: 45,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RegisterScreen.routeName);
                      },
                      child: const Text(
                        "Don't have an account? Create in here",
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
