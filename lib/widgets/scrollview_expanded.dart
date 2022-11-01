import 'package:flutter/material.dart';

class ScrollExpand extends StatelessWidget {
  final Widget child1;
  final Widget child2;

  const ScrollExpand({Key? key, required this.child1,required this.child2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                child1,
                child2,
              ],
            ), // your column
          ),
        );
      },
    );
  }
}
