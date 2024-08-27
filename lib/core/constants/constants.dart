import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFF27A0C);
const kPrimaryDarkColor = Color(0xFF429EBD);
Color kPrimaryLightColor = kPrimaryColor.withOpacity(0.5);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF27A9E3), Color(0xFF07B259)],
);
LinearGradient kGradientHomeMenu = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFF27A9E3).withOpacity(0.1),
    Color(0xFF07B259).withOpacity(0.1)
  ],
);
const kScaffoldColor = Color(0xFFFFFFFF);
const kSecondaryColor = Color(0xFF979797);
const kSecondaryVarientColor = Color(0xFFFFFFFF);
const kTextOutlineColor = Color(0xFFC7C4C4);
const kTextColor = Color(0xFF484848);
const kListTitleTextColor = Color(0xFF3D3D3D);
const kTextBlackColor = Color(0xFF000000);
const kBlackColor = Color(0xFF000000);
const kTextOpacityColor = Color(0xB3E4E4E4);
const kTextDarkBlueColor = Color(0xFF2C3F6E);
const kWhiteColor = Color(0xFFFFFFFF);
const offWhite = Color(0xFFB1B1B1);
//profile
const kActiveBtnColor = Color(0xFF700033);
const kInActiveBtnColor = Color(0xFF970045);
const kActiveBtnBorderColor = Color(0xFFED006C);
const googleButtonColor = Color(0xFFDF4B38);
const appleButtonColor = Color(0xFF232323);
const segmentButtonBorderColor = Color(0xFFB1B1B1);
const kAnimationDuration = Duration(milliseconds: 200);
const kWhatsappColor = Color(0xFF25D366);
const kTelegramColor = Color(0xFF0088cc);
const kFBColor = Color(0xFF1877F2);
const kInstaColor = Color(0xFFcd486b);
const kTextFieldBorder = Color(0xFFE1E1E1);
const kRegistrationBgColor = Color(0xFFF8F8F8);
const kLabelTextColor = Color(0xFF515151);
const kListBGColor = Color(0xFFF5F5F5);
const kContainerBack = Color(0xFFF5F5F5);
const kHintColor = Color(0xFF666666);
const kTodayColor = Color(0XFFF27A0C);
const dashboardSubTitle = Color(0XFF666666);
const noInternetTextColor = Color(0XFF333333);
const dasboardCardTitleColor = Color(0XFF1D6582);
const totlPaitentRegisterdPieChartColor = Color(0XFF5597DF);
const totlPaitentTreatementPieChartColor = Color(0XFFE5897F);
const totlPaitentReferredPieChartColor = Color(0XFFF7DF6F);
const totlPaitentSubReferredPieChartColor = Color(0XFF7077AA);
const campConductedDistrictWiseBarChartcolor = Color(0XFF00008B);
// final headingStyle = TextStyle(
//   fontSize: getProportionateScreenWidth(28),
//   fontWeight: FontWeight.bold,
//   color: Colors.black,
//   height: 1.5,
// );

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

/// API's */
const String kGoogleMapAutocomplete =
    "https://maps.googleapis.com/maps/api/place/autocomplete/json";
