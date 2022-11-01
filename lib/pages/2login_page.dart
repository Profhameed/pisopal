import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbestment/controllers/2login_controller.dart';
import 'package:inbestment/widgets/custom_btn.dart';
import 'package:inbestment/widgets/custom_field.dart';
import 'package:inbestment/widgets/my_round_card.dart';
import 'package:inbestment/widgets/my_scaffold.dart';

import '../shared/app_text_styles.dart';
import '../widgets/scrollview_expanded.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final LoginController controller = Get.put(LoginController());
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
        body: OrientationBuilder(
      builder: (ctx, orientation) => ScrollExpand(
        child1: Column(
          children: [
            SizedBox(height: Get.height * 0.15),
            Image.asset(
              'assets/images/investIcon.png',
              height: Get.height * 0.2,
              color: Colors.white,
            ),
            Text(
              'investment.com',
              style: poppinsMedium.copyWith(
                fontSize: 18.0,
                color: Colors.white,
              ),
            )
          ],
        ),
        child2: MyRoundCard(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            // child: Container(height:1000,color: Colors.yellow,))
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "GET STARTED",
                    style: poppinsSemiBold.copyWith(fontSize: 30.0, color: Colors.blueAccent),
                  ),
                  const SizedBox(height: 10.0),
                  CustomTextField(
                      controller: controller.emailController,
                      hintText: 'E-mail Address',
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) {
                        if (v == null || v.isEmpty || !GetUtils.isEmail(v)) {
                          return 'invalid email';
                        }
                        return null;
                      }),
                  const SizedBox(height: 10.0),
                  CustomTextField(
                    controller: controller.passwordController,
                    hintText: 'Password',
                    obscureText: true,
                    validator: (v) {
                      if (v == null || v.isEmpty || v.length == 0) {
                        return 'invalid password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10.0),
                  CustomButton(
                      btnText: "Sign In",
                      onTap: () {
                        if (formKey.currentState?.validate() ?? false) {
                          controller.signIn();
                        }
                      }),
                  const SizedBox(height: 10.0),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed('/signUpPage');
                    },
                    child: Text(
                      'OR SIGN UP',
                      style: poppinsRegular.copyWith(
                          fontSize: 15.0,
                          color: Colors.black,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  CustomButton(
                    btnText: 'CONTINUE WITH FACEBOOK',
                    onTap: () async {},
                    btnTextSize: 10.0,
                    btnHeight: 36.0,
                    borderRadius: 40.0,
                    btnTextColor: Colors.white,
                    btnColor: const Color(0xff4267B2),
                    borderColor: const Color(0xff4267B2),
                  ),
                  CustomButton(
                    btnText: 'CONTINUE WITH APPLE',
                    onTap: () async {},
                    btnTextSize: 10.0,
                    btnHeight: 36.0,
                    borderRadius: 40.0,
                    btnTextColor: Colors.white,
                    btnColor: Colors.black,
                    borderColor: Colors.transparent,
                  ),
                  CustomButton(
                    btnText: 'CONTINUE WITH GOOGLE',
                    onTap: () async {},
                    btnTextSize: 10.0,
                    btnHeight: 36.0,
                    borderRadius: 40.0,
                    btnTextColor: Colors.black,
                    btnColor: Colors.white,
                    borderColor: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
