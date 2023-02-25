import 'package:educode/features/courses/screens/home/widget/category_list.dart';
import 'package:educode/features/courses/screens/home/widget/courses_list.dart';
import 'package:flutter/cupertino.dart';

class CategoryCourseList extends StatelessWidget {
  const CategoryCourseList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        CategoryList(),
        CoursesList(),
      ],
    );
  }
}
