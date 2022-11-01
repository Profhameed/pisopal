import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inbestment/shared/app_text_styles.dart';


class CustomButton extends StatelessWidget {
  final String? btnText;
  final Color? btnColor;
  final Color? borderColor;
  final Color? btnTextColor;
  final VoidCallback? onTap;
  final double? width;
  final double? borderRadius;
  final double? btnHeight;
  final double? btnTextSize;
  final double? elevation;

  const CustomButton(
      {Key? key,
      required this.btnText,
      this.btnTextColor = CupertinoColors.systemBlue,
      required this.onTap,
      this.width,
      this.borderRadius = 10.0,
      this.btnHeight = 40.0,
      this.btnColor = Colors.amber,
      this.btnTextSize,
      this.borderColor = Colors.amber,
      this.elevation = 0.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        minimumSize:
            Size(width ?? MediaQuery.of(context).size.width, btnHeight!),
        primary: btnColor,
        elevation: elevation ?? 0.0,
        //shadowColor: AppColors.blackColor.withOpacity(0.25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
        ),
        side: BorderSide(
          color: borderColor!,
          width: 1.0,
        ),
      ),
      child: Center(
        child: Text(
          btnText!,
          style: poppinsMedium.copyWith(
            fontSize: btnTextSize ?? 18.0,
            color: btnTextColor,
          ),
        ),
      ),
    );
  }
}
