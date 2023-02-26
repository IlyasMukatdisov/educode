import 'package:cached_network_image/cached_network_image.dart';
import 'package:educode/features/wishlist/repository/wishlist_repository.dart';
import 'package:educode/model/course.dart';
import 'package:educode/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WishList extends ConsumerStatefulWidget {
  const WishList({super.key});

  @override
  ConsumerState<WishList> createState() => _WishListState();
}

class _WishListState extends ConsumerState<WishList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCourseList(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            var courseList = snapshot.data!;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: courseList.length,
              itemBuilder: (context, index) {
                Course course = courseList[index];
                return getListItem(course);
              },
            );
          }
          return Container();
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Future<List<Course>> getCourseList(BuildContext context) async {
    return ref.read(wishlistRepositoryProvider).getCourses(context: context);
  }

  Widget getListItem(Course course) {
    return Card(
      child: ListTile(
        leading: CachedNetworkImage(imageUrl: course.thumbnailUrl),
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
                      ref
                          .read(wishlistRepositoryProvider)
                          .deleteCourse(course: course, context: context);
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
