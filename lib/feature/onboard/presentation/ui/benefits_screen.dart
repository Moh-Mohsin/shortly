import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_view_indicators/page_view_indicators.dart';
import 'package:shortly/feature/main_screen.dart';
import 'package:shortly/feature/onboard/presentation/bloc/benefits_bloc.dart';
import 'package:shortly/feature/onboard/presentation/ui/widget/benefit.dart';
import 'package:shortly/feature/onboard/presentation/ui/widget/benefit_item.dart';
import 'package:shortly/gen/assets.gen.dart';
import 'package:shortly/util/shorty_colors.dart';

class BenefitsScreen extends StatefulWidget {
  static String routeName = 'BenefitsScreen';

  @override
  _BenefitsScreenState createState() => _BenefitsScreenState();
}

class _BenefitsScreenState extends State<BenefitsScreen> {
  BenefitsBloc benefitsBloc;
  StreamSubscription _streamSubscription;

  PageController _controller;
  ValueNotifier<int> _currentPageNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    benefitsBloc = BlocProvider.of<BenefitsBloc>(context);
    _streamSubscription = benefitsBloc.stream.listen((event) {
      if (event is BenefitsSkipped) {
        Navigator.pushReplacementNamed(context, MainScreen.routeName);
      }
    });
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    _currentPageNotifier.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ShortyColors.backgroundOffWhite,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(height: 80.0),
            SvgPicture.asset(Assets.images.logo),
            SizedBox(height: 80.0),
            Flexible(
              child: PageView(
                scrollDirection: Axis.horizontal,
                controller: _controller,
                children: Benefit.getAll()
                    .map((e) => BenefitItem(benefit: e))
                    .toList(),
                onPageChanged: (int index) {
                  _currentPageNotifier.value = index;
                },
              ),
            ),
            SizedBox(height: 20.0),
            _buildCircleIndicator(),
            SizedBox(height: 80.0),
            _buildSkipButton(),
            SizedBox(height: 60.0),
          ],
        ),
      ),
    );
  }

  Widget _buildCircleIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CirclePageIndicator(
        size: 10.0,
        selectedSize: 10.0,
        itemCount: Benefit.getAll().length,
        currentPageNotifier: _currentPageNotifier,
      ),
    );
  }

  TextButton _buildSkipButton() {
    return TextButton(
      onPressed: () {
        benefitsBloc.skip();
      },
      child: Text(
        'Skip',
        style: TextStyle(color: Colors.black, fontSize: 17.0),
      ),
    );
  }
}
