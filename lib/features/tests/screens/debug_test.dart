// import 'package:educode/features/education/models/course_model.dart';
// import 'package:educode/features/education/repository/firebase_education_repository.dart';
// import 'package:educode/features/education/repository/local_education_repository.dart';
// import 'package:educode/features/tests/repository/quiz_repository.dart';
// import 'package:educode/utils/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class DebugTest extends ConsumerStatefulWidget {
//   static const String routeName = '/debug-screen';

//   const DebugTest({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _DebugScreenState();
// }

// class _DebugScreenState extends ConsumerState<DebugTest> {
//   late final TextEditingController _course;
//   late final TextEditingController _section;
//   late final TextEditingController _test;
//   late final TextEditingController _title;
//   late final TextEditingController _option1;
//   late final TextEditingController _option2;
//   late final TextEditingController _option3;
//   late final TextEditingController _option4;
//   bool isFirstTrue = false;
//   bool isSecondTrue = false;
//   bool isThirdTrue = false;
//   bool isFourthTrue = false;

//   List<CourseModel>? courses;

//   @override
//   void initState() {
//     super.initState();
//     _course = TextEditingController();
//     _section = TextEditingController();
//     _test = TextEditingController();
//     _title = TextEditingController();
//     _option1 = TextEditingController();
//     _option2 = TextEditingController();
//     _option3 = TextEditingController();
//     _option4 = TextEditingController();
//   }

//   @override
//   void dispose() {
//     _course.dispose();
//     _section.dispose();
//     _test.dispose();
//     _title.dispose();
//     _option1.dispose();
//     _option2.dispose();
//     _option3.dispose();
//     _option4.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return Scaffold(
//       body: Center(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(defaultPadding),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       child: TextField(
//                         controller: _course,
//                         decoration: const InputDecoration(
//                           border: OutlineInputBorder(),
//                           labelText: 'course',
//                         ),
//                         maxLines: 1,
//                         keyboardType: TextInputType.number,
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     Expanded(
//                       child: TextField(
//                         controller: _section,
//                         decoration: const InputDecoration(
//                           border: OutlineInputBorder(),
//                           labelText: 'section',
//                         ),
//                         maxLines: 1,
//                         keyboardType: TextInputType.number,
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     Expanded(
//                       child: TextField(
//                         controller: _test,
//                         decoration: const InputDecoration(
//                           border: OutlineInputBorder(),
//                           labelText: 'test',
//                         ),
//                         maxLines: 1,
//                         keyboardType: TextInputType.number,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 TextField(
//                   controller: _title,
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'title',
//                   ),
//                   maxLines: null,
//                   keyboardType: TextInputType.multiline,
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: TextField(
//                         controller: _option1,
//                         decoration: const InputDecoration(
//                           border: OutlineInputBorder(),
//                           labelText: 'option 1',
//                         ),
//                         maxLines: null,
//                         keyboardType: TextInputType.multiline,
//                       ),
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Checkbox(
//                       value: isFirstTrue,
//                       onChanged: (value) {
//                         setState(() {
//                           if (value != null) isFirstTrue = value;
//                         });
//                       },
//                     )
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: TextField(
//                         controller: _option2,
//                         decoration: const InputDecoration(
//                           border: OutlineInputBorder(),
//                           labelText: 'option 2',
//                         ),
//                         maxLines: null,
//                         keyboardType: TextInputType.multiline,
//                       ),
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Checkbox(
//                       value: isSecondTrue,
//                       onChanged: (value) {
//                         setState(() {
//                           if (value != null) isSecondTrue = value;
//                         });
//                       },
//                     )
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: TextField(
//                         controller: _option3,
//                         decoration: const InputDecoration(
//                           border: OutlineInputBorder(),
//                           labelText: 'option 3',
//                         ),
//                         maxLines: null,
//                         keyboardType: TextInputType.multiline,
//                       ),
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Checkbox(
//                       value: isThirdTrue,
//                       onChanged: (value) {
//                         setState(() {
//                           if (value != null) isThirdTrue = value;
//                         });
//                       },
//                     )
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: TextField(
//                         controller: _option4,
//                         decoration: const InputDecoration(
//                           border: OutlineInputBorder(),
//                           labelText: 'option 4',
//                         ),
//                         maxLines: null,
//                         keyboardType: TextInputType.multiline,
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     Checkbox(
//                       value: isFourthTrue,
//                       onChanged: (value) {
//                         setState(() {
//                           if (value != null) isFourthTrue = value;
//                         });
//                       },
//                     )
//                   ],
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     ref.read(testsRepositoryProvider).setTest(
//                         questionId: _test.text,
//                         courseId: _course.text,
//                         sectionId: _section.text,
//                         title: _title.text,
//                         answers: {
//                           _option1.text: isFirstTrue,
//                           _option2.text: isSecondTrue,
//                           _option3.text: isThirdTrue,
//                           _option4.text: isFourthTrue,
//                         });
//                   },
//                   child: const Text('Set Test'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
