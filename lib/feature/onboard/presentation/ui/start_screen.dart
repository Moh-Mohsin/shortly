import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shortly/feature/onboard/presentation/ui/benefits_screen.dart';
import 'package:shortly/gen/assets.gen.dart';
import 'package:shortly/util/shorty_colors.dart';

class StartScreen extends StatelessWidget {
  static String routeName = 'StartScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: ShortyColors.backgroundWhite,
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(height: 80.0),
              SvgPicture.asset(Assets.images.logo),
              SizedBox(height: 30.0),
              Image(image: Assets.images.illustrationPng),
              Text(
                "More Than just\nShorter link",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(fontWeight: FontWeight.w900, color: Colors.black),
              ),
              SizedBox(height: 10.0),
              Text(
                "Build your brand's recognition and\nget detailed insights on how your\nlinks are performing.",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              SizedBox(height: 30.0),
              Container(
                height: 50.0,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 60.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: ShortyColors.primaryCyan, // This is what you need!
                  ),
                  child: Text(
                    'START',
                    style: Theme.of(context).textTheme.headline6.copyWith(
                        fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, BenefitsScreen.routeName);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
