import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shortly/di/injection.dart';
import 'package:shortly/feature/shorten/presentation/bloc/shorten_bloc.dart';
import 'package:shortly/feature/shorten/presentation/ui/shorten_widget.dart';

class MainScreen extends StatelessWidget {
  static String routeName = 'MainScreen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Center(
          child: BlocProvider.value(
            value: getIt<ShortenBloc>(),
            child: ShortenWidget(),
          ),
        ),
      ),
    );
  }
}
