import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbestment/controllers/5questionsController.dart';
import 'package:inbestment/shared/app_text_styles.dart';
import 'package:inbestment/widgets/my_scaffold.dart';
import 'package:inbestment/widgets/question_card.dart';
import 'package:inbestment/widgets/scrollview_expanded.dart';

class QuestionPage extends StatelessWidget {
  QuestionPage({Key? key}) : super(key: key);
  final QuestionsController controller = Get.put(QuestionsController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => WillPopScope(
        onWillPop: controller.backButtonDispatcher,
        child: MyScaffold(
            body: controller.questions.value == null || controller.questions.value?.length == 0
                ? const CircularProgressIndicator()
                : OrientationBuilder(
                    builder: (ctx, orientation) => ScrollExpand(
                      child1: Container(
                        height:120.0
                      ),
                      child2: Column(
                        children: [
                          Text(
                            "INVESTOR TYPE",
                            style: poppinsMedium.copyWith(fontSize: 25.0, color: Colors.white),
                          ),
                          const SizedBox(
                            height: 100.0,
                          ),
                          Obx(
                            () => QuestionCard(
                              key: UniqueKey(),
                              nextCallBack: controller.nextCallBack,
                              questionModel:
                                  controller.questions.value![controller.currentQuestion.value]!,
                              asset: 'assets/images/like.png',
                            ),
                          ),
                          const SizedBox(
                            height: 40.0,
                          )
                        ],
                      ),
                    ),
                  )),
      ),
    );
  }
}
