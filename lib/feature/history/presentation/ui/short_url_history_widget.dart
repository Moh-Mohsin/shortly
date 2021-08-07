import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shortly/data/model/short_url.dart';
import 'package:shortly/feature/history/presentation/bloc/short_url_history_bloc.dart';
import 'package:shortly/feature/history/presentation/ui/short_url_item.dart';

class ShortUrlHistoryWidget extends StatefulWidget {
  @override
  _ShortUrlHistoryWidgetState createState() => _ShortUrlHistoryWidgetState();
}

class _ShortUrlHistoryWidgetState extends State<ShortUrlHistoryWidget> {
  ShortUrlHistoryBloc _shortUrlHistoryBloc;
  List<ShortUrl> shortUrls;

  @override
  void initState() {
    _shortUrlHistoryBloc = BlocProvider.of<ShortUrlHistoryBloc>(context);
    _shortUrlHistoryBloc.getHistoryListStream().listen((event) {
      setState(() {
        shortUrls = event;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: shortUrls != null ? shortUrls.length : 0,
      itemBuilder: (context, index) => _buildListItem(index, shortUrls ?? []),
    );
  }

  Widget _buildListItem(int index, List<ShortUrl> shortUrls) {
    final shortUrl = shortUrls[index];
    return ShortUrlItem(shortUrl: shortUrl,);
  }
}
