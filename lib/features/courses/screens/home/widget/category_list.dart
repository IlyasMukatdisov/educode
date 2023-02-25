import 'package:educode/model/course_category.dart';
import 'package:educode/features/courses/provider/notifiers/course_category_change_notifier.dart';
import 'package:educode/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryList extends ConsumerWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var category = ref.watch(courseCategoryChangeNotifierProvider).category;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Categories",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 55,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: CourseCategory.values.length,
            itemBuilder: (context, index) {
              CourseCategory courseCategory = CourseCategory.values[index];
              return InkWell(
                onTap: () {
                  ref
                      .read(courseCategoryChangeNotifierProvider)
                      .changeCategory(category);
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(right: 10),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: category == courseCategory
                            ? kPrimaryColor
                            : Colors.white,
                        border: Border.all(color: Colors.grey.shade900)),
                    child: Text(
                      courseCategory.title,
                      style: TextStyle(
                          color: category == courseCategory
                              ? Colors.white
                              : Colors.black),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
