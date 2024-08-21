import 'dart:io';
import 'dart:math';

import 'package:community_health_app/core/common_widgets/address_text_form_field.dart';
import 'package:community_health_app/core/common_widgets/app_bar.dart';
import 'package:community_health_app/core/common_widgets/app_button.dart';
import 'package:community_health_app/core/common_widgets/app_round_textfield.dart';
import 'package:community_health_app/core/common_widgets/drop_down.dart';
import 'package:community_health_app/core/constants/constants.dart';
import 'package:community_health_app/core/constants/images.dart';
import 'package:community_health_app/core/routes/app_routes.dart';
import 'package:community_health_app/core/utilities/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class UserMasterScreen extends StatefulWidget {
  const UserMasterScreen({super.key});

  @override
  State<UserMasterScreen> createState() => _UserMasterScreenState();
}

class _UserMasterScreenState extends State<UserMasterScreen> {
  XFile? capturedFile;

  TextEditingController _passwordTextController = TextEditingController();
  bool _isObscure = false;

  void _toggleObscure() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: mAppBar(
          scTitle: "User Master",
          leadingIcon: icBackArrowGreen,
          onLeadingIconClick: () {
            Navigator.pop(context);
          },
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
                          AppRoundTextField(
                            controller: TextEditingController(),
                            inputStyle: TextStyle(
                                fontSize: responsiveFont(14),
                                color: kTextBlackColor),
                            inputType: TextInputType.number,
                            onChange: (p0) {},
                            onTap: () {
                              genderBottomSheet(context, (p0) => null);
                            },
                            maxLength: 12,
                            readOnly: true,
                            label: const Text(""),
                            hint: "Stakeholder Type *",
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
                            readOnly: true,
                            label: const Text(""),
                            hint: "Stakeholder Name*",
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
                            hint: "Full Name*",
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
                            hint: "Login Name*",
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
                            readOnly: true,
                            label: const Text(""),
                            hint: "Designation/Member Type*",
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
                          AppRoundTextField(
                              label: const SizedBox.shrink(),
                              controller: TextEditingController(),
                              hint: "Email Id"),
                          SizedBox(
                            height: getProportionateScreenHeight(20),
                          ),
                          AppRoundTextField(
                            controller: _passwordTextController,
                            textCapitalization: TextCapitalization.none,
                            obscureText: _isObscure,
                            inputStyle: TextStyle(
                                fontSize: responsiveFont(14),
                                color: kTextBlackColor),
                            label: RichText(
                              text: TextSpan(
                                text: 'Password',
                                style: TextStyle(
                                    color: kLabelTextColor,
                                    fontSize: responsiveFont(14)),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: ' *',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: responsiveFont(14)),
                                  ),
                                ],
                              ),
                            ),
                            hint: "Password*",
                            suffix: GestureDetector(
                              onTap: () {
                                _toggleObscure();
                              },
                              child: SizedBox(
                                height: getProportionateScreenHeight(20),
                                width: getProportionateScreenHeight(20),
                                child: Center(
                                    child: _isObscure
                                        ? const Icon(
                                            Icons.visibility_off_outlined,
                                            color: kPrimaryColor,
                                          )
                                        : const Icon(
                                            Icons.visibility_outlined,
                                            color: kPrimaryColor,
                                          )),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(20),
                          ),
                          AppRoundTextField(
                            controller: _passwordTextController,
                            textCapitalization: TextCapitalization.none,
                            obscureText: _isObscure,
                            inputStyle: TextStyle(
                                fontSize: responsiveFont(14),
                                color: kTextBlackColor),
                            label: RichText(
                              text: TextSpan(
                                text: 'Password',
                                style: TextStyle(
                                    color: kLabelTextColor,
                                    fontSize: responsiveFont(14)),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: ' *',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: responsiveFont(14)),
                                  ),
                                ],
                              ),
                            ),
                            hint: "Confirm Password*",
                            suffix: GestureDetector(
                              onTap: () {
                                _toggleObscure();
                              },
                              child: SizedBox(
                                height: getProportionateScreenHeight(20),
                                width: getProportionateScreenHeight(20),
                                child: Center(
                                    child: _isObscure
                                        ? const Icon(
                                            Icons.visibility_off_outlined,
                                            color: kPrimaryColor,
                                          )
                                        : const Icon(
                                            Icons.visibility_outlined,
                                            color: kPrimaryColor,
                                          )),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: responsiveHeight(30),
                          ),
                          Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: AppButton(
                                  onTap: (){
                                    Navigator.pushNamed(
                                        context, AppRoutes.locationMaster);
                                  },
                                  title: "Save",
                                  iconData: Icon(
                                    Icons.arrow_forward,
                                    color: kWhiteColor,
                                    size: responsiveHeight(24),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: responsiveWidth(60),
                              ),
                              Flexible(
                                flex: 1,
                                child: AppButton(
                                  title: "Clear",
                                  buttonColor: Colors.grey,
                                  iconData: Icon(
                                    Icons.arrow_forward,
                                    color: kWhiteColor,
                                    size: responsiveHeight(24),
                                  ),
                                ),
                              ),
                            ],
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
