import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shortly/feature/main_screen.dart';
import 'package:shortly/util/shorty_colors.dart';

import 'di/injection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies(Env.prod).then((value) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shorty',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: MainScreen(),
      initialRoute: MainScreen.routeName,
      routes: {
        MainScreen.routeName: (context) => MainScreen(),
      },
    );
  }
}