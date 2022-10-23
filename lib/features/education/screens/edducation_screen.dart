import 'package:educode/features/auth/controller/auth_controller.dart';
import 'package:educode/features/auth/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EducationScreen extends ConsumerWidget {
  static const String routeName = '/education-screen';
  const EducationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EduCode'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: ListTile(
                    minLeadingWidth: 0,
                    title: const Text('Log out'),
                    leading: const Icon(
                      Icons.logout,
                      color: Colors.black,
                    ),
                    onTap: () async {
                      await ref
                          .read(authControllerProvider)
                          .logOut(context)
                          .then((value) => Navigator.of(context)
                              .pushNamedAndRemoveUntil(
                                  WelcomeScreen.routeName, (route) => false));
                    },
                  ),
                )
              ];
            },
          )
        ],
      ),
      body: const Center(
        child: Text('Education'),
      ),
    );
  }
}
