import 'package:educode/features/auth/controller/auth_controller.dart';
import 'package:educode/features/auth/screens/welcome_screen.dart';
import 'package:educode/features/education/components/drawer.dart';
import 'package:educode/features/education/models/course_model.dart';
import 'package:educode/features/education/repository/education_repository.dart';
import 'package:educode/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoursesScreen extends ConsumerWidget {
  static const String routeName = '/courses-screen';
  const CoursesScreen({super.key});

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
      body: FutureBuilder<List<CourseModel>>(
        future:
            ref.read(educationRepositoryProvider).getCourses(context: context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            return Container(
              padding: EdgeInsets.only(top: defaultPadding),
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var course = snapshot.data![index];
                  return ListTile(
                    title: Text(course.name),
                    subtitle: Text(course.description),
                    trailing: Text(course.numberOfSections.toString()),
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
      floatingActionButton: ElevatedButton(
        onPressed: () {
          List<CourseModel> courses = [
            CourseModel(
                id: 1,
                name: 'Dart',
                numberOfSections: 2,
                description:
                    'Learn an effective object-oriented language used for building flutter apps'),
          ];
          ref
              .read(educationRepositoryProvider)
              .setCourses(courses: courses, context: context);
        },
        child: Text('Push courses to firebase'),
      ),
    );
  }
}
