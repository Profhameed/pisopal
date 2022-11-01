import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbestment/controllers/3signup_controller.dart';
import 'package:inbestment/shared/app_text_styles.dart';
import 'package:inbestment/widgets/custom_btn.dart';
import 'package:inbestment/widgets/my_round_card.dart';
import 'package:inbestment/widgets/my_scaffold2.dart';
import 'package:intl/intl.dart';

class SignUp2Page extends StatelessWidget {
  SignUp2Page({Key? key}) : super(key: key);

  final SignUpController controller = Get.find();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MyScaffold2(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: 100),
              MyRoundedTransparentCardWithPic(
                asset: 'assets/images/rocket.png',
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      Text("To make our dreams come true, we first hav to set a goal.",
                          textAlign: TextAlign.center,
                          style: poppinsMedium.copyWith(
                            fontSize: 18.0,
                            color: Colors.white,
                          )),
                      const SizedBox(height: 10.0),
                      Text(
                        "LET'S GET STARTED",
                        textAlign: TextAlign.center,
                        style: poppinsSemiBold.copyWith(
                            fontSize: 30.0, height: 1.0, color: Colors.amberAccent),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15.0),
              MyRoundCard(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.grey.shade300,
                      ),
                      const SizedBox(width: 20.0),
                      Column(
                        children: [
                          OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0)),
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                              child: Text("Upload")),
                          TextButton(onPressed: () {}, child: Text("Remove Image"))
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15.0),
              Row(
                children: [
                  Expanded(
                    child: MyRoundCard(
                      padding: 5.0,
                      color: Colors.amberAccent,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                        child: Column(
                          children: [
                            Text(
                              "Gender",
                              style:
                                  poppinsMedium.copyWith(fontSize: 20.0, color: Colors.blueAccent),
                            ),
                            DropdownButtonFormField(
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                                  fillColor: Colors.white,
                                  filled: true),
                              items: const <DropdownMenuItem<String>>[
                                DropdownMenuItem(
                                  child: Text("Male"),
                                  value: "Male",
                                ),
                                DropdownMenuItem(child: Text("Female"), value: "Female"),
                              ],
                              value: "Male",
                              onChanged: (String? value) {
                                controller.gender = value!;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: MyRoundCard(
                      padding: 5.0,
                      color: Colors.amberAccent,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                        child: Column(
                          children: [
                            Text(
                              "Date Of Birth",
                              style:
                                  poppinsMedium.copyWith(fontSize: 20.0, color: Colors.blueAccent),
                            ),
                            TextFormField(
                              validator: commonValidator,
                              controller: controller.dateTimeController,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                                  fillColor: Colors.white,
                                  filled: true),
                              keyboardType: TextInputType.none,
                              onTap: () async {
                                DateTime? dateTime = await showDatePicker(
                                    context: context,
                                    initialDate: controller.dateTime,
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2100));
                                if (dateTime == null) return;
                                controller.dateTime = dateTime;
                                controller.dateTimeController.text =
                                    DateFormat('dd/MM/yyy').format(dateTime);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: MyRoundCard(
                      padding: 5.0,
                      color: Colors.amberAccent,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                        child: Column(
                          children: [
                            Text(
                              "Current Monthly Income",
                              textAlign: TextAlign.center,
                              style:
                                  poppinsMedium.copyWith(fontSize: 20.0, color: Colors.blueAccent),
                            ),
                            TextFormField(
                              validator: commonValidator,
                              controller: controller.monthlyIncomeController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                                  fillColor: Colors.white,
                                  filled: true),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: MyRoundCard(
                      padding: 5.0,
                      color: Colors.amberAccent,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                        child: Column(
                          children: [
                            Text(
                              "How much can you invest monthly?",
                              textAlign: TextAlign.center,
                              style:
                                  poppinsMedium.copyWith(fontSize: 17.0, color: Colors.blueAccent),
                            ),
                            TextFormField(
                                validator: commonValidator,
                                controller: controller.monthlyInvestmentController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black),
                                        borderRadius: BorderRadius.all(Radius.circular(16.0))),
                                    fillColor: Colors.white,
                                    filled: true)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              MyRoundCard(
                padding: 5.0,
                color: Colors.amberAccent,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  child: Column(
                    children: [
                      Text(
                        "When do you plan to return to philippines for good? (years)",
                        textAlign: TextAlign.center,
                        style: poppinsMedium.copyWith(fontSize: 20.0, color: Colors.blueAccent),
                      ),
                      TextFormField(
                          validator: commonValidator,
                          controller: controller.planYearsController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.all(Radius.circular(16.0))),
                              fillColor: Colors.white,
                              filled: true)),
                    ],
                  ),
                ),
              ),
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
                      if (formKey.currentState?.validate() ?? false) {
                        controller.signUp();
                      }
                    }),
              ),
              const SizedBox(
                height: 40.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? commonValidator(String? v) {
    if (v == null || v.isEmpty || v.length == 0) {
      return 'invalid value';
    }
    return null;
  }
}
