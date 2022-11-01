import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:inbestment/controllers/3signup_controller.dart';
import 'package:inbestment/widgets/my_scaffold.dart';
import 'package:inbestment/widgets/my_scaffold2.dart';

class SignUp2Page extends StatelessWidget {
  SignUp2Page({Key? key}) : super(key: key);

  final SignUpController controller = Get.find();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MyScaffold2(
        body: OrientationBuilder(
      builder: (ctx, orientation) => Container(),
    ));
  }
}
