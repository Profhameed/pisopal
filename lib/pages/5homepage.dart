import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbestment/shared/app_text_styles.dart';
import 'package:inbestment/widgets/custom_btn.dart';
import 'package:inbestment/widgets/my_round_card.dart';
import 'package:inbestment/widgets/my_scaffold.dart';

import '../controllers/4homeController.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final HomeController controller = Get.put(HomeController(Get.arguments));

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 150.0),
            MyRoundCard(
              elevation: 5,
              color: Colors.amberAccent,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.grey.shade300,
                    ),
                    const SizedBox(width: 20.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "NAME:",
                          style: poppinsSemiBold.copyWith(color: Colors.blueAccent, fontSize: 20.0),
                        ),
                        Text(
                          "AGE:",
                          style: poppinsSemiBold.copyWith(color: Colors.blueAccent, fontSize: 20.0),
                        ),
                        Text(
                          "GENDER:",
                          style: poppinsSemiBold.copyWith(color: Colors.blueAccent, fontSize: 20.0),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Karen".toUpperCase(),
                          style: poppinsSemiBold.copyWith(fontSize: 20.0),
                        ),
                        Text(
                          controller.userModel?.birthday ?? '',
                          style: poppinsSemiBold.copyWith(fontSize: 20.0),
                        ),
                        Text(
                          controller.userModel?.gender ?? '',
                          style: poppinsSemiBold.copyWith(fontSize: 20.0),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 80.0),
            MyRoundedTransparentCardWithPic(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 20.0),
                    child: Column(
                      children: [
                        Text("GOOD JOB,",
                            style: poppinsSemiBold.copyWith(
                                fontSize: 50.0, color: Colors.amberAccent, height: 1.0)),
                        Text("KAREN!",
                            style: poppinsSemiBold.copyWith(
                                fontSize: 50.0, color: Colors.white, height: 1.0)),
                        SizedBox(height: 20.0),
                        Text(
                          "Now, let's find out your investor personality type or identify the ideal investment for you.",
                          textAlign: TextAlign.center,
                          style: poppinsSemiBold.copyWith(fontSize: 20.0, color: Colors.white),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          "We have 7 easy multiple questions.",
                          textAlign: TextAlign.center,
                          style: poppinsSemiBold.copyWith(fontSize: 20.0, color: Colors.white),
                        ),
                        Text(
                          "Just click one.",
                          textAlign: TextAlign.center,
                          style:
                              poppinsSemiBold.copyWith(fontSize: 20.0, color: Colors.amberAccent),
                        )
                      ],
                    )),
                asset: 'assets/images/like.png'),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: CustomButton(
                  btnColor: Colors.white,
                  borderColor: Colors.transparent,
                  btnText: "NEXT STEP",
                  onTap: () {
                    Get.toNamed('/questionPage');
                  }),
            ),
            const SizedBox(
              height: 40.0,
            )
          ],
        ),
      ),
    );
  }
}
