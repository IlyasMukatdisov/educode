import 'package:educode/features/courses/components/bottom_option.dart';
import 'package:educode/features/courses/components/shopping_cart_option.dart';

import 'package:educode/features/courses/screens/home/widget/category_course_list.dart';
import 'package:educode/features/courses/screens/home/widget/courses_header.dart';
import 'package:educode/features/courses/screens/home/widget/courses_search.dart';
import 'package:educode/features/courses/screens/home/widget/featured_courses.dart';
import 'package:educode/features/courses/screens/home/widget/offers.dart';
import 'package:educode/utils/constants.dart';
import 'package:flutter/material.dart';

class CoursesHomeScreen extends StatelessWidget {
  const CoursesHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const BottomOption(selectedIndex: 1),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: const ShoppingCartOption(),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: const [
                      CoursesHeader(),
                      SizedBox(
                        height: 20,
                      ),
                      CoursesSearch(),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    children: [
                      const Offers(),
                      FeaturedCourses(),
                      const CategoryCourseList()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
