import 'package:educode/features/courses/repository/courses_repository.dart';
import 'package:educode/model/course.dart';
import 'package:educode/features/courses/screens/home/widget/course_item.dart';
import 'package:educode/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FeaturedCourses extends ConsumerWidget {
  const FeaturedCourses({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: ref
          .read(firebaseCourseRepositoryProvider)
          .getCourses(context: context),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            if (snapshot.hasData) {
              List<Course> allCourses = snapshot.data!;
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
                      itemCount: allCourses.length,
                      itemBuilder: (context, index) {
                        Course course = allCourses[index];
                        return CourseItem(course: course);
                      },
                    ),
                  )
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
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
