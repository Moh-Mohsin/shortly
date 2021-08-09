import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shortly/feature/main_screen.dart';
import 'package:shortly/feature/onboard/domian/usecase/is_benefits_skipped_use_case.dart';
import 'package:shortly/feature/onboard/presentation/bloc/benefits_bloc.dart';
import 'package:shortly/feature/onboard/presentation/ui/benefits_screen.dart';
import 'package:shortly/feature/onboard/presentation/ui/start_screen.dart';

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
    IsBenefitsSkippedUseCase isBenefitsSkippedUseCase =
        getIt<IsBenefitsSkippedUseCase>();
    bool isBenefitsSkipped = isBenefitsSkippedUseCase();
    return MaterialApp(
      title: 'Shorty',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        cardTheme: CardTheme(
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
        ),
      ),
      // home: StartScreen(),
      initialRoute:
          isBenefitsSkipped ? MainScreen.routeName : StartScreen.routeName,
      routes: {
        MainScreen.routeName: (context) => MainScreen(),
        StartScreen.routeName: (context) => StartScreen(),
        BenefitsScreen.routeName: (context) => BlocProvider.value(
              value: getIt<BenefitsBloc>(),
              child: BenefitsScreen(),
            ),
      },
    );
  }
}
