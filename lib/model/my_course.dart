// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:educode/model/course.dart';

class MyCourse {
  final Course _course;
  int _progress = 0;

  set progress(int value) => _progress = value;

  Course get course => _course;

  // ignore: unnecessary_getters_setters
  int get progress => _progress;

  MyCourse(this._course, this._progress);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_course': _course.toMap(),
      '_progress': _progress,
    };
  }

  factory MyCourse.fromMap(Map<String, dynamic> map) {
    return MyCourse(
      Course.fromMap(map['_course'] as Map<String, dynamic>),
      map['_progress'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory MyCourse.fromJson(String source) =>
      MyCourse.fromMap(json.decode(source) as Map<String, dynamic>);
}
