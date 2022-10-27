import 'package:educode/features/auth/controller/auth_controller.dart';
import 'package:educode/features/auth/screens/welcome_screen.dart';
import 'package:educode/features/education/components/drawer.dart';
import 'package:educode/features/education/models/section_model.dart';
import 'package:educode/features/education/repository/education_repository.dart';
import 'package:educode/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SectionsScreen extends ConsumerWidget {
  final int courseId;
  static const String routeName = '/sections-screen';
  const SectionsScreen(this.courseId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses'),
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
      body: FutureBuilder<List<SectionModel>>(
        future:
            ref.read(educationRepositoryProvider).getSections(context: context, courseId: courseId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            return Container(
              padding: const EdgeInsets.only(top: defaultPadding),
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var section = snapshot.data![index];
                  return ListTile(
                    title: Text(section.name),
                    subtitle: Text(section.description),
                  );
                },
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      drawer: const Drawer(child: DrawerContent()),
    );
  }
}
