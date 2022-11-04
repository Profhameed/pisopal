import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyRoundCard extends StatelessWidget {
  const MyRoundCard(
      {Key? key, required this.child, this.elevation, this.color, this.padding = 15.0})
      : super(key: key);
  final Widget child;
  final Color? color;
  final double? elevation;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Card(
        color: color,
        elevation: elevation,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: SizedBox(
          width: Get.width,
          // height: 300,
          child: child,
        ),
      ),
    );
  }
}

class MyRoundTransparentCard extends StatelessWidget {
  const MyRoundTransparentCard({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MyRoundCard(
      child: child,
      color: Colors.black.withOpacity(.3),
      elevation: 0,
    );
  }
}

class MyRoundedTransparentCardWithPic extends StatelessWidget {
  const MyRoundedTransparentCardWithPic(
      {Key? key,
      required this.child,
      required this.asset,
      this.picSize = 80,
      this.picBackColor = Colors.amberAccent,
      this.picColor = Colors.white,
      this.picPadding = 15.0})
      : super(key: key);
  final Widget child;
  final String asset;
  final double picSize;
  final Color picBackColor;

  final Color picColor;
  final double picPadding;

  @override
  Widget build(BuildContext context) {
    return MyRoundTransparentCard(
        child: Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          left: 0.0,
          right: 0.0,
          top: -(picSize / 2),
          child: Container(
            height: picSize,
            width: picSize,
            decoration: BoxDecoration(shape: BoxShape.circle, color: picBackColor),
            child: Padding(
              padding: EdgeInsets.all(picPadding),
              child: Image.asset(
                asset,
                color: picColor,
              ),
            ),
            // foregroundImage: AssetImage('assets/images/rocket.png'),
          ),
        ),
        child
      ],
    ));
  }
}
