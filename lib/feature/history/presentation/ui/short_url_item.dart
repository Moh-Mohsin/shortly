
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shortly/data/model/short_url.dart';
import 'package:shortly/gen/assets.gen.dart';
import 'package:shortly/feature/history/presentation/bloc/short_url_history_bloc.dart';

class ShortUrlItem extends StatefulWidget {
  final ShortUrl shortUrl;

  const ShortUrlItem({Key key, @required this.shortUrl, }) : super(key: key);

  @override
  _ShortUrlItemState createState() => _ShortUrlItemState();
}

class _ShortUrlItemState extends State<ShortUrlItem> {
  ShortUrlHistoryBloc _shortUrlHistoryBloc;

  @override
  void initState() {
    _shortUrlHistoryBloc = BlocProvider.of<ShortUrlHistoryBloc>(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.shortUrl.originalLink,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    _shortUrlHistoryBloc.deleteShortUrl(widget.shortUrl);
                  },
                  child: Image(image: AssetGenImage(Assets.images.del)),
                )
              ],
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(widget.shortUrl.fullShortLink),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {},
                child: Text('copy'),
              ),
            )
          ],
        ),
      ),
    );
  }
}