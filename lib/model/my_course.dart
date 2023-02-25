// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:educode/model/course.dart';

class MyCourse {
  final Course _course;
  int _progress = 0;

  set progress(int value) => _progress = value;

  Course get course => _course;

  // ignore: unnecessary_getters_setters
  int get progress => _progress;

  MyCourse(
    this._course,
  );
}
