import 'package:educode/features/courses/components/bottom_option.dart';
import 'package:educode/features/courses/components/shopping_cart_option.dart';
import 'package:educode/utils/constants.dart';
import 'package:educode/features/my_courses/provider/my_course_data_provider.dart';
import 'package:educode/model/my_course.dart';
import 'package:flutter/material.dart';

class MyCoursesScreen extends StatelessWidget {
  const MyCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<MyCourse> myCourses = MyCourseDataProvider.myCourses;

    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: const ShoppingCartOption(),
        bottomNavigationBar: const BottomOption(selectedIndex: 2),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const Text(
                'My Courses',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 30,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade900)),
                      child: const Text("All courses",
                          style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade900)),
                      child: const Text("Downloaded courses"),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade900)),
                      child: const Text("Archived courses"),
                    ),

                    // Course list
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: myCourses.length,
                  itemBuilder: (context, index) {
                    MyCourse course = myCourses[index];
                    return getMyCourse(course, context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getMyCourse(MyCourse myCourse, BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.asset(
          myCourse.course.thumbnailUrl,
        ),
        title: Text(
          myCourse.course.title,
          maxLines: 2,
          style: TextStyle(fontSize: 17, color: Colors.grey.shade800),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              myCourse.course.createdBy,
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(
              height: 8,
            ),
            Visibility(
              visible: myCourse.progress > 0,
              replacement: const Text(
                'Start course',
                style: TextStyle(
                    color: kPrimaryColor, fontWeight: FontWeight.w600),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 3,
                        thumbColor: Colors.transparent,
                        overlayShape: SliderComponentShape.noThumb,
                        thumbShape: SliderComponentShape.noThumb,
                      ),
                      child: Slider(
                        min: 0,
                        max: 100,
                        value: myCourse.progress.toDouble(),
                        onChanged: (value) {},
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text('${myCourse.progress}%')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
