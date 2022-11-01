import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbestment/widgets/my_scaffold.dart';

import '../controllers/4homeController.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: Column(
        children: [
          Obx(() => controller.userModel.value == null
              ? const CircularProgressIndicator()
              : Text(controller.userModel.value!.toString())),
          ElevatedButton(
            child: Text("sign out"),
            onPressed: () async {
            controller.signOut();
            },
          )
        ],
      ),
    );
  }
}
