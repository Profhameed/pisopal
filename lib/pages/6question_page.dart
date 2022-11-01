import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbestment/controllers/5questionsController.dart';
import 'package:inbestment/widgets/my_scaffold.dart';
import 'package:inbestment/widgets/question_card.dart';
import 'package:inbestment/widgets/scrollview_expanded.dart';

class QuestionPage extends StatelessWidget {
  QuestionPage({Key? key}) : super(key: key);
  final QuestionsController controller = Get.put(QuestionsController());

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
        body: ScrollExpand(
      child1: Container(),
      child2: Column(
        children: [
          Text("wow"),
          QuestionCard(
            asset: 'assets/images/like.png',
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.0, 60.0, 20.0, 20.0),
              child: Container(
                height: 250,
                color: Colors.red,
              ),
            ),
          ),
          const SizedBox(
            height: 40.0,
          )
        ],
      ),
    ));
  }
}
