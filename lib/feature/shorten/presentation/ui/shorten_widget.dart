import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shortly/data/exceptions/exceptions.dart';
import 'package:shortly/feature/shorten/presentation/bloc/shorten_bloc.dart';
import 'package:shortly/gen/assets.gen.dart';
import 'package:shortly/util/shorty_colors.dart';

import 'keys/shorten_widget_keys.dart';

class ShortenWidget extends StatefulWidget {
  const ShortenWidget({Key? key}) : super(key: key);

  @override
  _ShortenWidgetState createState() => _ShortenWidgetState();
}

class _ShortenWidgetState extends State<ShortenWidget> {
  late ShortenBloc _shortenBloc;
  TextEditingController? _controller;
  late StreamSubscription _streamSubscription;

  @override
  void initState() {
    _shortenBloc = BlocProvider.of<ShortenBloc>(context);
    _controller = TextEditingController();
    _streamSubscription = _shortenBloc.stream.listen((state) {
      if (state is ShortenSuccess) {
        print("####################### ShortenSuccess");
        print(state.shortUrl.originalLink);
        print(state.shortUrl.fullShortLink);
        Fluttertoast.showToast(
            msg: "short url: ${state.shortUrl.fullShortLink}");

        _controller!.text = "";
      } else if (state is ShortenFailure) {
        print("####################### ShortenFailure");
        Fluttertoast.showToast(msg: state.msg!);
        print(state.msg);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Positioned.fill(
            child: Container(
          color: ShortyColors.primaryDarkViolet,
        )),
        SvgPicture.asset(Assets.images.shape, color: ShortyColors.lightViolet),
        Container(
          padding: EdgeInsets.all(30.0),
          child:
              BlocBuilder<ShortenBloc, ShortenState>(builder: (context, state) {
            String label = 'Shorten a link here';
            bool error = false;
            if (state is ShortenFailure &&
                state.appException is BadRequestException) {
              label = 'Please add a link here';
              error = true;
            }
            return Visibility(
              visible: state is! ShortenLoading,
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    _buildTextField(context, label, error),
                    SizedBox(
                      height: 10.0,
                    ),
                    _buildButton(),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
              replacement: Center(child: CircularProgressIndicator()),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildTextField(BuildContext context, String label, bool isError) {
    return Theme(
      data: Theme.of(context).copyWith(
          primaryColor: isError ? Colors.red : ShortyColors.primaryCyan),
      child: TextField(
        key: const Key(ShortenWidgetKeys.URL_TEXT_FIELD_KEY),
        controller: _controller,
        autofocus: isError,
        onSubmitted: (String value) {
          _shortenBloc.shortenUrl(value);
        },
        // selectionHeightStyle: BoxHeightStyle.tight,
        textAlign: TextAlign.center,
        style: TextStyle(
          height: .8,
        ),
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintStyle:
                TextStyle(height: .8, color: isError ? Colors.red : null),
            hintText:
                isError ? 'Please add a link here' : 'Shorten a link here ...',
            fillColor: Colors.white,
            filled: true),
      ),
    );
  }

  Widget _buildButton() {
    return Container(
      width: double.infinity,
      child: SizedBox(
        height: 50.0,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: ShortyColors.primaryCyan,
          ),
          key: const Key(ShortenWidgetKeys.SHORTEN_IT_BUTTON_KEY),
          child: Text(
            "SHORTEN IT!",
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.w700, color: Colors.white),
          ),
          onPressed: () {
            _shortenBloc.shortenUrl(_controller!.text);
          },
        ),
      ),
    );
  }
}
