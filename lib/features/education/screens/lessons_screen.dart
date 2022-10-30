// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:educode/features/education/components/popup_menu.dart';
import 'package:educode/features/education/models/lesson_model.dart';
import 'package:educode/features/education/repository/education_repository.dart';
import 'package:educode/features/education/screens/lesson_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:educode/features/education/components/drawer.dart';
import 'package:educode/features/education/repository/firebase_education_repository.dart';

class LessonsScreen extends ConsumerWidget {
  final int courseId;
  final int sectionId;

  const LessonsScreen(
      {required this.courseId, required this.sectionId, super.key});
  static const String routeName = '/lessons-screen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lessons'),
        actions: const [PopupMenu()],
      ),
      body: FutureBuilder<List<LessonModel>>(
        future: ref.read(educationRepositoryProvider).getLessons(
            context: context, courseId: courseId, sectionId: sectionId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var lesson = snapshot.data![index];
                return ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, LessonScreen.routeName,
                        arguments: {
                          'courseId': courseId,
                          'sectionId': sectionId,
                          'lessonId': lesson.id
                        });
                  },
                  title: Text(lesson.name),
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
