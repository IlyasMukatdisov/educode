import 'package:educode/features/education/models/course_model.dart';
import 'package:educode/features/education/repository/firebase_education_repository.dart';
import 'package:educode/features/education/repository/local_education_repository.dart';
import 'package:educode/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DebugScreen extends ConsumerStatefulWidget {
  static const String routeName = '/debug-screen';

  const DebugScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DebugScreenState();
}

class _DebugScreenState extends ConsumerState<DebugScreen> {
  late final TextEditingController _course;
  late final TextEditingController _section;
  late final TextEditingController _lesson;
  late final TextEditingController _name;
  late final TextEditingController _text;
  late final TextEditingController _code;
  late final TextEditingController _codeLanguage;

  List<CourseModel>? courses;

  @override
  void initState() {
    super.initState();
    _course = TextEditingController();
    _section = TextEditingController();
    _lesson = TextEditingController();
    _name = TextEditingController();
    _text = TextEditingController();
    _code = TextEditingController();
    _codeLanguage = TextEditingController();
  }

  @override
  void dispose() {
    _course.dispose();
    _section.dispose();
    _lesson.dispose();
    _name.dispose();
    _text.dispose();
    _code.dispose();
    _codeLanguage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<CourseModel>>(
          future: ref
              .read(firebaseEducationRepositoryProvider)
              .getCourses(context: context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.data != null) {
              return SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(courses.toString()),
                    ElevatedButton(
                        onPressed: () {
                          LocalEducationRepository().setCourses(
                              courses: snapshot.data!, context: context);
                        },
                        child: Text('set')),
                    ElevatedButton(
                        onPressed: () async {
                          courses = await LocalEducationRepository()
                              .getCourses(context: context);
                          setState(() {});
                        },
                        child: Text('get')),
                  ],
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );

    //   return Scaffold(
    //     body: Center(
    //       child: SingleChildScrollView(
    //         child: Padding(
    //           padding: const EdgeInsets.all(defaultPadding),
    //           child: Column(
    //             mainAxisSize: MainAxisSize.min,
    //             children: [
    //               Row(
    //                 children: [
    //                   Expanded(
    //                     child: TextField(
    //                       controller: _course,
    //                       decoration: const InputDecoration(
    //                         border: OutlineInputBorder(),
    //                         labelText: 'course',
    //                       ),
    //                       maxLines: 1,
    //                       keyboardType: TextInputType.number,
    //                     ),
    //                   ),
    //                   const SizedBox(
    //                     width: 10,
    //                   ),
    //                   Expanded(
    //                     child: TextField(
    //                       controller: _section,
    //                       decoration: const InputDecoration(
    //                         border: OutlineInputBorder(),
    //                         labelText: 'section',
    //                       ),
    //                       maxLines: 1,
    //                       keyboardType: TextInputType.number,
    //                     ),
    //                   ),
    //                   const SizedBox(
    //                     width: 10,
    //                   ),
    //                   Expanded(
    //                     child: TextField(
    //                       controller: _lesson,
    //                       decoration: const InputDecoration(
    //                         border: OutlineInputBorder(),
    //                         labelText: 'lesson',
    //                       ),
    //                       maxLines: 1,
    //                       keyboardType: TextInputType.number,
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //               const SizedBox(
    //                 height: 10,
    //               ),
    //               TextField(
    //                 controller: _name,
    //                 decoration: const InputDecoration(
    //                   border: OutlineInputBorder(),
    //                   labelText: 'name',
    //                 ),
    //                 maxLines: null,
    //                 keyboardType: TextInputType.multiline,
    //               ),
    //               const SizedBox(
    //                 height: 10,
    //               ),
    //               TextField(
    //                 controller: _text,
    //                 decoration: const InputDecoration(
    //                   border: OutlineInputBorder(),
    //                   labelText: 'text',
    //                 ),
    //                 maxLines: null,
    //                 keyboardType: TextInputType.multiline,
    //               ),
    //               const SizedBox(
    //                 height: 10,
    //               ),
    //               TextField(
    //                 controller: _code,
    //                 decoration: const InputDecoration(
    //                   border: OutlineInputBorder(),
    //                   labelText: 'code',
    //                 ),
    //                 maxLines: null,
    //                 keyboardType: TextInputType.multiline,
    //               ),
    //               const SizedBox(
    //                 height: 10,
    //               ),
    //               TextField(
    //                 controller: _codeLanguage,
    //                 decoration: const InputDecoration(
    //                   border: OutlineInputBorder(),
    //                   labelText: 'code language',
    //                 ),
    //                 maxLines: null,
    //                 keyboardType: TextInputType.multiline,
    //               ),
    //               const SizedBox(
    //                 height: 10,
    //               ),
    //               // ElevatedButton(
    //               //   onPressed: () {
    //               //     ref.read(educationRepositoryProvider).setLesson(
    //               //           context: context,
    //               //           courseId: int.parse(_course.text),
    //               //           sectionId: int.parse(_section.text),
    //               //           lessonId: int.parse(_lesson.text),
    //               //           name: _name.text,
    //               //           text: _text.text,
    //               //           codeExample: _code.text,
    //               //           codeLanguage: _codeLanguage.text,
    //               //         );
    //               //   },
    //               //   child: const Text('Set Lesson'),
    //               // ),
    //               ElevatedButton(
    //                 onPressed: () {
    //                   ref.read(educationRepositoryProvider).updateLesson(
    //                         context: context,
    //                         courseId: int.parse(_course.text),
    //                         sectionId: int.parse(_section.text),
    //                         lessonId: int.parse(_lesson.text),
    //                         codeLanguage: _codeLanguage.text,
    //                       );
    //                 },
    //                 child: const Text('Update Lesson'),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   );
  }
}
