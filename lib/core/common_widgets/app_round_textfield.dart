import 'package:community_health_app/core/constants/constants.dart';
import 'package:community_health_app/core/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppRoundTextField extends StatelessWidget {
  AppRoundTextField(
      {super.key,
      required this.label,
      this.controller,
      required this.hint,
      this.initialValue,
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
      this.borderRadius,
      this.inputFormatter,
      this.width,
      this.height});

  final String? initialValue;
  final Widget label;
  final TextEditingController? controller;
  final Widget? suffix;
  final String hint;
  final bool? readOnly;
  final Color? bgColor;
  final TextInputType? inputType;
  final TextStyle? inputStyle;
  final int? maxLength;
  final TextCapitalization? textCapitalization;
  final bool? obscureText;
  final int? maxLines;
  final bool? isFloatingLabelEnable;
  final Function()? onTap;
  final String? Function(String?)? validators;
  final String? errorText;
  final Function(String)? onChange;
  final double? borderRadius;
  final TextInputFormatter? inputFormatter;
  double? height;
  double? width;

  @override
  Widget build(BuildContext context) {
    // SizeConfig().init(context);
    return Column(
      children: [
        Container(
          width: width ?? double.infinity,
          height: height,
          decoration: BoxDecoration(
              border: Border.all(color: kTextFieldBorder, width: 1),
              borderRadius:
                  BorderRadius.circular(borderRadius ?? responsiveHeight(60))),
          child: Padding(
            padding: EdgeInsets.all(responsiveHeight(2)),
            child: TextFormField(
              key: key,
              initialValue: initialValue,
              readOnly: readOnly ?? false,
              controller: controller,
              inputFormatters:
                  inputFormatter != null ? [inputFormatter!] : null,
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
              onChanged: (value) {
                if (onChange != null) onChange!(value);
              },
              validator: validators,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  errorText: null,
                  error: null,
                  errorStyle: const TextStyle(fontSize: 0.1),
                  label: label,
                  counterText: "",
                  floatingLabelStyle: TextStyle(
                    fontSize:
                        (controller?.text ?? (initialValue ?? '')).isNotEmpty
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
