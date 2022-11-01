import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyScaffold extends StatelessWidget {
  const MyScaffold({Key? key, required this.body}) : super(key: key);
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/invest.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [

          Container(
            constraints: const BoxConstraints.expand(),
            color: Colors.blue.shade900.withOpacity(0.75),
          ),
          _circle(top: -_circleSize() / 2, left: 0.0, right: 0.0),
          _circle(bottom: -_circleSize() / 2, left: -_circleSize()/2,),
          _circle(bottom: 100, right: -_circleSize() / 2),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: body,),
        ],

      ),
    );
  }

  Widget _circle({double? top, double? left, double? right, double? bottom}) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Container(
        width: _circleSize(),
        height: _circleSize(),

        decoration: const BoxDecoration(color: Colors.amberAccent, shape: BoxShape.circle),
      ),
    );
  }
}

double _circleSize(){
  if(Get.mediaQuery.orientation == Orientation.portrait) {
    return Get.width * 0.6;
  }else {
    return Get.height * 0.6;
  }
}