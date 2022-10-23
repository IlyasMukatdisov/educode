import 'package:educode/features/auth/controller/auth_controller.dart';
import 'package:educode/features/education/screens/edducation_screen.dart';
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

  bool showEmailLabel = false;
  bool showPasswordLabel = false;

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
        title: Text(
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
                                      EducationScreen.routeName,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
