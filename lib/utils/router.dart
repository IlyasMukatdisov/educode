import 'package:educode/features/auth/screens/account_screen.dart';
import 'package:educode/features/courses/arguments/course_arguments.dart';
import 'package:educode/features/courses/screens/detail/course_details_screen.dart';
import 'package:educode/features/courses/screens/home/courses_home_screen.dart';
import 'package:educode/features/my_courses/screens/my_courses_screen.dart';
import 'package:educode/features/shopping/arguments/checkout_arguments.dart';
import 'package:educode/features/shopping/screens/checkout_screen.dart';
import 'package:educode/features/shopping/screens/shopping_cart_screen.dart';
import 'package:educode/features/wishlist/wishlist_screen.dart';
import 'package:educode/features/auth/screens/login_screen.dart';
import 'package:educode/features/auth/screens/register_screen.dart';
import 'package:educode/features/auth/screens/reset_password_screen.dart';
import 'package:educode/features/auth/screens/verify_email.dart';

import 'package:educode/utils/route_names.dart';
import 'package:educode/utils/screens/error_screen.dart';

import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );
    case RegisterScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const RegisterScreen(),
      );
    case ResetPasswordScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const ResetPasswordScreen(),
      );
    case VerifyEmailScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const VerifyEmailScreen(),
      );

    case RouteNames.coursesHome:
      return MaterialPageRoute(
        builder: (context) => const CoursesHomeScreen(),
      );
    case RouteNames.shoppingCart:
      return MaterialPageRoute(
        builder: (context) => const ShoppingCartScreen(),
      );
    case RouteNames.myCourses:
      return MaterialPageRoute(
        builder: (context) => const MyCoursesScreen(),
      );
    case RouteNames.wishlist:
      return MaterialPageRoute(
        builder: (context) => const WishlistScreen(),
      );
    case RouteNames.account:
      return MaterialPageRoute(
        builder: (context) => const AccountScreen(),
      );
    case RouteNames.courseDetails:
      {
        final args = settings.arguments as CourseArguments;
        return MaterialPageRoute(
          builder: (context) => CoursesDetailsScreen(course: args.course),
        );
      }
    case RouteNames.checkout:
      {
        final args = settings.arguments as CheckoutArguments;
        return MaterialPageRoute(
          builder: (context) => CheckoutScreen(
              courseList: args.courseList, totalPrice: args.totalPrice),
        );
      }
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: ErrorScreen(errorMessage: 'Page does not exists'),
        ),
      );
  }
}
