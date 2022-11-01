import 'package:flutter/material.dart';

import 'my_round_card.dart';


class QuestionCard extends StatelessWidget {
  const QuestionCard({Key? key, required this.child, required this.asset})
      : super(key: key);
  final Widget child;
  final String asset;

  @override
  Widget build(BuildContext context) {
    return MyRoundCard(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
                left: 0.0,
                right: 0.0,
                top: -(90.0),
                child: Container(
                  height: 130,
                  width: 130,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.amberAccent,
                      border:Border.all(color: Colors.white,width: 7.0)),
                  child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Image.asset(
                        asset,
                        color: Colors.white,
                      )),
                  // foregroundImage: AssetImage('assets/images/rocket.png'),
                )),
            child
          ],
        ));
  }
}
