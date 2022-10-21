import 'package:educode/features/auth/screens/components/login_signup_buttons.dart';
import 'package:educode/features/auth/screens/components/welcome_image.dart';
import 'package:educode/utils/constants.dart';
import 'package:educode/utils/responsive.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Responsive(
      mobile: MobileWelcomeScreen(),
      desktop: DesktopWelcomeScreen(),
    );
  }
}

class DesktopWelcomeScreen extends StatelessWidget {
  const DesktopWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Expanded(
                child: WelcomeImage(),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(
                      width: 450,
                      child: LoginAndSignUpButtons(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MobileWelcomeScreen extends StatelessWidget {
  const MobileWelcomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const WelcomeImage(),
          Row(
            children: const [
              SizedBox(
                width: defaultPadding,
              ),
              Expanded(
                child: LoginAndSignUpButtons(),
              ),
              SizedBox(
                width: defaultPadding,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
