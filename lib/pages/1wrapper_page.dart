import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbestment/widgets/my_scaffold.dart';

import '../controllers/1wrapper_controller.dart';

class WrapperPage extends StatelessWidget {
  final WrapperController controller = Get.put(WrapperController());

  WrapperPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  const MyScaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
