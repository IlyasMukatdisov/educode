import 'package:cached_network_image/cached_network_image.dart';
import 'package:educode/features/education/components/drawer.dart';
import 'package:educode/features/education/components/popup_menu.dart';
import 'package:educode/features/education/models/course_model.dart';
import 'package:educode/features/education/repository/education_repository.dart';
import 'package:educode/features/education/screens/sections_screen.dart';
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
        actions: const [PopupMenu()],
      ),
      body: FutureBuilder<List<CourseModel>>(
        future:
            ref.read(educationRepositoryProvider).getCourses(context: context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var course = snapshot.data![index];
                return ListTile(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(SectionsScreen.routeName, arguments: {
                      'courseId': course.id,
                    });
                  },
                  title: Text(course.name),
                  subtitle: Text(course.description),
                  style: ListTileStyle.list,
                  leading: CachedNetworkImage(
                    imageUrl: course.imagePath,
                    height: 40,
                    width: 40,
                  ),
                );
              },
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
