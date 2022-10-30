import 'package:educode/features/education/components/drawer.dart';
import 'package:educode/features/education/components/popup_menu.dart';
import 'package:educode/features/education/models/section_model.dart';
import 'package:educode/features/education/repository/education_repository.dart';
import 'package:educode/features/education/screens/lessons_screen.dart';
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
        actions: const [PopupMenu()],
      ),
      body: FutureBuilder<List<SectionModel>>(
        future: ref
            .read(educationRepositoryProvider)
            .getSections(context: context, courseId: courseId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var section = snapshot.data![index];
                return ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, LessonsScreen.routeName,
                        arguments: {
                          'courseId': courseId,
                          'sectionId': section.id
                        });
                  },
                  title: Text(section.name),
                  subtitle: Text(section.description),
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
