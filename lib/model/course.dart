// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:educode/model/course_category.dart';
import 'package:educode/model/section.dart';

class Course {
  final String _id;

  final String _title;

  final String _thumbnailUrl;

  final String _description;

  final String _createdBy;

  final String _createdDate;

  final double _rate;

  bool _isFavorite;

  final double _price;

  final CourseCategory _courseCategory;

  final String _duration;

  final int _lessonNo;

  final List<Section> _sections;

  Course(
      this._id,
      this._title,
      this._thumbnailUrl,
      this._description,
      this._createdBy,
      this._createdDate,
      this._rate,
      this._isFavorite,
      this._courseCategory,
      this._price,
      this._duration,
      this._lessonNo,
      this._sections);

  // ignore: unnecessary_getters_setters
  bool get isFavorite => _isFavorite;

  set isFavorite(bool value) {
    _isFavorite = value;
  }

  double get rate => _rate;

  String get createdDate => _createdDate;

  String get createdBy => _createdBy;

  String get description => _description;

  String get thumbnailUrl => _thumbnailUrl;

  String get title => _title;

  String get id => _id;

  CourseCategory get courseCategory => _courseCategory;

  double get price => _price;

  String get duration => _duration;

  int get lessonNo => _lessonNo;

  List<Section> get sections => _sections;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': _id,
      '_title': _title,
      '_thumbnailUrl': _thumbnailUrl,
      '_description': _description,
      '_createdBy': _createdBy,
      '_createdDate': _createdDate,
      '_rate': _rate,
      '_isFavorite': _isFavorite,
      '_price': _price,
      '_courseCategory': _courseCategory.index,
      '_duration': _duration,
      '_lessonNo': _lessonNo,
      '_sections': _sections.map((x) => x.toMap()).toList(),
    };
  }

  factory Course.fromMap(Map<String, dynamic> map) {
    int index = map['_courseCategory'];

    var priceVar = map['_price'];
    double price;
    if (priceVar.runtimeType == int) {
      price = priceVar.toDouble();
    } else {
      price = priceVar;
    }

    var rateVar = map['_rate'];
    double rate;
    if (rateVar.runtimeType == int) {
      rate = rateVar.toDouble();
    } else {
      rate = rateVar;
    }

    return Course(
      map['_id'] as String,
      map['_title'] as String,
      map['_thumbnailUrl'] as String,
      map['_description'] as String,
      map['_createdBy'] as String,
      map['_createdDate'] as String,
      rate,
      map['_isFavorite'] as bool,
      CourseCategory.values[index],
      price,
      map['_duration'] as String,
      map['_lessonNo'] as int,
      List<Section>.from(
        (map['_sections']).map<Section>(
          (x) => Section.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Course.fromJson(String source) =>
      Course.fromMap(json.decode(source) as Map<String, dynamic>);
}
