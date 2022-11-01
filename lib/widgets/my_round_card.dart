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
  const MyRoundedTransparentCardWithPic({Key? key, required this.child, required this.asset})
      : super(key: key);
  final Widget child;
  final String asset;

  @override
  Widget build(BuildContext context) {
    return MyRoundTransparentCard(
        child: Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
            left: 0.0,
            right: 0.0,
            top: -(60.0),
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.amberAccent),
              child: Padding(
                  padding: const EdgeInsets.all(15.0),
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
