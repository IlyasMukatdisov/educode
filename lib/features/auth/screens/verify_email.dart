import 'package:educode/features/auth/controller/auth_controller.dart';
import 'package:educode/features/auth/screens/login_screen.dart';
import 'package:educode/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerifyEmailScreen extends ConsumerWidget {
  static const String routeName = '/verify-email';
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Verify Email'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Center(
              child: Column(
                children: [
                  const Text(
                    'We have sent you an email verification to your account. Please open it and follow the link in email in order to activate your account\n \n'
                    "If you didn't receive an email please check your spam folder and then if you can't find it please tap the button below",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        await ref
                            .read(authControllerProvider)
                            .sendEmailVerification(context);
                      },
                      child: const Text(
                        'Send again',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(LoginScreen.routeName);
                      },
                      child: const Text(
                        'Already verified? Log in here',
                        style: TextStyle(fontSize: 16),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
