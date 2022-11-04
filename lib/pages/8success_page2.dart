import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbestment/controllers/6successController.dart';
import 'package:inbestment/shared/app_text_styles.dart';
import 'package:inbestment/widgets/custom_btn.dart';
import 'package:inbestment/widgets/my_round_card.dart';
import 'package:inbestment/widgets/my_scaffold.dart';

class SuccessPage2 extends StatelessWidget {
  SuccessPage2({Key? key}) : super(key: key);
  final SuccessController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Center(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // mainAxisSize: MainAxisSize.max,
                  children: [
                    MyRoundCard(
                      color: Colors.amberAccent,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/question-mark.png',
                              width: 50.0,
                              height: 50.0,
                            ),
                            const SizedBox(width: 20.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Risk Profile".toUpperCase(),
                                    style:
                                        poppinsMedium.copyWith(fontSize: 16.0, color: Colors.white),
                                  ),
                                  Text(
                                    controller.category.value ?? '',
                                    style: poppinsMedium.copyWith(
                                        fontSize: 30.0, height: 1.0, color: Colors.blueAccent),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    MyRoundCard(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                      child: Column(
                        children: [
                          myRow('assets/images/icons8-checkmark-50.png',
                              'An investor who seeks a relatively stable return on investment that is slightly higher than traditional term deposit and who is willing to take minor negative fluctuations in returns.'),
                          const SizedBox(height: 10.0),
                          myRow('assets/images/icons8-checkmark-50.png',
                              'Moderately conservative investors usually have to settle for modest investment growth which might make it difficult to meet long-term goals.'),
                          const SizedBox(height: 10.0),
                          myRow('assets/images/icons8-checkmark-50.png',
                              'Investment Objective: The portfolio seeks to achieve preservation of capital considering the effects of inflation'),
                          const SizedBox(height: 10.0),
                        ],
                      ),
                    )),
                    SizedBox(height: 20.0),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: CustomButton(
                            btnText: 'DASHBOARD',
                            onTap: () {
                              Get.toNamed('/dashboardPage', arguments: controller.userModel);
                            }))
                  ],
                ),
              ), // your column
            ),
          );
        },
      ),
    );
  }

  Widget myRow(String asset, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          asset,
          width: 30.0,
          height: 30.0,
        ),
        const SizedBox(width: 20.0),
        Expanded(
          child: Text(
            text,
            style: poppinsRegular,
          ),
        ),
      ],
    );
  }
}
