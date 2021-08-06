import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shortly/feature/shorten/presentation/bloc/shorten_bloc.dart';

import 'keys/shorten_widget_keys.dart';

class ShortenWidget extends StatefulWidget {
  const ShortenWidget({Key key}) : super(key: key);

  @override
  _ShortenWidgetState createState() => _ShortenWidgetState();
}

class _ShortenWidgetState extends State<ShortenWidget> {
  ShortenBloc _shortenBloc;
  TextEditingController _controller;

  @override
  void initState() {
    _shortenBloc = BlocProvider.of<ShortenBloc>(context);
    _controller = TextEditingController();
    _shortenBloc.stream.listen((event) {
      if(event is ShortenSuccess){
        print("####################### ShortenSuccess");
        print(event.shortUrl.originalLink);
        print(event.shortUrl.fullShortLink);
        Fluttertoast.showToast(msg: "short url: ${event.shortUrl.fullShortLink}");
      } else if (event is ShortenFailure){
        print("####################### ShortenFailure");
        print(event.msg);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShortenBloc, ShortenState>(
        builder: (context, state) {
          String label = 'Shorten a link here';
          bool error = false;
          if (state is ShortenFailure) {
            label = 'Please add a link here';
            error = true;
          }
          return Visibility(
            visible: state is! ShortenLoading,
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  _buildTextField(label, error),
                  _buildButton()
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),
            replacement: Center(child: CircularProgressIndicator()),
          );
        }
    );
  }

  Widget _buildTextField(String label, bool error) {
    return BlocBuilder<ShortenBloc, ShortenState>(
      builder: (context, state) {
        return TextField(
          key: const Key(ShortenWidgetKeys.URL_TEXT_FIELD_KEY),
          controller: _controller,
          onSubmitted: (String value) {
            _shortenBloc.shortenUrl(value);
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              // borderSide: BorderSide(color: error ? Colors.red : Colors.grey)
            ),
            hintText: 'Shorten a link here',
            errorText: error ? 'Please add a link here' : null,
          ),
        );
      },
    );
  }

  OutlinedButton _buildButton() {
    return OutlinedButton(
      key: const Key(ShortenWidgetKeys.SHORTEN_IT_BUTTON_KEY),
      child: Text("SHORTEN IT!"),
      onPressed: () {
        _shortenBloc.shortenUrl(_controller.text);
      },
    );
  }
}
