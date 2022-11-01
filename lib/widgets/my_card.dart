import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyCard extends StatelessWidget {
  const MyCard({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Card(
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
