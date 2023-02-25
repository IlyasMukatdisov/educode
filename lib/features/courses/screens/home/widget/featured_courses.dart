import 'package:educode/features/courses/provider/course_data_provider.dart';
import 'package:educode/model/course.dart';
import 'package:educode/features/courses/screens/home/widget/course_item.dart';
import 'package:educode/utils/constants.dart';
import 'package:flutter/material.dart';

class FeaturedCourses extends StatelessWidget {
  FeaturedCourses({super.key});

  final List<Course> featuredCoursesList = CourseDataProvider.courseList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Featured courses',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              'See all',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: kPrimaryColor),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: featuredCoursesList.length,
            itemBuilder: (context, index) {
              Course course = featuredCoursesList[index];
              return CourseItem(course: course);
            },
          ),
        )
      ],
    );
  }
}
