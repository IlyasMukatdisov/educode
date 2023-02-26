import 'package:educode/features/courses/repository/courses_repository.dart';
import 'package:educode/model/course.dart';
import 'package:educode/model/course_category.dart';
import 'package:educode/features/courses/provider/notifiers/course_category_change_notifier.dart';
import 'package:educode/features/courses/screens/home/widget/course_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CoursesList extends ConsumerWidget {
  const CoursesList({super.key});

  Future<List<Course>> getCoursesList(
      BuildContext context, WidgetRef ref) async {
    var category = ref.read(courseCategoryChangeNotifierProvider).category;

    var allCourses = await ref
        .read(firebaseCourseRepositoryProvider)
        .getCourses(context: context);

    if (category == CourseCategory.all) {
      return allCourses;
    }

    return allCourses
        .where((course) => course.courseCategory == category)
        .toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: getCoursesList(context, ref),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            {
              if (snapshot.hasData) {
                List<Course> courseList = snapshot.data!;
                return StaggeredGrid.count(
                  crossAxisCount: 2,
                  children: courseList.map((course) {
                    return CourseItem(course: course);
                  }).toList(),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }

          default:
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }
}
