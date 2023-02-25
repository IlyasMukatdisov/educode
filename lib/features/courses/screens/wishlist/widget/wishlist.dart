import 'package:educode/features/courses/provider/course_data_provider.dart';
import 'package:educode/model/course.dart';
import 'package:educode/utils/constants.dart';
import 'package:flutter/material.dart';

class WishList extends StatefulWidget {
  const WishList({super.key});

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  @override
  Widget build(BuildContext context) {
    List<Course> courseList = getCourseList(context);
    return ListView.builder(
      shrinkWrap: true,
      itemCount: courseList.length,
      itemBuilder: (context, index) {
        Course course = courseList[index];
        return getListItem(course);
      },
    );
  }

  List<Course> getCourseList(BuildContext context) {
    return CourseDataProvider.courseList
        .where((course) => course.isFavorite)
        .toList();
  }

  Widget getListItem(Course course) {
    return Card(
      child: ListTile(
        leading: Image.asset(course.thumbnailUrl),
        title: Text(
          course.title,
          maxLines: 2,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'By ${course.createdBy}',
              style: const TextStyle(color: kPrimaryColor, fontSize: 15),
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  course.duration,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                const SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  radius: 3,
                  backgroundColor: Colors.grey.shade400,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  '${course.lessonNo} Lessons',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                const SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  radius: 3,
                  backgroundColor: Colors.grey.shade400,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(
                  size: 16,
                  Icons.star,
                  color: kRatingColor,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  course.rate.toString(),
                  style: TextStyle(color: Colors.grey.shade600),
                )
              ],
            ),
            Wrap(
              children: [
                Text(
                  '${course.price}\$',
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade800),
                ),
                const SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      course.isFavorite = false;
                    });
                  },
                  child: const Icon(Icons.delete),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
