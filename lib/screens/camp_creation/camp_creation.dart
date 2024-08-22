import 'package:community_health_app/core/common_widgets/app_bar.dart';
import 'package:community_health_app/core/common_widgets/app_bar_v1.dart';
import 'package:community_health_app/core/common_widgets/app_button.dart';
import 'package:community_health_app/core/common_widgets/app_round_textfield.dart';
import 'package:community_health_app/core/common_widgets/drop_down.dart';
import 'package:community_health_app/core/constants/constants.dart';
import 'package:community_health_app/core/constants/fonts.dart';
import 'package:community_health_app/core/constants/images.dart';
import 'package:community_health_app/core/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CampCreation extends StatefulWidget {
  const CampCreation({super.key});

  @override
  State<CampCreation> createState() => _CampCreationState();
}

class _CampCreationState extends State<CampCreation> {
  XFile? capturedFile;
  List<CardData> carbonCommentsList = [];
  TextEditingController _passwordTextController = TextEditingController();
  bool _isObscure = false;

  @override
  void initState() {
    // TODO: implement initState
    carbonCommentsList.add(CardData(""));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
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
              mAppBarV1(title: "Camp Creation", context: context),
              SizedBox(
                height: responsiveHeight(40),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: SizeConfig.screenWidth * 3,
                  // height: SizeConfig.screenHeight / 3,

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(responsiveHeight(25)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Shadow color
                        spreadRadius: 2, // Spread radius
                        blurRadius: 7, // Blur radius
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 12),
                    child: Column(
                      children: [
                        AppRoundTextField(
                          controller: TextEditingController(),
                          inputType: TextInputType.number,
                          onChange: (p0) {},
                          onTap: () {
                            List<Map<String, dynamic>> list = [
                              {"title": "Hospital", "id": 1},
                              {"title": "NGO", "id": 2},
                              {"title": "STEM", "id": 3},
                              {"title": "USER", "id": 4}
                            ];
                            commonBottonSheet(context, (p0) => null,
                                "Stakeholder Type", list);
                          },
                          maxLength: 12,
                          readOnly: true,
                          label: RichText(
                            text: const TextSpan(
                                text: 'Stakeholder Type',
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
                          height: responsiveHeight(10),
                        ),
                        AppRoundTextField(
                          controller: TextEditingController(),
                          inputType: TextInputType.number,
                          onChange: (p0) {},
                          onTap: () {
                            List<Map<String, dynamic>> list = [
                              {"title": "Pune", "id": 1},
                              {"title": "Mumbai", "id": 2},
                              {"title": "Nagpur", "id": 2},
                            ];
                            commonBottonSheet(
                                context, (p0) => null, "Location name", list);
                          },
                          readOnly: true,
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
                          height: responsiveHeight(10),
                        ),
                        AppRoundTextField(
                          controller: TextEditingController(),
                          inputType: TextInputType.number,
                          onChange: (p0) {},
                          onTap: () {
                            List<Map<String, dynamic>> list = [
                              {"title": "Pune", "id": 1},
                              {"title": "Mumbai", "id": 2},
                              {"title": "Nagpur", "id": 2},
                            ];
                            commonBottonSheet(
                                context, (p0) => null, "Camp name", list);
                          },
                          readOnly: true,
                          label: RichText(
                            text: const TextSpan(
                                text: 'Camp Name',
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
                          height: responsiveHeight(10),
                        ),
                        AppRoundTextField(
                          controller: TextEditingController(),
                          inputType: TextInputType.number,
                          readOnly: true,
                          onChange: (p0) {},
                          label: RichText(
                            text: const TextSpan(
                                text: 'Proposed camp date & time',
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
                            height: responsiveHeight(20),
                            width: responsiveHeight(20),
                            child: Center(
                              child: Image.asset(
                                icCalendar,
                                height: responsiveHeight(20),
                                width: responsiveHeight(20),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: responsiveHeight(10),
              ),
              Column(
                children: carbonCommentsList.asMap().entries.map((entry) {
                  int index = entry.key;
                  CardData cardData = entry.value;
                  return campCard(index, cardData);
                }).toList(),
              ),
              SizedBox(
                height: responsiveHeight(30),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: AppButton(
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
                ),
              )
            ],
          ),
        ),
      ),
    ]));
  }

  Widget campCard(int index, CardData card) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: SizeConfig.screenWidth * 0.95,
        // height: SizeConfig.screenHeight /3,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(responsiveHeight(25)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Shadow color
              spreadRadius: 2, // Spread radius
              blurRadius: 7, // Blur radius
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
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
                      text: 'Username',
                      style:
                          TextStyle(color: kHintColor, fontFamily: Montserrat),
                      children: [
                        TextSpan(text: "*", style: TextStyle(color: Colors.red))
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
                label: RichText(
                  text: const TextSpan(
                      text: 'Login Name',
                      style:
                          TextStyle(color: kHintColor, fontFamily: Montserrat),
                      children: [
                        TextSpan(text: "*", style: TextStyle(color: Colors.red))
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
                onTap: () {
                  List<Map<String, dynamic>> list = [
                    {"title": "Accountant", "id": 1},
                    {"title": "Admin", "id": 2},
                    {"title": "Scrutiny", "id": 2},
                  ];
                  commonBottonSheet(
                      context, (p0) => null, "Designation/Member Type", list);
                },
                readOnly: true,
                label: RichText(
                  text: const TextSpan(
                      text: 'Designation/Member Type',
                      style:
                          TextStyle(color: kHintColor, fontFamily: Montserrat),
                      children: [
                        TextSpan(text: "*", style: TextStyle(color: Colors.red))
                      ]),
                ),
                hint: "",
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
                      maxLength: 12,
                      readOnly: true,
                      label: RichText(
                        text: const TextSpan(
                            text: 'Country Code',
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
                  ),
                  SizedBox(
                    width: responsiveWidth(10),
                  ),
                  Expanded(
                    child: AppRoundTextField(
                      controller: TextEditingController(),
                      inputStyle: TextStyle(
                          fontSize: responsiveFont(14), color: kTextBlackColor),
                      inputType: TextInputType.number,
                      onChange: (p0) {},
                      onTap: () {
                        genderBottomSheet(context, (p0) => null);
                      },
                      maxLength: 10,
                      label: RichText(
                        text: const TextSpan(
                            text: 'Mobile No',
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
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 12, right: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      child: Image.asset("assets/icons/add.png"),
                      onTap: () {
                        addCard();
                      },
                    ),
                    SizedBox(
                      width: responsiveWidth(10),
                    ),
                    InkWell(
                      child: Image.asset("assets/icons/remove.png"),
                      onTap: () {
                        removeCard(carbonCommentsList.length - 1);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void addCard() {
    carbonCommentsList.add(CardData(""));
    setState(() {});
  }

  void removeCard(int index) {
    if (carbonCommentsList.length > 1) {
      setState(() {
        carbonCommentsList.removeAt(index);
      });
    }
  }
}

class CardData {
  String? cardTitle;

  CardData(this.cardTitle);
}
