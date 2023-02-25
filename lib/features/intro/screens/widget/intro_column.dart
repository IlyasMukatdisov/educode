import 'package:educode/utils/constants.dart';
import 'package:educode/features/auth/screens/login_screen.dart';
import 'package:flutter/material.dart';

class IntroColumn extends StatelessWidget {
  const IntroColumn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset("assets/images/intro/intro.png"),
        const SizedBox(
          height: 30,
        ),
        Text(
          'Welcome to EduCode',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "Your journey stars here",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.normal),
        ),
        const SizedBox(
          height: 30,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              LoginScreen.routeName,
              (route) => false,
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor,
            textStyle: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          ),
          child: const Text(
            "Getting Started",
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
