// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:educode/model/lecture.dart';

class Section {
  final String _name;

  final List<Lecture> _lectures;

  Section(this._name, this._lectures);

  List<Lecture> get lectures => _lectures;

  String get name => _name;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_name': _name,
      '_lectures': _lectures.map((x) => x.toMap()).toList(),
    };
  }

  factory Section.fromMap(Map<String, dynamic> map) {
    return Section(
      map['_name'] as String,
      List<Lecture>.from(
        (map['_lectures']).map<Lecture>(
          (x) => Lecture.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Section.fromJson(String source) =>
      Section.fromMap(json.decode(source) as Map<String, dynamic>);
}
