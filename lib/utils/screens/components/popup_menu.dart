import 'package:educode/features/auth/controller/auth_controller.dart';
import 'package:educode/features/auth/screens/welcome_screen.dart';
import 'package:educode/features/education/screens/debug_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PopupMenu extends ConsumerWidget {
  const PopupMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton(
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            child: ListTile(
              minLeadingWidth: 0,
              title: const Text('Log out'),
              leading: const Icon(
                Icons.logout,
              ),
              onTap: () async {
                await ref.read(authControllerProvider).logOut(context).then(
                    (value) => Navigator.of(context).pushNamedAndRemoveUntil(
                        WelcomeScreen.routeName, (route) => false));
              },
            ),
          ),
          PopupMenuItem(
            child: ListTile(
              minLeadingWidth: 0,
              title: const Text('Debug'),
              leading: const Icon(
                Icons.bug_report,
              ),
              onTap: () async {
                Navigator.of(context).pushNamed(DebugScreen.routeName);
              },
            ),
          ),
        ];
      },
    );
  }
}
