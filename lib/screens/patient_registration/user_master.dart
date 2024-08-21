import 'dart:io';
import 'dart:math';

import 'package:community_health_app/core/common_widgets/address_text_form_field.dart';
import 'package:community_health_app/core/common_widgets/app_bar.dart';
import 'package:community_health_app/core/common_widgets/app_bar_v1.dart';
import 'package:community_health_app/core/common_widgets/app_button.dart';
import 'package:community_health_app/core/common_widgets/app_round_textfield.dart';
import 'package:community_health_app/core/common_widgets/drop_down.dart';
import 'package:community_health_app/core/constants/constants.dart';
import 'package:community_health_app/core/constants/images.dart';
import 'package:community_health_app/core/routes/app_routes.dart';
import 'package:community_health_app/core/routes/app_routes.dart';
import 'package:community_health_app/core/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserMasterScreen extends StatefulWidget {
  const UserMasterScreen({super.key});

  @override
  State<UserMasterScreen> createState() => _UserMasterScreenState();
}

class _UserMasterScreenState extends State<UserMasterScreen> {
  XFile? capturedFile;

  late TextEditingController _stakeholderTypeTextController;
  late TextEditingController _stakeholderNameTextController;
  late TextEditingController _fullnameTextController;
  late TextEditingController _loginNameTextController;
  late TextEditingController _designationTypeTextController;
  late TextEditingController _emailIdTextController;
  late TextEditingController _passwordTextController;
  late TextEditingController _confirmPsswordTextController;
  bool _isObscure = true;

  void _toggleObscure() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _stakeholderTypeTextController = TextEditingController();
    _stakeholderNameTextController = TextEditingController();
    _fullnameTextController = TextEditingController();
    _loginNameTextController = TextEditingController();
    _designationTypeTextController = TextEditingController();
    _emailIdTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _confirmPsswordTextController = TextEditingController();
  }

  @override
  void dispose() {
    _stakeholderTypeTextController.dispose();
    _stakeholderNameTextController.dispose();
    _fullnameTextController.dispose();
    _loginNameTextController.dispose();
    _designationTypeTextController.dispose();
    _emailIdTextController.dispose();
    _passwordTextController.dispose();
    _confirmPsswordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        // appBar: mAppBar(
        //   scTitle: "User Master",
        //   leadingIcon: icBackArrowGreen,
        //   onLeadingIconClick: () {},
        // ),
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
              mAppBarV1(title: "User Master", context: context),
              SizedBox(
                height: responsiveHeight(10),
              ),
              Container(
                width: SizeConfig.screenWidth * 0.95,
                // height: SizeConfig.screenHeight * 0.7,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(responsiveHeight(25))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: responsiveHeight(30),
                      ),
                      AppRoundTextField(
                        controller: _stakeholderTypeTextController,
                        inputStyle: TextStyle(
                            fontSize: responsiveFont(14),
                            color: kTextBlackColor),
                        inputType: TextInputType.text,
                        onChange: (p0) {},
                        onTap: () {
                          stakeholderBottomSheet(context, (p0) => null);
                        },
                        maxLength: 12,
                        readOnly: true,
                        label: const Text(""),
                        hint: "Stakeholder Type *",
                        suffix: SizedBox(
                          height: responsiveHeight(20),
                          width: responsiveHeight(20),
                          child: Center(
                            child: Image.asset(
                              icArrowDownOrange,
                              height: responsiveHeight(20),
                              width: responsiveHeight(20),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: responsiveHeight(20),
                      ),
                      AppRoundTextField(
                        controller: _stakeholderNameTextController,
                        inputStyle: TextStyle(
                            fontSize: responsiveFont(14),
                            color: kTextBlackColor),
                        inputType: TextInputType.text,
                        onChange: (p0) {},
                        maxLength: 12,
                        readOnly: true,
                        label: const Text(""),
                        hint: "Stakeholder Name*",
                        suffix: SizedBox(
                          height: responsiveHeight(20),
                          width: responsiveHeight(20),
                          child: Center(
                            child: Image.asset(
                              icArrowDownOrange,
                              height: responsiveHeight(20),
                              width: responsiveHeight(20),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: responsiveHeight(20),
                      ),
                      AppRoundTextField(
                        controller: _fullnameTextController,
                        inputStyle: TextStyle(
                            fontSize: responsiveFont(14),
                            color: kTextBlackColor),
                        inputType: TextInputType.name,
                        onChange: (p0) {},
                        label: const Text(""),
                        hint: "Full Name*",
                      ),
                      SizedBox(
                        height: responsiveHeight(20),
                      ),
                      AppRoundTextField(
                        controller: _loginNameTextController,
                        inputStyle: TextStyle(
                            fontSize: responsiveFont(14),
                            color: kTextBlackColor),
                        inputType: TextInputType.name,
                        onChange: (p0) {},
                        label: const Text(""),
                        hint: "Login Name*",
                      ),
                      SizedBox(
                        height: responsiveHeight(20),
                      ),
                      AppRoundTextField(
                        controller: _designationTypeTextController,
                        inputStyle: TextStyle(
                            fontSize: responsiveFont(14),
                            color: kTextBlackColor),
                        inputType: TextInputType.text,
                        onChange: (p0) {},
                        readOnly: true,
                        label: const Text(""),
                        hint: "Designation/Member Type*",
                        suffix: SizedBox(
                          height: responsiveHeight(20),
                          width: responsiveHeight(20),
                          child: Center(
                            child: Image.asset(
                              icArrowDownOrange,
                              height: responsiveHeight(20),
                              width: responsiveHeight(20),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: responsiveHeight(20),
                      ),
                      AppRoundTextField(
                          label: const SizedBox.shrink(),
                          controller: _emailIdTextController,
                          inputType: TextInputType.emailAddress,
                          hint: "Email Id"),
                      SizedBox(
                        height: responsiveHeight(20),
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
                            height: responsiveHeight(20),
                            width: responsiveHeight(20),
                            child: Center(
                                child: _isObscure
                                    ? const Icon(
                                        Icons.visibility_outlined,
                                        color: kPrimaryColor,
                                      )
                                    : const Icon(
                                        Icons.visibility_off_outlined,
                                        color: kPrimaryColor,
                                      )),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: responsiveHeight(20),
                      ),
                      AppRoundTextField(
                        controller: _confirmPsswordTextController,
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
                            height: responsiveHeight(20),
                            width: responsiveHeight(20),
                            child: Center(
                                child: _isObscure
                                    ? const Icon(
                                        Icons.visibility_outlined,
                                        color: kPrimaryColor,
                                      )
                                    : const Icon(
                                        Icons.visibility_off_outlined,
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
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.stakeholderMasterScreen);
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
