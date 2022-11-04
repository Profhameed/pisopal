import 'package:flutter/material.dart';
import 'package:inbestment/data/models/option_model.dart';
import 'package:inbestment/data/models/question_model.dart';
import 'package:inbestment/shared/app_text_styles.dart';
import 'package:inbestment/widgets/custom_btn.dart';

import 'my_round_card.dart';

class QuestionCard extends StatefulWidget {
  const QuestionCard(
      {Key? key, required this.asset, required this.questionModel, required this.nextCallBack})
      : super(key: key);

  // final Widget child;
  final String asset;
  final QuestionModel questionModel;
  final Function(OptionModel? optionModel) nextCallBack;

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  OptionModel? selectedOption;

  @override
  Widget build(BuildContext context) {
    return MyRoundCard(
        child: Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
            left: 0.0,
            right: 0.0,
            top: -(90.0),
            child: Container(
              height: 130,
              width: 130,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: Colors.amberAccent, width: 7.0)),
              child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Image.asset(
                    widget.asset,
                    color: Colors.amberAccent,
                  )),
              // foregroundImage: AssetImage('assets/images/rocket.png'),
            )),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 60.0, 20.0, 20.0),
          child: Column(
            children: [
              Text(
                "${widget.questionModel.questionId}. ${widget.questionModel.question}",
                textAlign: TextAlign.center,
                style:
                    poppinsMedium.copyWith(fontSize: 20.0, height: 1.0, color: Colors.blueAccent),
              ),
              optionsList(),
              const SizedBox(height: 20.0),
              CustomButton(
                  btnText: 'Next',
                  onTap: () {
                    widget.nextCallBack(selectedOption);
                  })
            ],
          ),
        )
      ],
    ));
  }

  Widget optionsList() {
    return Column(
      children: widget.questionModel.options
              ?.map((e) => RadioListTile<OptionModel?>(
                    dense: true,
                    value: e,
                    title: Text(
                      e?.option ?? '',
                      style: poppinsMedium.copyWith(fontSize: 16.0),
                    ),
                    groupValue: selectedOption,
                    onChanged: (v) {
                      selectedOption = v;
                      setState(() {});
                    },
                  ))
              .toList() ??
          [],
    );
  }
}
