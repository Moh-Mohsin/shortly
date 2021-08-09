import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shortly/util/shorty_colors.dart';

import 'benefit.dart';

class BenefitItem extends StatelessWidget {
  final Benefit benefit;

  const BenefitItem({Key key, @required this.benefit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Container(
            height: 350,
            padding: const EdgeInsets.only(top: 42.5),
            child: Card(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                    left: 20.0, top: 70.0, right: 20.0, bottom: 50.0),
                child: Column(
                  children: [
                    Text(
                      benefit.title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline5.copyWith(
                          fontWeight: FontWeight.w900, color: Colors.black),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      benefit.description,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                          fontWeight: FontWeight.w900, color: Colors.black),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(25.0),
            child: SvgPicture.asset(
              benefit.imageAsset,
              height: 40.0,
              width: 40.0,
            ),
            decoration: BoxDecoration(
                color: ShortyColors.primaryDarkViolet, shape: BoxShape.circle),
          ),
        ],
      ),
    );
  }
}
