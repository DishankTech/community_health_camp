import 'package:community_health_app/core/common_widgets/app_bar.dart';
import 'package:community_health_app/core/common_widgets/app_bar_v1.dart';
import 'package:community_health_app/core/common_widgets/app_button.dart';
import 'package:community_health_app/core/common_widgets/app_round_textfield.dart';
import 'package:community_health_app/core/common_widgets/drop_down.dart';
import 'package:community_health_app/core/constants/constants.dart';
import 'package:community_health_app/core/constants/fonts.dart';
import 'package:community_health_app/core/constants/images.dart';
import 'package:community_health_app/core/routes/app_routes.dart';
import 'package:community_health_app/core/utilities/size_config.dart';
import 'package:community_health_app/screens/location_master/location_master_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class LocationMaster extends StatefulWidget {
  const LocationMaster({super.key});

  @override
  State<LocationMaster> createState() => _LocationMasterState();
}

class _LocationMasterState extends State<LocationMaster> {
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
        // appBar: mAppBar(
        //   scTitle: "Location Master",
        //   leadingIcon: icBackArrowGreen,
        //   onLeadingIconClick: () {
        //     Navigator.pop(context);
        //   },
        // ),
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
              mAppBarV1(title: "Location Master", context: context,onBackButtonPress: (){
                Get.to(() => const LocationMasterList());
              }),
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
                        height: responsiveHeight(20),
                      ),
                      AppRoundTextField(
                        controller: TextEditingController(),
                        inputType: TextInputType.number,
                        onChange: (p0) {},
                        label: RichText(
                          text: const TextSpan(
                              text: 'Location Name',
                              style: TextStyle(
                                  color: kHintColor, fontFamily: Montserrat),
                              children: [
                                TextSpan(
                                    text: "*",
                                    style: TextStyle(color: Colors.red))
                              ]),
                        ),
                        hint: "",
                      ),
                      SizedBox(
                        height: responsiveHeight(20),
                      ),
                      AppRoundTextField(
                        controller: TextEditingController(),
                        inputType: TextInputType.number,
                        onChange: (p0) {},
                        maxLength: 10,
                        label: RichText(
                          text: const TextSpan(
                              text: 'Contact No',
                              style: TextStyle(
                                  color: kHintColor, fontFamily: Montserrat),
                              children: []),
                        ),
                        hint: "",
                      ),
                      SizedBox(
                        height: responsiveHeight(30),
                      ),
                      AppRoundTextField(
                        controller: TextEditingController(),
                        inputType: TextInputType.number,
                        onChange: (p0) {},
                        label: RichText(
                          text: const TextSpan(
                              text: 'Contact Person Name',
                              style: TextStyle(
                                  color: kHintColor, fontFamily: Montserrat),
                              children: [
                                TextSpan(
                                    text: "*",
                                    style: TextStyle(color: Colors.red))
                              ]),
                        ),
                        hint: "",
                      ),
                      SizedBox(
                        height: responsiveHeight(30),
                      ),
                      AppRoundTextField(
                        controller: TextEditingController(),
                        inputType: TextInputType.number,
                        onChange: (p0) {},
                        label: RichText(
                          text: const TextSpan(
                              text: 'Eamil Id',
                              style: TextStyle(
                                  color: kHintColor, fontFamily: Montserrat),
                              children: []),
                        ),
                        hint: "",
                      ),
                      SizedBox(
                        height: responsiveHeight(30),
                      ),
                      AppRoundTextField(
                        controller: TextEditingController(),
                        inputType: TextInputType.number,
                        onChange: (p0) {},
                        label: RichText(
                          text: const TextSpan(
                              text: 'Address 1',
                              style: TextStyle(
                                  color: kHintColor, fontFamily: Montserrat),
                              children: []),
                        ),
                        hint: "",
                      ),
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
                        maxLength: 12,
                        label: RichText(
                          text: const TextSpan(
                              text: 'Address 2',
                              style: TextStyle(
                                  color: kHintColor, fontFamily: Montserrat),
                              children: []),
                        ),
                        hint: "",
                      ),
                      SizedBox(
                        height: responsiveHeight(30),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: AppRoundTextField(
                              controller: TextEditingController(),
                              inputType: TextInputType.number,
                              onChange: (p0) {},
                              onTap: () {
                                genderBottomSheet(context, (p0) => null);
                              },
                              readOnly: true,
                              label: RichText(
                                text: const TextSpan(
                                    text: 'Country',
                                    style: TextStyle(
                                        color: kHintColor,
                                        fontFamily: Montserrat),
                                    children: [
                                      TextSpan(
                                          text: "*",
                                          style: TextStyle(color: Colors.red))
                                    ]),
                              ),
                              hint: "",
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
                          ),
                          SizedBox(
                            width: responsiveWidth(10),
                          ),
                          Expanded(
                            child: AppRoundTextField(
                              controller: TextEditingController(),
                              inputType: TextInputType.number,
                              onChange: (p0) {},
                              onTap: () {
                                genderBottomSheet(context, (p0) => null);
                              },
                              readOnly: true,
                              label: RichText(
                                text: const TextSpan(
                                    text: 'State',
                                    style: TextStyle(
                                        color: kHintColor,
                                        fontFamily: Montserrat),
                                    children: [
                                      TextSpan(
                                          text: "*",
                                          style: TextStyle(color: Colors.red))
                                    ]),
                              ),
                              hint: "",
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
                          ),
                        ],
                      ),
                      SizedBox(
                        height: responsiveHeight(30),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: AppRoundTextField(
                              controller: TextEditingController(),
                              inputType: TextInputType.number,
                              onChange: (p0) {},
                              onTap: () {
                                genderBottomSheet(context, (p0) => null);
                              },
                              readOnly: true,
                              label: RichText(
                                text: const TextSpan(
                                    text: 'District',
                                    style: TextStyle(
                                        color: kHintColor,
                                        fontFamily: Montserrat),
                                    children: [
                                      TextSpan(
                                          text: "*",
                                          style: TextStyle(color: Colors.red))
                                    ]),
                              ),
                              hint: "",
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
                          ),
                          SizedBox(
                            width: responsiveWidth(10),
                          ),
                          Expanded(
                            child: AppRoundTextField(
                              controller: TextEditingController(),
                              inputType: TextInputType.number,
                              onChange: (p0) {},
                              onTap: () {
                                genderBottomSheet(context, (p0) => null);
                              },
                              readOnly: true,
                              label: RichText(
                                text: const TextSpan(
                                    text: 'Taluka',
                                    style: TextStyle(
                                        color: kHintColor,
                                        fontFamily: Montserrat),
                                    children: [
                                      TextSpan(
                                          text: "*",
                                          style: TextStyle(color: Colors.red))
                                    ]),
                              ),
                              hint: "",
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
                          ),
                        ],
                      ),
                      SizedBox(
                        height: responsiveHeight(30),
                      ),
                      AppRoundTextField(
                        controller: TextEditingController(),
                        inputType: TextInputType.number,
                        onChange: (p0) {},
                        onTap: () {
                          genderBottomSheet(context, (p0) => null);
                        },
                        readOnly: true,
                        label: RichText(
                          text: const TextSpan(
                              text: 'City',
                              style: TextStyle(
                                  color: kHintColor, fontFamily: Montserrat),
                              children: [
                                TextSpan(
                                    text: "*",
                                    style: TextStyle(color: Colors.red))
                              ]),
                        ),
                        hint: "",
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
  }
}
