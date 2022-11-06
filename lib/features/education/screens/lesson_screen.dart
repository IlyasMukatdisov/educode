import 'package:educode/features/education/repository/education_repository.dart';
import 'package:flutter_highlight/flutter_highlight.dart';

import 'package:educode/utils/screens/components/popup_menu.dart';
import 'package:educode/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:educode/utils/screens/components/drawer.dart';
import 'package:educode/features/education/models/lesson_model.dart';

class LessonScreen extends ConsumerWidget {
  final int courseId;
  final int sectionId;
  final int lessonId;
  const LessonScreen({
    required this.courseId,
    required this.sectionId,
    required this.lessonId,
    super.key,
  });

  static const String routeName = '/lesson-screen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lesson $lessonId'),
        actions: const [PopupMenu()],
      ),
      body: FutureBuilder<LessonModel>(
        future: ref.read(educationRepositoryProvider).getLesson(
            context: context,
            courseId: courseId,
            sectionId: sectionId,
            lessonId: lessonId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null &&
              snapshot.data!.id != 0) {
            final lesson = snapshot.data!;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lesson.name,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      lesson.text,
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    SizedBox(
                      height: lesson.codeExample.isNotEmpty ? 10 : 0,
                    ),
                    HighlightView(
                      lesson.codeExample,
                      language: lesson.codeLanguage,
                      theme: atomOneDarkTheme,
                    )
                  ],
                ),
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
