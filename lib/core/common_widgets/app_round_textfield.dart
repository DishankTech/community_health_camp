import 'package:community_health_app/core/utilities/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:community_health_app/core/constants/constants.dart';
import 'package:community_health_app/core/utilities/size_config.dart';

class AppRoundTextField extends StatelessWidget {
  AppRoundTextField(
      {super.key,
      required this.label,
      required this.controller,
      required this.hint,
      this.suffix,
      this.readOnly,
      this.bgColor,
      this.inputType,
      this.inputStyle,
      this.maxLength,
      this.textCapitalization,
      this.obscureText,
      this.maxLines,
      this.onTap,
      this.validators,
      this.errorText,
      this.onChange,
      this.isFloatingLabelEnable,
      this.borderRaius,
      this.inputFormatter});

  Widget label;
  TextEditingController controller;
  Widget? suffix;
  String hint;
  bool? readOnly;
  Color? bgColor;
  TextInputType? inputType;
  TextStyle? inputStyle;
  int? maxLength;
  TextCapitalization? textCapitalization;
  bool? obscureText;
  int? maxLines;
  bool? isFloatingLabelEnable;
  Function()? onTap;
  String? Function(String?)? validators;
  String? errorText;
  Function(String)? onChange;
  double? borderRaius;
  TextInputFormatter? inputFormatter;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: kTextFieldBorder, width: 1),
              borderRadius:
                  BorderRadius.circular(borderRaius ?? responsiveHeight(60))),
          child: Padding(
            padding: EdgeInsets.all(responsiveHeight(2)),
            child: TextFormField(
              readOnly: readOnly ?? false,
              controller: controller,
              keyboardType: inputType,
              style: inputStyle ??
                  TextStyle(
                      fontSize: responsiveFont(14),
                      fontWeight: FontWeight.w500,
                      color: kBlackColor),
              onTap: onTap,
              obscureText: obscureText ?? false,
              textCapitalization: textCapitalization ?? TextCapitalization.none,
              textAlignVertical: TextAlignVertical.top,
              maxLines: maxLines ?? 1,
              maxLength: maxLength,
              minLines: maxLines ?? 1,
              onChanged: onChange,
              validator: validators,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  errorText: null,
                  error: null,
                  errorStyle: const TextStyle(fontSize: 0.1),
                  label: label,
                  counterText: "",
                  constraints: (maxLines != null && maxLines! > 1)
                      ? null
                      : BoxConstraints(maxHeight: responsiveHeight(50)),
                  floatingLabelStyle: TextStyle(
                    fontSize: controller.text.isNotEmpty
                        ? responsiveFont(16)
                        : responsiveFont(14),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: responsiveHeight(9),
                      horizontal: responsiveHeight(20)),
                  fillColor: kWhiteColor,
                  filled: false,
                  hintText: hint,
                  hintStyle: TextStyle(
                      fontSize: responsiveFont(12), color: kHintColor),
                  suffixIcon: suffix),
            ),
          ),
        ),
        errorText != null
            ? Align(
                alignment: FractionalOffset.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: responsiveHeight(20), top: responsiveHeight(3)),
                  child: Text(
                    errorText!,
                    style: TextStyle(
                        fontSize: responsiveFont(12),
                        fontWeight: FontWeight.w400,
                        color: Colors.red),
                    textAlign: TextAlign.left,
                  ),
                ),
              )
            : const SizedBox.shrink()
      ],
    );
  }
}
