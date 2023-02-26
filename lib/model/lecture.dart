// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Lecture {
  final String _name;

  final String _duration;

  Lecture(this._name, this._duration);

  String get duration => _duration;

  String get name => _name;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_name': _name,
      '_duration': _duration,
    };
  }

  factory Lecture.fromMap(Map<String, dynamic> map) {
    return Lecture(
      map['_name'] as String,
      map['_duration'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Lecture.fromJson(String source) => Lecture.fromMap(json.decode(source) as Map<String, dynamic>);
}
