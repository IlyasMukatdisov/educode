import 'package:educode/features/intro/screens/widget/intro_column.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isKeyboardShowing = MediaQuery.of(context).viewInsets.vertical > 0;

    return LayoutBuilder(
      builder: (context, constrains) {
        return SafeArea(
          child: Scaffold(
            body: Row(
              children: [
                Expanded(
                  child: constrains.maxHeight >= 750 && !isKeyboardShowing
                      ? const IntroColumn()
                      : const SingleChildScrollView(child: IntroColumn()),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
