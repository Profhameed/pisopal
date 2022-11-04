import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DialogHelper {
  //show dialog
  static Future<void> showMyDialog(
      {String? title = 'Error',
      String? description = 'Something went wrong',
      void Function()? afterDismissCallBack,
      String? buttonText = 'Okay'}) async {
    await Get.dialog(Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(title ?? '', style: Get.textTheme.headline6),
              Text(description ?? '', style: Get.textTheme.bodyText2),
              ElevatedButton(
                  onPressed: () {
                    if (Get.isDialogOpen ?? false) Get.back();
                    if (afterDismissCallBack != null) afterDismissCallBack();
                  },
                  child: Text(buttonText ?? 'Okay'))
            ]),
      ),
    ),
    barrierDismissible: false);
  }

//show toast
// show loading
  static void showLoading(String? message) {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 8),
              Text(
                message ?? 'loading...'.tr,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

// hide loading
  static void hideLoading() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  static showConfirmationDialog(
      {String message = 'Are you sure you want to make the changes?',
      String okBtnText = 'Change',
      String cancelBtnText = 'Cancel',
      String titleText = 'Confirmation',
      void Function()? afterOkCallBack,
      void Function()? afterCancelCallBack}) {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(titleText,
                  style: GoogleFonts.prompt(
                      fontSize: 20, color: const Color(0xff626262), fontWeight: FontWeight.w600)),
              const Divider(thickness: 2, color: Color(0xfff6f6f7)),
              Text(
                message,
                style: GoogleFonts.prompt(
                    fontSize: 16, color: const Color(0xff626262), fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    child: Text(okBtnText),
                    onPressed: () async {
                      Get.back();
                      if (afterOkCallBack != null) afterOkCallBack();
                    },
                    // border: BorderStyle.none,
                  ),
                  ElevatedButton(
                    child: Text(cancelBtnText),
                    onPressed: () {
                      Get.back();
                      if (afterCancelCallBack != null) afterCancelCallBack();
                    },
                    // borderColor: Colors.black,
                    // backColor: Colors.white,
                    // textColor: const Color(0xff626262),
                    // rippleColor: Colors.grey,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
