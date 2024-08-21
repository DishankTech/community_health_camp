import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:community_health_app/core/constants/constants.dart';
import 'package:community_health_app/core/utilities/size_config.dart';

class AppAddressRoundTextField extends StatelessWidget {
  AppAddressRoundTextField(
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
      this.onChange});

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
  Function()? onTap;
  String? Function(String?)? validators;
  String? errorText;
  Function(String)? onChange;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
        // Align(
        //     alignment: FractionalOffset.centerLeft,
        //     child: Padding(
        //       padding: EdgeInsets.only(left: responsiveHeight(8)),
        //       child: label,
        //     )),
        // SizedBox(
        //   height: responsiveHeight(10),
        // ),
        SizedBox(
          height: errorText != null ? responsiveHeight(80) : null,
          child: TextFormField(
            readOnly: readOnly ?? false,
            controller: controller,
            keyboardType: inputType,
            style: inputStyle,
            onTap: onTap,
            obscureText: obscureText ?? false,
            textCapitalization: textCapitalization ?? TextCapitalization.none,
            textAlignVertical: TextAlignVertical.center,
            maxLines: maxLines ?? 1,
            maxLength: maxLength,
            minLines: maxLines ?? 1,
            validator: validators,
            onChanged: onChange,
            decoration: InputDecoration(
                errorText: errorText,
                errorStyle: TextStyle(
                    fontSize: responsiveFont(12), fontWeight: FontWeight.w400),
                counterText: "",
                constraints: (maxLines != null && maxLines! > 1)
                    ? null
                    : BoxConstraints(
                        maxHeight: getProportionateScreenHeight(40)),
                contentPadding: EdgeInsets.symmetric(
                    vertical: 0, horizontal: getProportionateScreenHeight(10)),
                fillColor: kWhiteColor,
                filled: true,
                hintText: hint,
                hintStyle: TextStyle(
                    fontSize: getProportionateScreenHeight(12),
                    color: const Color(0xFF999999)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(responsiveHeight(20)),
                  borderSide:
                      const BorderSide(color: Color(0xFFE1E1E1), width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(responsiveHeight(20)),
                  borderSide:
                      const BorderSide(color: Color(0xFFE1E1E1), width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(responsiveHeight(20)),
                  borderSide:
                      const BorderSide(color: Color(0xFFE1E1E1), width: 1),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(responsiveHeight(20)),
                  borderSide:
                      const BorderSide(color: Color(0xFFE1E1E1), width: 1),
                ),
                suffixIcon: suffix),
          ),
        )
      ],
    );
  }
}
