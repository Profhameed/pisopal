import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:get/get.dart';
import 'package:inbestment/controllers/3signup_controller.dart';
import 'package:inbestment/shared/app_text_styles.dart';
import 'package:inbestment/utils/pic_enc_dec.dart';
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
              SizedBox(height: Get.height * 0.1),
              MyRoundedTransparentCardWithPic(
                asset: 'assets/images/rocket.png',
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 25.0),
                  child: Column(
                    children: [
                      Text("To make our dreams come true, we first hav to set a goal.",
                          textAlign: TextAlign.center,
                          style: poppinsMedium.copyWith(
                            fontSize: 16.0,
                            color: Colors.white,
                          )),
                      const SizedBox(height: 10.0),
                      Text(
                        "LET'S GET STARTED",
                        textAlign: TextAlign.center,
                        style: poppinsSemiBold.copyWith(
                            fontSize: 25, height: 1.0, color: Colors.amberAccent),
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
                      Obx(
                        () => CircleAvatar(
                          radius: 45,
                          backgroundColor: Colors.grey.shade300,
                          backgroundImage: const AssetImage('assets/images/user.png'),
                          foregroundImage: controller.pic.value == null
                              ? null
                              : MemoryImage(
                                  PicUtility.dataFromBase64String(controller.pic.value ?? "")),
                        ),
                      ),
                      const SizedBox(width: 20.0),
                      Column(
                        children: [
                          OutlinedButton(
                            child: const Text("Upload"),
                            onPressed: () {
                              controller.pickImage();
                            },
                            style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 25),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0)),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                          ),
                          TextButton(
                              onPressed: () {
                                controller.pic.value = null;
                              },
                              child: const Text("Remove Image"))
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15.0),
              Visibility(
                  visible: controller.phoneController.text == "",
                  child: MyRoundCard(
                    padding: 5.0,
                    color: Colors.amberAccent,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                      child: Column(
                        children: [
                          Text(
                            "Mobile",
                            textAlign: TextAlign.center,
                            style: poppinsMedium.copyWith(fontSize: 16, color: Colors.blueAccent),
                          ),
                          TextFormField(
                              validator: commonValidator,
                              controller: controller.phoneController,
                              keyboardType: const TextInputType.numberWithOptions(decimal: false),
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(16.0),
                                    ),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true)),
                        ],
                      ),
                    ),
                  )),
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
                                  poppinsMedium.copyWith(fontSize: 16.0, color: Colors.blueAccent),
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
                              style: poppinsMedium.copyWith(fontSize: 16, color: Colors.blueAccent),
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
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                );
                                if (dateTime == null) return;
                                controller.dateTime = dateTime;
                                controller.dateTimeController.text =
                                    DateFormat('MM/dd/yyy').format(dateTime);
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
                              style: poppinsMedium.copyWith(fontSize: 16, color: Colors.blueAccent),
                            ),
                            TextFormField(
                              validator: commonValidator,
                              controller: controller.monthlyIncomeController,
                              keyboardType: TextInputType.number,

                              /// be careful! do not change, until checking "currencyToNoComma" in controller
                              inputFormatters: [
                                CurrencyInputFormatter(useSymbolPadding: true, leadingSymbol: '₱'
                                    // mantissaLength: 3 // the length of the fractional side
                                    )
                              ],
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

                                /// be careful! do not change, until checking "currencyToNoComma" in controller
                                inputFormatters: [
                                  CurrencyInputFormatter(
                                    useSymbolPadding: true,
                                    leadingSymbol: '₱',
                                    // mantissaLength: 3 // the length of the fractional side
                                  )
                                ],
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
                        style: poppinsMedium.copyWith(fontSize: 16, color: Colors.blueAccent),
                      ),
                      TextFormField(
                          validator: commonValidator,
                          controller: controller.planYearsController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: false),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(2),
                          ],
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16.0),
                                ),
                              ),
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
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: CustomButton(
                    btnColor: Colors.white,
                    borderColor: Colors.transparent,
                    btnText: "NEXT STEP",
                    onTap: () {
                      if (formKey.currentState?.validate() ?? false) {
                        ///to make the picture mandatory
                        // if (controller.pic.value == null) {
                        //   Get.snackbar("Error", "Upload Image Please");
                        //   return;
                        // }
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
