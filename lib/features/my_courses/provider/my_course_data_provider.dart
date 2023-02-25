import 'package:educode/model/course.dart';
import 'package:educode/model/my_course.dart';

class MyCourseDataProvider {
  static final List<MyCourse> _myCourses = [];

  static get myCourses => _myCourses;

  static void addCourse(Course course) {
    _myCourses.add(MyCourse(course));
  }

  static void addAllCourses(List<Course> courses) {
    for (var course in courses) {
      _myCourses.add(
        MyCourse(course),
      );
    }
  }
}
