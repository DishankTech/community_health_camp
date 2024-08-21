import 'dart:io';

import 'package:community_health_app/core/common_widgets/address_text_form_field.dart';
import 'package:community_health_app/core/common_widgets/app_bar.dart';
import 'package:community_health_app/core/common_widgets/app_button.dart';
import 'package:community_health_app/core/common_widgets/app_round_textfield.dart';
import 'package:community_health_app/core/constants/constants.dart';
import 'package:community_health_app/core/constants/images.dart';
import 'package:community_health_app/core/routes/app_routes.dart';
import 'package:community_health_app/core/utilities/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class PatientRegistrationScreen extends StatefulWidget {
  const PatientRegistrationScreen({super.key});

  @override
  State<PatientRegistrationScreen> createState() =>
      _PatientRegistrationScreenState();
}

class _PatientRegistrationScreenState extends State<PatientRegistrationScreen> {
  XFile? capturedFile;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: mAppBar(
          scTitle: "Patient Registration",
          leadingIcon: icBackArrowGreen,
          onLeadingIconClick: () {},
        ),
        body: Stack(children: [
          Image.asset(
            patRegBg,
            width: SizeConfig.screenWidth,
            fit: BoxFit.fill,
          ),
          SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: responsiveHeight(10),
                  ),
                  Container(
                    width: SizeConfig.screenWidth * 0.95,
                    // height: SizeConfig.screenHeight * 0.7,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(responsiveHeight(25))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: responsiveHeight(30),
                          ),
                          Stack(children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: kRegistrationBgColor,
                                  borderRadius: BorderRadius.circular(
                                      responsiveHeight(135) / 2)),
                              child: capturedFile == null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          responsiveHeight(135) / 2),
                                      child: Icon(
                                        Icons.person,
                                        size: responsiveHeight(135),
                                      ))
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          responsiveHeight(135) / 2),
                                      child: Image.file(
                                        File(capturedFile!.path),
                                        height: responsiveHeight(135),
                                        width: responsiveHeight(135),
                                      ),
                                    ),
                            ),
                            Positioned(
                              right: 0,
                              child: InkWell(
                                splashFactory: InkRipple.splashFactory,
                                borderRadius:
                                    BorderRadius.circular(responsiveHeight(17)),
                                onTap: () {},
                                child: Ink(
                                  child: Image.asset(
                                    icCameraGreen,
                                    height: responsiveHeight(34),
                                    width: responsiveHeight(34),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                          SizedBox(height: responsiveHeight(12)),
                          Text(
                            "Patient Name",
                            style: TextStyle(
                                fontSize: responsiveFont(14),
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: responsiveHeight(20),
                          ),
                          AppRoundTextField(
                            controller: TextEditingController(),
                            inputStyle: TextStyle(
                                fontSize: responsiveFont(14),
                                color: kTextBlackColor),
                            inputType: TextInputType.number,
                            onChange: (p0) {},
                            maxLength: 12,
                            label: const Text(""),
                            hint: "Camp ID *",
                          ),
                          SizedBox(
                            height: responsiveHeight(20),
                          ),
                          AppRoundTextField(
                            controller: TextEditingController(),
                            inputStyle: TextStyle(
                                fontSize: responsiveFont(14),
                                color: kTextBlackColor),
                            inputType: TextInputType.number,
                            onChange: (p0) {},
                            maxLength: 12,
                            label: const Text(""),
                            hint: "Camp Date *",
                            suffix: SizedBox(
                              height: getProportionateScreenHeight(20),
                              width: getProportionateScreenHeight(20),
                              child: Center(
                                child: Image.asset(
                                  icCalendar,
                                  height: getProportionateScreenHeight(20),
                                  width: getProportionateScreenHeight(20),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(20),
                          ),
                          AppRoundTextField(
                            controller: TextEditingController(),
                            inputStyle: TextStyle(
                                fontSize: responsiveFont(14),
                                color: kTextBlackColor),
                            inputType: TextInputType.number,
                            onChange: (p0) {},
                            maxLength: 12,
                            label: const Text(""),
                            hint: "Gender",
                            suffix: SizedBox(
                              height: getProportionateScreenHeight(20),
                              width: getProportionateScreenHeight(20),
                              child: Center(
                                child: Image.asset(
                                  icArrowDownOrange,
                                  height: getProportionateScreenHeight(20),
                                  width: getProportionateScreenHeight(20),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(20),
                          ),
                          Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: AppRoundTextField(
                                  controller: TextEditingController(),
                                  inputStyle: TextStyle(
                                      fontSize: responsiveFont(14),
                                      color: kTextBlackColor),
                                  inputType: TextInputType.number,
                                  onChange: (p0) {},
                                  maxLength: 12,
                                  label: const Text(""),
                                  hint: "+91",
                                  suffix: SizedBox(
                                    height: getProportionateScreenHeight(20),
                                    width: getProportionateScreenHeight(20),
                                    child: Center(
                                      child: Image.asset(
                                        icArrowDownOrange,
                                        height:
                                            getProportionateScreenHeight(20),
                                        width: getProportionateScreenHeight(20),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: responsiveHeight(10),
                              ),
                              Flexible(
                                flex: 3,
                                child: AppRoundTextField(
                                  controller: TextEditingController(),
                                  inputStyle: TextStyle(
                                      fontSize: responsiveFont(14),
                                      color: kTextBlackColor),
                                  inputType: TextInputType.number,
                                  onChange: (p0) {},
                                  maxLength: 12,
                                  label: const Text(""),
                                  hint: "Mobile No",
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(20),
                          ),
                          AppRoundTextField(
                            controller: TextEditingController(),
                            inputStyle: TextStyle(
                                fontSize: responsiveFont(14),
                                color: kTextBlackColor),
                            inputType: TextInputType.number,
                            onChange: (p0) {},
                            maxLength: 12,
                            label: const Text(""),
                            hint: "Aadhar Card",
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(20),
                          ),
                          AppRoundTextField(
                            controller: TextEditingController(),
                            inputStyle: TextStyle(
                                fontSize: responsiveFont(14),
                                color: kTextBlackColor),
                            inputType: TextInputType.number,
                            onChange: (p0) {},
                            maxLength: 12,
                            label: const Text(""),
                            hint: "ABHA ID",
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(20),
                          ),
                          AppAddressRoundTextField(
                            controller: TextEditingController(),
                            maxLines: 5,
                            errorText: null,
                            inputStyle: TextStyle(
                                fontSize: responsiveFont(14),
                                color: kTextBlackColor),
                            onChange: (p0) {},
                            label: const Text(""),
                            inputType: TextInputType.multiline,
                            hint: "Address",
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(20),
                          ),
                          Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: AppRoundTextField(
                                  controller: TextEditingController(),
                                  maxLength: 10,
                                  inputStyle: TextStyle(
                                      fontSize: responsiveFont(14),
                                      color: kTextBlackColor),
                                  inputType: TextInputType.phone,
                                  label: RichText(
                                    text: TextSpan(
                                      text: 'Pincode',
                                      style: TextStyle(
                                          color: kLabelTextColor,
                                          fontSize: responsiveFont(14)),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: '',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: responsiveFont(14)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  hint: "Pincode",
                                  onTap: () {},
                                ),
                              ),
                              SizedBox(
                                width: getProportionateScreenHeight(10),
                              ),
                              Flexible(
                                flex: 1,
                                child: AppRoundTextField(
                                    controller: TextEditingController(),
                                    textCapitalization: TextCapitalization.none,
                                    inputType: TextInputType.datetime,
                                    inputStyle: TextStyle(
                                        fontSize: responsiveFont(14),
                                        color: kTextBlackColor),
                                    readOnly: true,
                                    label: RichText(
                                      text: TextSpan(
                                        text: 'District',
                                        style: TextStyle(
                                            color: kLabelTextColor,
                                            fontSize: responsiveFont(14)),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: '',
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: responsiveFont(14)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    hint: "Dsitrict",
                                    onTap: () {},
                                    suffix: SizedBox(
                                      height: getProportionateScreenHeight(20),
                                      width: getProportionateScreenHeight(20),
                                      child: Center(
                                        child: Image.asset(
                                          icArrowDownOrange,
                                          height:
                                              getProportionateScreenHeight(20),
                                          width:
                                              getProportionateScreenHeight(20),
                                        ),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(20),
                          ),
                          Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: AppRoundTextField(
                                  controller: TextEditingController(),
                                  readOnly: true,
                                  maxLength: 10,
                                  inputStyle: TextStyle(
                                      fontSize: responsiveFont(14),
                                      color: kTextBlackColor),
                                  inputType: TextInputType.phone,
                                  label: RichText(
                                    text: TextSpan(
                                      text: 'Taluka',
                                      style: TextStyle(
                                          color: kLabelTextColor,
                                          fontSize: responsiveFont(14)),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: '',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: responsiveFont(14)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  hint: "Taluka",
                                  onTap: () {},
                                  suffix: SizedBox(
                                    height: getProportionateScreenHeight(20),
                                    width: getProportionateScreenHeight(20),
                                    child: Center(
                                      child: Image.asset(
                                        icArrowDownOrange,
                                        height:
                                            getProportionateScreenHeight(20),
                                        width: getProportionateScreenHeight(20),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: getProportionateScreenHeight(10),
                              ),
                              Flexible(
                                flex: 1,
                                child: AppRoundTextField(
                                    controller: TextEditingController(),
                                    textCapitalization: TextCapitalization.none,
                                    inputType: TextInputType.datetime,
                                    inputStyle: TextStyle(
                                        fontSize: responsiveFont(14),
                                        color: kTextBlackColor),
                                    readOnly: true,
                                    label: RichText(
                                      text: TextSpan(
                                        text: 'Taluka',
                                        style: TextStyle(
                                            color: kLabelTextColor,
                                            fontSize: responsiveFont(14)),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: '',
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: responsiveFont(14)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    hint: "City",
                                    onTap: () {},
                                    suffix: SizedBox(
                                      height: getProportionateScreenHeight(20),
                                      width: getProportionateScreenHeight(20),
                                      child: Center(
                                        child: Image.asset(
                                          icArrowDownOrange,
                                          height:
                                              getProportionateScreenHeight(20),
                                          width:
                                              getProportionateScreenHeight(20),
                                        ),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: responsiveHeight(30),
                          ),
                          AppButton(
                            title: "Register",
                            iconData: Icon(
                              Icons.arrow_forward,
                              color: kWhiteColor,
                              size: responsiveHeight(24),
                            ),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.userMasterScreen);
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]));
  }
}
