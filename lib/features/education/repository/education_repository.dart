import 'package:educode/features/education/models/course_model.dart';
import 'package:educode/features/education/models/lesson_model.dart';
import 'package:educode/features/education/models/section_model.dart';
import 'package:educode/features/education/repository/firebase_education_repository.dart';
import 'package:educode/features/education/repository/local_education_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final educationRepositoryProvider = Provider(
  (ref) => EducationRepository(ref),
);

class EducationRepository {
  final ProviderRef ref;

  EducationRepository(this.ref);

  void setCourses({
    required List<CourseModel> courses,
    required BuildContext context,
  }) async {}

  Future<List<CourseModel>> getCourses({required BuildContext context}) async {
    var local = await ref
        .read(localEducationRepositoryProvider)
        .getCourses(context: context);
    if (local.isNotEmpty) {
      return local;
    } else {
      var firebaseCourses = await ref
          .read(firebaseEducationRepositoryProvider)
          .getCourses(context: context);
      await ref
          .read(localEducationRepositoryProvider)
          .setCourses(context: context, courses: firebaseCourses);
      return firebaseCourses;
    }
  }

  Future<List<SectionModel>> getSections({
    required BuildContext context,
    required int courseId,
  }) async {
    var local = await ref
        .read(localEducationRepositoryProvider)
        .getSections(context: context, courseId: courseId);
    if (local.isNotEmpty) {
      local.removeWhere((element) => element.courseId != courseId);
      return local;
    } else {
      var firebaseSections =
          await ref.read(firebaseEducationRepositoryProvider).getAllSections(
                context: context,
              );
      await ref
          .read(localEducationRepositoryProvider)
          .setSections(context: context, sections: firebaseSections);
      firebaseSections.removeWhere((element) => element.courseId != courseId);
      return firebaseSections;
    }
  }

  Future<List<LessonModel>> getLessons({
    required BuildContext context,
    required int courseId,
    required int sectionId,
  }) async {
    var local = await ref.read(localEducationRepositoryProvider).getLessons(
          context: context,
        );
    if (local.isNotEmpty) {
      local.removeWhere((element) =>
          element.courseId != courseId || element.sectionId != sectionId);
      return local;
    } else {
      var firebaseLessons =
          await ref.read(firebaseEducationRepositoryProvider).getAllLessons(
                context: context,
              );
      await ref
          .read(localEducationRepositoryProvider)
          .setLessons(context: context, lessons: firebaseLessons);
      firebaseLessons.removeWhere((element) =>
          element.courseId != courseId || element.sectionId != sectionId);
      return firebaseLessons;
    }
  }

  Future<LessonModel> getLesson(
      {required BuildContext context,
      required int courseId,
      required int sectionId,
      required int lessonId}) async {
    final lessons = await getLessons(
        context: context, courseId: courseId, sectionId: sectionId);
    return lessons.firstWhere((element) =>
        element.id == lessonId &&
        element.courseId == courseId &&
        element.sectionId == sectionId);
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
