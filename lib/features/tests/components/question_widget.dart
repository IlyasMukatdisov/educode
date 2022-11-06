import 'package:educode/utils/constants.dart';
import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  final String question;
  final int indexAction;
  final int totalQuestion;

  const QuestionWidget({
    super.key,
    required this.indexAction,
    required this.question,
    required this.totalQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Question ${indexAction + 1}/$totalQuestion',
              style:
                  Theme.of(context).textTheme.headline6?.copyWith(fontSize: 17),
            ),
          ],
        ),
        const SizedBox(
          height: defaultPadding,
        ),
        Text(
          question,
          style: Theme.of(context).textTheme.headline6,
        ),
      ],
    );
  }
}
