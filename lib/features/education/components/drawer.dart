// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:educode/features/auth/controller/auth_controller.dart';
import 'package:educode/features/education/screens/courses_screen.dart';
import 'package:educode/utils/constants.dart';

class DrawerContent extends ConsumerWidget {
  const DrawerContent({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photoUrl = ref.read(authControllerProvider).currentUser!.photoURL;
    final email = ref.read(authControllerProvider).currentUser!.email;

    return ListView(
      children: [
        Container(
          decoration: const BoxDecoration(color: Colors.orange),
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 42,
                child: photoUrl != null
                    ? Image.network(photoUrl)
                    : Text(
                        email!.substring(0, 1).toUpperCase(),
                        style: const TextStyle(fontSize: 30),
                      ),
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              Text(email!)
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: const Text('Lessons'),
              leading: const Icon(Icons.book),
              onTap: () {
                Navigator.pushReplacementNamed(
                    context, CoursesScreen.routeName);
              },
            ),
            ListTile(
              title: const Text('Tests'),
              leading: const Icon(Icons.timer),
              onTap: () {
                Navigator.pushReplacementNamed(
                    context, CoursesScreen.routeName);
              },
            ),
          ],
        )
      ],
    );
  }
}
