import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbestment/shared/app_text_styles.dart';
import 'package:inbestment/utils/calculate_age.dart';
import 'package:inbestment/widgets/custom_btn.dart';
import 'package:inbestment/widgets/my_round_card.dart';
import 'package:inbestment/widgets/my_scaffold.dart';

import '../controllers/4homeController.dart';
import '../utils/pic_enc_dec.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final HomeController controller = Get.put(HomeController(Get.arguments));

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: controller.controllerTopCenter,
                blastDirection: pi / 2,
                maxBlastForce: 10,
                // set a lower max blast force
                minBlastForce: 2,
                // set a lower min blast force
                emissionFrequency: 0.02,
                numberOfParticles: 50,
                // a lot of particles at once
                colors: [
                  Colors.amber,
                ],
                blastDirectionality: BlastDirectionality.explosive,
                particleDrag: 0.06,
                gravity: 1,
                canvas: Size(
                  Get.width,
                  Get.height,
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.1),
            MyRoundCard(
              elevation: 5,
              color: Colors.amberAccent,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.grey.shade300,
                      backgroundImage:  const AssetImage('assets/images/user.png'),
                      foregroundImage:(controller.userModel?.picture != null)? MemoryImage(
                          PicUtility.dataFromBase64String(controller.userModel!.picture!)):null,
                    ),
                    // const SizedBox(width: 16.0),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "NAME:",
                            style:
                                poppinsSemiBold.copyWith(color: Colors.blueAccent, fontSize: 16.0),
                          ),
                          Text(
                            "AGE:",
                            style:
                                poppinsSemiBold.copyWith(color: Colors.blueAccent, fontSize: 16.0),
                          ),
                          Text(
                            "GENDER:",
                            style:
                                poppinsSemiBold.copyWith(color: Colors.blueAccent, fontSize: 16.0),
                          )
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.userModel?.userName.toUpperCase() ?? '',
                            style: poppinsSemiBold.copyWith(fontSize: 16.0),
                          ),
                          Text(
                            calculateAge(controller.userModel!.birthday).toString(),
                            style: poppinsSemiBold.copyWith(fontSize: 16.0),
                          ),
                          Text(
                            controller.userModel?.gender ?? '',
                            style: poppinsSemiBold.copyWith(fontSize: 16.0),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50.0),
            MyRoundedTransparentCardWithPic(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 50.0, 16.0, 16.0),
                    child: Column(
                      children: [
                        Text("GOOD JOB,",
                            textAlign: TextAlign.center,
                            style: poppinsSemiBold.copyWith(
                                fontSize: 30.0, color: Colors.amberAccent, height: 1.0)),
                        Text(controller.userModel?.userName.toUpperCase() ?? '',
                            textAlign: TextAlign.center,
                            style: poppinsSemiBold.copyWith(
                                fontSize: 30.0, color: Colors.white, height: 1.0)),
                        SizedBox(height: 16.0),
                        Text(
                          "Now, let's find out your investor personality type or identify the ideal investment for you.",
                          textAlign: TextAlign.center,
                          style: poppinsSemiBold.copyWith(fontSize: 16.0, color: Colors.white),
                        ),
                        const SizedBox(height: 16.0),
                        Text(
                          "We have 7 easy multiple questions.",
                          textAlign: TextAlign.center,
                          style: poppinsSemiBold.copyWith(fontSize: 16.0, color: Colors.white),
                        ),
                        Text(
                          "Just click once.",
                          textAlign: TextAlign.center,
                          style:
                              poppinsSemiBold.copyWith(fontSize: 16.0, color: Colors.amberAccent),
                        )
                      ],
                    )),
                asset: 'assets/images/like.png'),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: CustomButton(
                  btnColor: Colors.white,
                  borderColor: Colors.transparent,
                  btnText: "NEXT STEP",
                  onTap: () {
                    Get.toNamed('/questionPage');
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: CustomButton(
                  btnText: "Sign Out",
                  onTap: () {
                    controller.signOut();
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
