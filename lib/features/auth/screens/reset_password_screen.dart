import 'package:educode/features/auth/controller/auth_controller.dart';
import 'package:educode/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  static const String routeName = '/reset-password-screen';
  const ResetPasswordScreen({super.key});

  @override
  ConsumerState<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  late final TextEditingController _email;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
  }

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Restore password',
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ignore: prefer_const_constructors
                  Text(
                    'Enter your email address linked with your account in order to send a restoring password email',
                    textAlign: TextAlign.justify,
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
                    height: defaultPadding * 2,
                  ),
                  SizedBox(
                    width: size.width,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_email.text.length > 2 &&
                            _email.text.contains('@')) {
                          ref.read(authControllerProvider).sendPasswordReset(
                              toEmail: _email.text.trim(), context: context);
                        }
                      },
                      child: const Text(
                        'Restore password',
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
