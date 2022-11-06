// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:educode/features/tests/repository/quiz_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TestsScreen extends ConsumerStatefulWidget {
  final int courseId;
  final int sectionId;
  static const String routeName = '/tests-screen';
  const TestsScreen({
    super.key,
    required this.courseId,
    required this.sectionId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TestsScreenState();
}

class _TestsScreenState extends ConsumerState<TestsScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ref.read(testsRepositoryProvider).getTests(
            courseId: widget.courseId.toString(),
            sectionId: widget.sectionId.toString(),
          ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          final tests = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: Text('Test'),
            ),
            body: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              itemCount: tests.length,
              itemBuilder: (context, pIndex) {
                final test = tests[pIndex];
                int? optionPicked;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.only(bottom: 16),
                            child: Text(
                              'Test ${pIndex + 1}/${tests.length}',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Text(
                            test.title,
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: test.options.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              optionPicked = index;
                            },
                            title: Text(
                              "${index + 1}) ${test.options.keys.elementAt(index)}",
                            ),
                          );
                        },
                      ),
                    ),
                    optionPicked != null
                        ? ElevatedButton(
                            child: Text('Next'),
                            onPressed: () {
                              _pageController.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeIn);
                            },
                          )
                        : const SizedBox(),
                  ],
                );
              },
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
