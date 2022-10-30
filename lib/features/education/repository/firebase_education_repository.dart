// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educode/features/education/models/course_model.dart';
import 'package:educode/features/education/models/lesson_model.dart';
import 'package:educode/features/education/models/section_model.dart';
import 'package:educode/utils/constants.dart';
import 'package:educode/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseEducationRepositoryProvider = Provider(
  (ref) => FirebaseEducationRepository(firestore: FirebaseFirestore.instance),
);

class FirebaseEducationRepository {
  final FirebaseFirestore firestore;

  FirebaseEducationRepository({
    required this.firestore,
  });

  void setCourses({
    required List<CourseModel> courses,
    required BuildContext context,
  }) async {
    try {
      for (var course in courses) {
        await firestore
            .collection(coursesCollection)
            .doc(course.id.toString())
            .set(course.toMap());
      }
    } catch (e) {
      showSnackBar(context: context, text: e.toString());
    }
  }

  Future<List<CourseModel>> getCourses({required BuildContext context}) async {
    List<CourseModel> courses = [];
    try {
      var snapshot = await firestore.collection(coursesCollection).get();
      for (var doc in snapshot.docs) {
        final course = CourseModel.fromMap(doc.data());
        courses.add(course);
      }
    } catch (e) {
      showSnackBar(context: context, text: e.toString());
    }
    return courses;
  }

  Future<List<SectionModel>> getSections({
    required BuildContext context,
    required int courseId,
  }) async {
    List<SectionModel> sections = [];
    try {
      var snapshot = await firestore
          .collection(coursesCollection)
          .doc(courseId.toString())
          .collection(sectionsCollection)
          .get();
      for (var doc in snapshot.docs) {
        final section = SectionModel.fromMap(doc.data());
        sections.add(section);
      }
    } catch (e) {
      showSnackBar(context: context, text: e.toString());
    }
    return sections;
  }

  Future<List<SectionModel>> getAllSections({
    required BuildContext context,
  }) async {
    List<SectionModel> sections = [];
    try {
      var snapshot = await firestore.collectionGroup(sectionsCollection).get();

      for (var doc in snapshot.docs) {
        final section = SectionModel.fromMap(doc.data());
        sections.add(section);
      }
    } catch (e) {
      showSnackBar(context: context, text: e.toString());
    }
    return sections;
  }

  Future<List<LessonModel>> getLessons({
    required BuildContext context,
    required int courseId,
    required int sectionId,
  }) async {
    List<LessonModel> lessons = [];
    try {
      var snapshot = await firestore
          .collection(coursesCollection)
          .doc(courseId.toString())
          .collection(sectionsCollection)
          .doc(sectionId.toString())
          .collection(lessonsCollection)
          .orderBy(
            'id',
          )
          .get();
      for (var doc in snapshot.docs) {
        final section = LessonModel.fromMap(doc.data());
        lessons.add(section);
      }
    } catch (e) {
      showSnackBar(context: context, text: e.toString());
    }
    return lessons;
  }

  Future<List<LessonModel>> getAllLessons({
    required BuildContext context,
  }) async {
    List<LessonModel> lessons = [];
    try {
      var snapshot = await firestore.collectionGroup(lessonsCollection).get();

      for (var doc in snapshot.docs) {
        final lesson = LessonModel.fromMap(doc.data());
        lessons.add(lesson);
      }
    } catch (e) {
      showSnackBar(context: context, text: e.toString());
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
    try {
      var snapshot = await firestore
          .collection(coursesCollection)
          .doc(courseId.toString())
          .collection(sectionsCollection)
          .doc(sectionId.toString())
          .collection(lessonsCollection)
          .doc(lessonId.toString())
          .get();

      lesson = LessonModel.fromMap(snapshot.data()!);
    } catch (e) {
      showSnackBar(context: context, text: e.toString());
    }
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
    try {
      await firestore
          .collection(coursesCollection)
          .doc(courseId.toString())
          .collection(sectionsCollection)
          .doc(sectionId.toString())
          .collection(lessonsCollection)
          .doc(lessonId.toString())
          .set(lesson.toMap());
    } catch (e) {
      showSnackBar(context: context, text: e.toString());
    }
  }

  Future<void> updateLesson({
    required BuildContext context,
    required int courseId,
    required int sectionId,
    required int lessonId,
    required String codeLanguage,
  }) async {
    try {
      await firestore
          .collection(coursesCollection)
          .doc(courseId.toString())
          .collection(sectionsCollection)
          .doc(sectionId.toString())
          .collection(lessonsCollection)
          .doc(lessonId.toString())
          .update({'codeLanguage': codeLanguage});
    } catch (e) {
      showSnackBar(context: context, text: e.toString());
    }
  }
}
