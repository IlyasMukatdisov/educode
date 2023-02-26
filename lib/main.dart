import 'package:educode/home_screen.dart';
import 'package:educode/utils/constants.dart';
import 'package:educode/utils/router.dart';
import 'package:educode/utils/scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: AppScrollBehavior(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData().copyWith(
        appBarTheme: AppBarTheme.of(context).copyWith(
          color: kPrimaryColor,
        ),
        primaryColor: kPrimaryColor,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: kPrimaryColor,
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme().copyWith(
          focusedBorder: const OutlineInputBorder().copyWith(
            borderSide: const BorderSide(color: kPrimaryColor),
          ),
          prefixIconColor: kPrimaryColor,
          labelStyle: const TextStyle(color: kPrimaryColor),
          focusColor: kPrimaryColor,
        ),
      ),

      // theme: ThemeData.light().copyWith(
      //   primaryColor: Colors.orange,
      //   appBarTheme: AppBarTheme.of(context).copyWith(
      //     color: Colors.orange,
      //     systemOverlayStyle: SystemUiOverlayStyle(
      //       statusBarColor: ThemeData.light().scaffoldBackgroundColor,
      //       statusBarIconBrightness:
      //           Brightness.dark, // For Android (dark icons)
      //       statusBarBrightness: Brightness.dark,
      //     ),
      //   ),
      //   colorScheme: const ColorScheme.light(
      //       primary: Colors.orange, secondary: Colors.orangeAccent),
      // ),
      // darkTheme: ThemeData.dark().copyWith(
      //   primaryColor: Colors.orangeAccent,
      //   appBarTheme: AppBarTheme.of(context).copyWith(
      //     color: Colors.orange,
      //     systemOverlayStyle: SystemUiOverlayStyle(
      //       statusBarColor: ThemeData.dark().scaffoldBackgroundColor,
      //       statusBarIconBrightness:
      //           Brightness.light, // For Android (dark icons)
      //       statusBarBrightness: Brightness.light,
      //     ),
      //   ),
      //   colorScheme: const ColorScheme.dark(
      //       primary: Colors.orange, secondary: Colors.orangeAccent),
      // ),
      // themeMode: ThemeMode.system,
      onGenerateRoute: (settings) => generateRoute(settings),
      home: const HomeScreen(),
    );
  }
}
