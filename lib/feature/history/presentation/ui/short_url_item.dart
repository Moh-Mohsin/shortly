import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shortly/data/model/short_url.dart';
import 'package:shortly/gen/assets.gen.dart';
import 'package:shortly/feature/history/presentation/bloc/short_url_history_bloc.dart';
import 'package:shortly/util/shorty_colors.dart';

class ShortUrlItem extends StatefulWidget {
  final ShortUrl shortUrl;

  const ShortUrlItem({
    Key key,
    @required this.shortUrl,
  }) : super(key: key);

  @override
  _ShortUrlItemState createState() => _ShortUrlItemState();
}

class _ShortUrlItemState extends State<ShortUrlItem> {
  ShortUrlHistoryBloc _shortUrlHistoryBloc;
  bool _copied = false;

  @override
  void initState() {
    _shortUrlHistoryBloc = BlocProvider.of<ShortUrlHistoryBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
      child: Card(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 10.0),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        widget.shortUrl.originalLink,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _shortUrlHistoryBloc.deleteShortUrl(widget.shortUrl);
                    },
                    child: SvgPicture.asset(Assets.images.del),
                  )
                ],
              ),
              Divider(
                color: Colors.black,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  widget.shortUrl.fullShortLink,
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                      color: ShortyColors.primaryCyan,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(height: 24.0),
              Container(
                height: 40.0,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: _copied
                        ? ShortyColors.primaryDarkViolet
                        : ShortyColors.primaryCyan, // This is what you need!
                  ),
                  onPressed: () => _copyShortUrlToClipboard(widget.shortUrl),
                  child: Text(
                    _copied ? 'COPIED!' : 'COPY',
                    style: Theme.of(context).textTheme.headline6.copyWith(
                        fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
    );
  }

  _copyShortUrlToClipboard(ShortUrl shortUrl) {
    Clipboard.setData(ClipboardData(text: shortUrl.fullShortLink));
    setState(() {
      _copied = true;
    });
    Timer(Duration(seconds: 2), (){
      setState(() {
        _copied = false;
      });
    });
  }
}
