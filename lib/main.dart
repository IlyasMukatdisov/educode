import 'package:educode/features/education/models/course_model.dart';
import 'package:educode/features/education/models/lesson_model.dart';
import 'package:educode/features/education/models/section_model.dart';
import 'package:educode/features/education/repository/local_education_repository.dart';
import 'package:educode/features/tests/screens/debug_test.dart';
import 'package:educode/features/tests/screens/tests_courses.dart';
import 'package:educode/generated/l10n.dart';
import 'package:educode/home_screen.dart';
import 'package:educode/utils/router.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  Hive.registerAdapter(CourseModelAdapter());
  Hive.registerAdapter(SectionModelAdapter());
  Hive.registerAdapter(LessonModelAdapter());

  await LocalEducationRepository().init();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.delegate.supportedLocales,
      title: 'Flutter Demo',
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.orange,
        appBarTheme: AppBarTheme.of(context).copyWith(
          color: Colors.orange,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ThemeData.light().scaffoldBackgroundColor,
            statusBarIconBrightness:
                Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.dark,
          ),
        ),
        colorScheme: const ColorScheme.light(
            primary: Colors.orange, secondary: Colors.orangeAccent),
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.orangeAccent,
        appBarTheme: AppBarTheme.of(context).copyWith(
          color: Colors.orange,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ThemeData.dark().scaffoldBackgroundColor,
            statusBarIconBrightness:
                Brightness.light, // For Android (dark icons)
            statusBarBrightness: Brightness.light,
          ),
        ),
        colorScheme: const ColorScheme.dark(
            primary: Colors.orange, secondary: Colors.orangeAccent),
      ),
      themeMode: ThemeMode.system,
      onGenerateRoute: (settings) => generateRoute(settings),
      home: const HomeScreen(),
    );
  }
}
