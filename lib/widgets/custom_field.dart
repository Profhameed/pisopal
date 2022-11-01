import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inbestment/shared/app_text_styles.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final double? textSize;
  final double? hintTextSize;
  final Color? textColor;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final int? minLines;
  final int? maxLines;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;

  const CustomTextField(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.obscureText = false,
      this.keyboardType = TextInputType.text,
      this.textColor = Colors.black,
      this.textSize,
      this.hintTextSize,
      this.suffixIcon,
      this.onChanged,
      this.minLines = 1,
      this.maxLines = 1,
      this.validator,
      this.onSaved})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.center,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText!,
      onChanged: onChanged,
      minLines: minLines,
      maxLines: maxLines,
      validator: validator,
      onSaved: onSaved,
      cursorColor: CupertinoColors.systemBlue,
      style: poppinsRegular.copyWith(
        fontSize: 16.0,
        color: textColor,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: poppinsLight.copyWith(
          fontSize: 14.0,
          color: Colors.black,
        ),
        suffixIcon: suffixIcon ?? const SizedBox(),
        filled: true,
        fillColor: Colors.transparent,
        contentPadding: const EdgeInsets.only(left: 40.0, top: 12.0),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 0.7,
          ),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 0.7,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: CupertinoColors.systemBlue,
            width: 0.7,
          ),
        ),
      ),
    );
  }
}
