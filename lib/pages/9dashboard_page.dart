import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbestment/controllers/6successController.dart';
import 'package:inbestment/shared/app_text_styles.dart';
import 'package:inbestment/shared/auth_manager.dart';
import 'package:inbestment/utils/pic_enc_dec.dart';
import 'package:inbestment/widgets/custom_btn.dart';
import 'package:inbestment/widgets/my_round_card.dart';
import 'package:inbestment/widgets/my_scaffold2.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({Key? key}) : super(key: key);

// final DashboardController controller = Get.put(DashboardController(Get.arguments));
  final SuccessController controller = Get.put(SuccessController(Get.arguments));

  @override
  Widget build(BuildContext context) {
    return MyScaffold2(
      body: OrientationBuilder(builder: (context, orientation) {
        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: Get.height * 0.1),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 20.0), child: introCard()),
              const SizedBox(height: 30.0),
              Text(
                "YOUR PLAN IS READY",
                textAlign: TextAlign.center,
                style: poppinsMedium.copyWith(height: 1.0, fontSize: 25.0, color: Colors.white),
              ),
              const SizedBox(height: 20.0),
              kayamananCard(),
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'PMT',
                            style: tStyle(),
                            textAlign: TextAlign.start,
                          ),
                          Text('Interest', style: tStyle(), textAlign: TextAlign.start),
                          Text('N', style: tStyle(), textAlign: TextAlign.start),
                          Text('Total Interest', style: tStyle(), textAlign: TextAlign.start),
                          Text('Total Investment', style: tStyle(), textAlign: TextAlign.start),
                          Text('Future Value', style: tStyle(), textAlign: TextAlign.start),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${controller.pmt.toStringAsFixed(2)}',
                              style: tStyle(), textAlign: TextAlign.start),
                          Text('${(controller.interest * 100).toStringAsFixed(2)}',
                              style: tStyle(), textAlign: TextAlign.start),
                          Text('${controller.n.toStringAsFixed(2)}',
                              style: tStyle(), textAlign: TextAlign.start),
                          Text('${controller.tInterest.toStringAsFixed(2)}',
                              style: tStyle(), textAlign: TextAlign.start),
                          Text('${controller.tInvestment.toStringAsFixed(2)}',
                              style: tStyle(), textAlign: TextAlign.start),
                          Text('${controller.fv.toStringAsFixed(2)}',
                              style: tStyle(), textAlign: TextAlign.start),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Wrap(
                alignment: WrapAlignment.center,
                runSpacing: 10.0,
                spacing: 5.0,
                children: [
                  // InfoCard(title: "Gender", desc: controller.userModel.gender),
                  // InfoCard(
                  //     title: "Age", desc: calculateAge(controller.userModel.birthday).toString()),
                  InfoCard(title: "Investor Type", desc: controller.category.value ?? ''),
                  InfoCard(
                      title: "Monthly Income", desc: controller.userModel.monthlyIncome.toStringAsFixed(2)),
                  InfoCard(
                      title: "Monthly Contribution",
                      desc: controller.userModel.toInvestMonthly.toStringAsFixed(2)),
                  InfoCard(title: "Time Span", desc: "${controller.userModel.yearsToReturn} Years"),
                  InfoCard(title: "Total Puhunan", desc: controller.tInvestment.toStringAsFixed(2)),
                  InfoCard(title: "Total Kita", desc: controller.tInvestment.toStringAsFixed(2)),
                ],
              ),
              // const SizedBox(height: 20.0),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
              //   child: CustomButton(
              //     btnText: "Next",
              //     onTap: () {},
              //     btnColor: Colors.white,
              //     borderColor: Colors.white,
              //   ),
              // ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: CustomButton(
                    btnText: "LOGOUT",
                    onTap: () {
                      Get.find<AuthManager>().logoutAndRemoveToken();
                    }),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        );
      }),
    );
  }

  TextStyle tStyle() {
    return poppinsMedium.copyWith(fontSize: 14, color: Colors.white);
  }

  Widget introCard({double avatarRadius = 65}) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: Row(
                children: [
                  SizedBox(
                    width: avatarRadius * 2 - 10,
                  ),
                  Expanded(
                      child: Text(
                    'Your risk profile is'.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: poppinsMedium.copyWith(fontSize: 20.0, height: 1.0, color: Colors.white),
                  )),
                ],
              ),
            ),
            MyRoundCard(
                padding: 0.0,
                color: Colors.amberAccent,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: avatarRadius * 1.2),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 5, 20, 5),
                    child: Row(
                      children: [
                        SizedBox(
                          width: avatarRadius * 2 - 10,
                        ),
                        Expanded(
                            child: Text(
                          controller.category.value?.toUpperCase() ?? '',
                          textAlign: TextAlign.center,
                          style: poppinsMedium.copyWith(
                              fontSize: 25.0, height: 1.0, color: Colors.blueAccent),
                        ))
                      ],
                    ),
                  ),
                ))
          ],
        ),
        Positioned(
          left: -5,
          child: CircleAvatar(
            radius: avatarRadius,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: avatarRadius - 5,
              backgroundImage: const AssetImage('assets/images/user.png'),
              foregroundImage: (controller.userModel.picture != null)
                  ? MemoryImage(PicUtility.dataFromBase64String(controller.userModel.picture!))
                  : null,
            ),
          ),
        ),
      ],
    );
  }

  Widget kayamananCard() {
    return MyRoundCard(
      color: Colors.amberAccent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "YOUR FUTURE KAYAMANAN WHEN YOU'RE BACK TO THE PHILIPPINES".toUpperCase(),
                    textAlign: TextAlign.center,
                    style: poppinsMedium.copyWith(fontSize: 16.0, height: 1.0, color: Colors.white),
                  ),
                  Text(
                    controller.fv.toStringAsFixed(2),
                    textAlign: TextAlign.center,
                    style: poppinsMedium.copyWith(fontSize: 20.0, color: Colors.blueAccent),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20.0),
            CircleAvatar(
              backgroundColor: Colors.white,
              // backgroundImage: AssetImage('assets/images/rocket.png',),
              radius: 50,
              child: Image.asset(
                'assets/images/rocket.png',
                width: 50,
                height: 50,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({Key? key, required this.title, required this.desc}) : super(key: key);
  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: MyRoundCard(
        padding: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              constraints: const BoxConstraints(minHeight: 50.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
                color: Colors.amberAccent,
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 5),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: poppinsMedium.copyWith(fontSize: 16.0, color: Colors.white, height: 1.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 50.0),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    desc,
                    textAlign: TextAlign.center,
                    style: poppinsMedium.copyWith(
                        fontSize: 16.0, color: Colors.blueAccent, height: 1.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
