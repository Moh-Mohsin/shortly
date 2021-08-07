import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shortly/di/injection.dart';
import 'package:shortly/feature/history/presentation/ui/short_url_history_widget.dart';
import 'package:shortly/feature/shorten/presentation/bloc/shorten_bloc.dart';
import 'package:shortly/feature/history/presentation/bloc/short_url_history_bloc.dart';
import 'package:shortly/feature/shorten/presentation/ui/shorten_widget.dart';
import 'package:shortly/util/shorty_colors.dart';

class MainScreen extends StatelessWidget {
  static String routeName = 'MainScreen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Container(
          color: ShortyColors.backgroundOffWhite,
          child: Column(
            children: [
              Expanded(
                child: BlocProvider.value(
                  value: getIt<ShortUrlHistoryBloc>(),
                  child: ShortUrlHistoryWidget(),
                ),
              ),
              BlocProvider.value(
                value: getIt<ShortenBloc>(),
                child: ShortenWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
