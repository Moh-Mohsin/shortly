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
    // final padding = MediaQuery.of(context).padding;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      body: Container(
        color: ShortyColors.backgroundOffWhite,
        child: SingleChildScrollView(
          child: Stack(
            // alignment: AlignmentDirectional.bottomCenter,
            children: [
              SizedBox(
                height: height,
                width: double.infinity,
                child: BlocProvider.value(
                  value: getIt<ShortUrlHistoryBloc>(),
                  child: ShortUrlHistoryWidget(),
                ),
              ),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: BlocProvider.value(
                  value: getIt<ShortenBloc>(),
                  child: SizedBox(
                    height: 200,
                      child: ShortenWidget()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
