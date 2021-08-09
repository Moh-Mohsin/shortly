import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shortly/data/model/short_url.dart';
import 'package:shortly/feature/history/presentation/bloc/short_url_history_bloc.dart';
import 'package:shortly/feature/history/presentation/ui/short_url_item.dart';
import 'package:shortly/gen/assets.gen.dart';
import 'package:shortly/util/shorty_colors.dart';

class ShortUrlHistoryWidget extends StatefulWidget {
  @override
  _ShortUrlHistoryWidgetState createState() => _ShortUrlHistoryWidgetState();
}

class _ShortUrlHistoryWidgetState extends State<ShortUrlHistoryWidget> {
  ShortUrlHistoryBloc _shortUrlHistoryBloc;
  List<ShortUrl> shortUrls;
  StreamSubscription streamSubscription;
  @override
  void initState() {
    _shortUrlHistoryBloc = BlocProvider.of<ShortUrlHistoryBloc>(context);
    streamSubscription = _shortUrlHistoryBloc.getHistoryListStream().listen((event) {
      setState(() {
        shortUrls = event;
      });
    });
    super.initState();
  }
  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (shortUrls == null) {
      return Container();
    }
    return Stack(
      children: [
        shortUrls.isEmpty
            ? _buildEmptyListWidget(context)
            : ListView.builder(
                itemCount: shortUrls.length,
                itemBuilder: (context, index) =>
                    _buildListItem(index, shortUrls ?? []),
              ),
        Positioned(
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: Column(
            children: [
              Container(
                height: 20,
                // color: ShortyColors.backgroundOffWhite,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    ShortyColors.backgroundOffWhiteTransparent,
                    ShortyColors.backgroundOffWhite
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
              ),
              Container(
                height: 20,
                color: ShortyColors.backgroundOffWhite,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildListItem(int index, List<ShortUrl> shortUrls) {
    final shortUrl = shortUrls[index];
    return ShortUrlItem(
      shortUrl: shortUrl,
    );
  }
}

Widget _buildEmptyListWidget(BuildContext context) {
  return Column(
    children: [
      SizedBox(height: 80.0),
      SvgPicture.asset(Assets.images.logo),
      SizedBox(height: 30.0),
      Image(image: Assets.images.illustrationPng),
      Text(
        "Let's get started!",
        style: Theme.of(context)
            .textTheme
            .headline6
            .copyWith(fontWeight: FontWeight.w700),
      ),
      SizedBox(height: 8.0),
      Text(
        "Paste your first link into\nthe field to shorten it",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w700),
      ),
    ],
  );
}
