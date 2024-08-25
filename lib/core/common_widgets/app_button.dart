import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:community_health_app/core/constants/constants.dart';
import 'package:community_health_app/core/utilities/size_config.dart';

class AppButton extends StatelessWidget {
  String title = "";
  double? mWidth = null;
  double? mHeight = 50;
  Function()? onTap;
  TextStyle? textStyle;
  Widget? icon;
  Icon? iconData;
  Color? buttonColor;
  double? iconSize;
  double? borderRadius;
  bool? isEnabled;
  AppButton(
      {super.key,
      required this.title,
      this.mWidth,
      this.onTap,
      this.mHeight,
      this.textStyle,
      this.icon,
      this.buttonColor,
      this.iconSize,
      this.iconData,
      this.borderRadius,
      this.isEnabled});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: kWhiteColor.withOpacity(0.4),
        highlightColor: kSecondaryColor.withOpacity(0.4),
        splashFactory: InkRipple.splashFactory,
        onTap: onTap,
        child: Ink(
          height: mHeight ?? responsiveHeight(44),
          width: mWidth ?? SizeConfig.screenWidth * 0.8,
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(borderRadius ?? responsiveHeight(60)),
            border: buttonColor != null
                ? Border.all(color: buttonColor!, width: 1)
                : null,
            gradient: LinearGradient(
              begin: const Alignment(-0.5, 1),
              end: Alignment(1, 1),
              colors: [
                buttonColor ?? kPrimaryColor,
                buttonColor ?? kPrimaryDarkColor,
              ],
            ),
          ),
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: responsiveWidth(10),
              ),
              Padding(
                padding:
                    EdgeInsets.only(right: getProportionateScreenHeight(5)),
                child: Text(
                  title,
                  style: textStyle ??
                      TextStyle(
                          fontWeight: FontWeight.bold,
                          color: kWhiteColor,
                          fontSize: responsiveFont(14)),
                ),
              ),
              icon ?? const SizedBox.shrink(),
              Spacer(),
              iconData ?? const SizedBox.shrink(),
              SizedBox(
                width: responsiveWidth(10),
              )
            ],
          )),
        ),
      ),
    );
  }
}
