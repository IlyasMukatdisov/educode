import 'package:educode/features/auth/bloc/auth_bloc.dart';
import 'package:educode/features/auth/provider/firebase_auth_provider.dart';
import 'package:educode/generated/l10n.dart';
import 'package:educode/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
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
      theme: ThemeData(primarySwatch: Colors.orange),
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(
          provider: FirebaseAuthProvider(),
        ),
        child: const HomePage(),
      ),
    );
  }
}
