import 'package:educode/features/education/models/course_model.dart';
import 'package:educode/features/education/models/lesson_model.dart';
import 'package:educode/features/education/models/section_model.dart';
import 'package:educode/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final localEducationRepositoryProvider = Provider(
  (ref) => LocalEducationRepository(),
);

class LocalEducationRepository {
  late Box coursesBox;
  late Box sectionsBox;
  late Box lessonsBox;

  static final LocalEducationRepository _singleton =
      LocalEducationRepository._internal();

  factory LocalEducationRepository() {
    return _singleton;
  }

  LocalEducationRepository._internal();

  Future<void> init() async {
    coursesBox = await Hive.openBox(coursesCollection);
    sectionsBox = await Hive.openBox(sectionsCollection);
    lessonsBox = await Hive.openBox(lessonsCollection);
  }

  Future<void> setCourses({
    required List<CourseModel> courses,
    required BuildContext context,
  }) async {
    try {
      await coursesBox.put(coursesCollection, courses);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<List<CourseModel>> getCourses({required BuildContext context}) async {
    List<CourseModel> courses = [];
    try {
      var tempCourses = coursesBox.get(coursesCollection)!;
      for (var temp in tempCourses) {
        courses.add(temp);
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return courses;
  }

  Future<void> setSections({
    required List<SectionModel> sections,
    required BuildContext context,
  }) async {
    try {
      await sectionsBox.put(sectionsCollection, sections);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<List<SectionModel>> getSections({
    required BuildContext context,
    required int courseId,
  }) async {
    List<SectionModel> sections = [];
    try {
      var tempSections = sectionsBox.get(sectionsCollection)!;
      for (var temp in tempSections) {
        sections.add(temp);
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return sections;
  }

  Future<void> setLessons({
    required List<LessonModel> lessons,
    required BuildContext context,
  }) async {
    try {
      await lessonsBox.put(lessonsCollection, lessons);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<List<LessonModel>> getLessons({
    required BuildContext context,
  }) async {
    List<LessonModel> lessons = [];
    try {
      var tempLessons = lessonsBox.get(lessonsCollection)!;
      for (var temp in tempLessons) {
        lessons.add(temp);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return lessons;
  }

  Future<LessonModel> getLesson(
      {required BuildContext context,
      required int courseId,
      required int sectionId,
      required int lessonId}) async {
    LessonModel lesson = LessonModel(
        id: 0,
        name: '0',
        text: '0',
        codeExample: '0',
        courseId: courseId,
        sectionId: sectionId,
        codeLanguage: '');

    return lesson;
  }

  Future<void> setLesson({
    required BuildContext context,
    required int courseId,
    required int sectionId,
    required int lessonId,
    required String name,
    required String text,
    required String codeExample,
    required String codeLanguage,
  }) async {
    LessonModel lesson = LessonModel(
        id: lessonId,
        name: name,
        text: text,
        codeExample: codeExample,
        courseId: courseId,
        sectionId: sectionId,
        codeLanguage: codeLanguage);
  }

  Future<void> updateLesson({
    required BuildContext context,
    required int courseId,
    required int sectionId,
    required int lessonId,
    required String codeLanguage,
  }) async {}
}
