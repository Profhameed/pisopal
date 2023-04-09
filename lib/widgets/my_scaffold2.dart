import 'package:flutter/material.dart';

class MyScaffold2 extends StatelessWidget {
  const MyScaffold2({Key? key, required this.body}) : super(key: key);
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
          Scaffold(
            backgroundColor: Colors.transparent,
            body: body,
          ),
        ],
      ),
    );
  }
}
