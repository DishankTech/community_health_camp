import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:community_health_app/core/utilities/size_config.dart';
import 'package:community_health_app/core/utilities/validators.dart';

class AppTextField extends StatelessWidget {
  AppTextField(
      {super.key,
      required this.controller,
      required this.label,
      this.suffixIcon,
      this.labelStyle,
      this.textInputType,
      this.maxLength,
      this.obscureText,
      this.validators,
      this.errorText,
      this.onChange});

  TextEditingController controller;
  String label;
  Widget? suffixIcon;
  TextStyle? labelStyle;
  TextInputType? textInputType;
  int? maxLength;
  bool? obscureText;
  String? Function(String?)? validators;
  String? errorText;
  Function(String)? onChange;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: textInputType,
      style: const TextStyle(color: Colors.white),
      maxLength: maxLength,
      cursorColor: Colors.white,
      obscureText: obscureText ?? false,
      validator: validators,
      onChanged: onChange,
      decoration: InputDecoration(
        errorStyle: TextStyle(
            fontSize: responsiveFont(12), fontWeight: FontWeight.w400),
        errorText: errorText,
        counterText: "",
        labelText: label,
        labelStyle: labelStyle,
        suffixIcon: suffixIcon,
        border: const UnderlineInputBorder(),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
