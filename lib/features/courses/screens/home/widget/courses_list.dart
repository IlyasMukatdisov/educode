import 'package:educode/features/courses/provider/course_data_provider.dart';
import 'package:educode/model/course.dart';
import 'package:educode/model/course_category.dart';
import 'package:educode/features/courses/provider/notifiers/course_category_change_notifier.dart';
import 'package:educode/features/courses/screens/home/widget/course_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CoursesList extends ConsumerWidget {
  const CoursesList({super.key});

  List<Course> getCoursesList(BuildContext context, WidgetRef ref) {
    var category = ref.read(courseCategoryChangeNotifierProvider).category;

    if (category == CourseCategory.all) return CourseDataProvider.courseList;

    return CourseDataProvider.courseList
        .where((course) => course.courseCategory == category)
        .toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StaggeredGrid.count(
      crossAxisCount: 2,
      children: getCoursesList(context, ref).map((course) {
        return CourseItem(course: course);
      }).toList(),
    );
  }
}
