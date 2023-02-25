import 'package:educode/model/course_category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final courseCategoryChangeNotifierProvider =
    ChangeNotifierProvider.autoDispose((ref) => CourseCategoryChangeNotifier());

class CourseCategoryChangeNotifier extends ChangeNotifier {
  CourseCategory _category = CourseCategory.all;
  CourseCategory get category => _category;

  void changeCategory(CourseCategory category) {
    _category = category;
    notifyListeners();
  }
}
