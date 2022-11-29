import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shortly/di/injection.dart';
import 'package:shortly/feature/history/presentation/bloc/short_url_history_bloc.dart';
import 'package:shortly/feature/history/presentation/ui/short_url_history_widget.dart';
import 'package:shortly/feature/shorten/presentation/bloc/shorten_bloc.dart';
import 'package:shortly/feature/shorten/presentation/ui/shorten_widget.dart';
import 'package:shortly/util/shorty_colors.dart';

class MainScreen extends StatelessWidget {
  static String routeName = 'MainScreen';
  final ShortenBloc shortenBloc = getIt<ShortenBloc>();
  final ShortUrlHistoryBloc shortUrlHistoryBloc = getIt<ShortUrlHistoryBloc>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        color: ShortyColors.backgroundOffWhite,
        child: Stack(
          children: [
            Container(
              height: height,
              width: double.infinity,
              padding: EdgeInsets.only(bottom: 200),
              child: BlocProvider.value(
                value: shortUrlHistoryBloc,
                child: ShortUrlHistoryWidget(),
              ),
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: BlocProvider.value(
                value: shortenBloc,
                child: SizedBox(height: 200, child: ShortenWidget()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
