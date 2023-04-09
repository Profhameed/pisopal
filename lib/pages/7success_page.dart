import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbestment/controllers/6successController.dart';
import 'package:inbestment/shared/app_text_styles.dart';
import 'package:inbestment/widgets/custom_btn.dart';
import 'package:inbestment/widgets/my_round_card.dart';
import 'package:inbestment/widgets/my_scaffold.dart';

class SuccessPage extends StatelessWidget {
  SuccessPage({Key? key}) : super(key: key);
  final SuccessController controller = Get.put(SuccessController(Get.arguments));

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: Obx(
        () => controller.category.value == null
            ? const Center(child: CircularProgressIndicator())
            : LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return SingleChildScrollView(
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
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),
                          child: Center(
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // mainAxisSize: MainAxisSize.max,
                              children: [
                                MyRoundedTransparentCardWithPic(
                                  asset: 'assets/images/rocket.png',
                                  picSize: 130,
                                  picBackColor: Colors.white,
                                  picColor: Colors.black,
                                  picPadding: 30.0,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(20.0, 80.0, 20.0, 20.0),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Column(
                                        children: [
                                          Text(
                                            "YOUR RISK PROFILE IS",
                                            textAlign: TextAlign.center,
                                            style: poppinsMedium.copyWith(
                                                fontSize: 20.0, color: Colors.white),
                                          ),
                                          Text("${controller.category}",
                                              textAlign: TextAlign.center,
                                              style: poppinsMedium.copyWith(
                                                  fontSize: 30.0,
                                                  height: 1.2,
                                                  color: Colors.amberAccent)),
                                          // Text(
                                          //   "YOUR SCORE IS",
                                          //   textAlign: TextAlign.center,
                                          //   style: poppinsMedium.copyWith(
                                          //       fontSize: 20.0, color: Colors.white),
                                          // ),
                                          // Text("${controller.calculateScore()}",
                                          //     textAlign: TextAlign.center,
                                          //     style: poppinsMedium.copyWith(
                                          //         fontSize: 40.0,
                                          //         height: 1.2,
                                          //         color: Colors.amberAccent))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30.0),
                                Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                    child: CustomButton(btnText: 'NEXT STEP', onTap: () {
                                      // Get.toNamed('/successPage2');
                                      Get.toNamed('/dashboardPage', arguments: controller.userModel);
                                    }))
                              ],
                            ),
                          ), // your column
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
