import 'package:community_health_app/core/common_widgets/app_bar_v1.dart';
import 'package:community_health_app/core/common_widgets/app_button.dart';
import 'package:community_health_app/core/common_widgets/app_round_textfield.dart';
import 'package:community_health_app/core/common_widgets/drop_down.dart';
import 'package:community_health_app/core/constants/constants.dart';
import 'package:community_health_app/core/constants/fonts.dart';
import 'package:community_health_app/core/constants/images.dart';
import 'package:community_health_app/core/utilities/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class CampCreation extends StatefulWidget {
  const CampCreation({super.key});

  @override
  State<CampCreation> createState() => _CampCreationState();
}

class _CampCreationState extends State<CampCreation> {
  XFile? capturedFile;
  List<CardData> carbonCommentsList = [];

  TextEditingController stakHolderController = TextEditingController();

  Map<String, dynamic>? selectedStak;

  TextEditingController locationNameController = TextEditingController();

  Map<String, dynamic>? selectedLocationName;

  TextEditingController campNameController = TextEditingController();

  Map<String, dynamic>? selectedCampName;

  TextEditingController userNameController = TextEditingController();

  TextEditingController loginNameController = TextEditingController();

  TextEditingController designationType = TextEditingController();

  Map<String, dynamic>? selectedDesignationType;

  TextEditingController countryCodeController = TextEditingController();

  Map<String, dynamic>? selectedCountryCode;

  TextEditingController mobileController = TextEditingController();

  Map<String, dynamic>? selectedMobile;

  @override
  void initState() {
    // TODO: implement initState
    carbonCommentsList.add(CardData(""));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Change to your desired color
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness:
          Brightness.light, // For light text/icons on the status bar
    ));
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image:
                DecorationImage(image: AssetImage(patRegBg), fit: BoxFit.fill)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              mAppBarV1(title: "Camp Creation", context: context, onBackButtonPress: (){
                Navigator.pop(context);
              },),
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
                          maxLength: 12,
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
                          height: responsiveHeight(10),
                        ),
                        AppRoundTextField(
                          controller: TextEditingController(),
                          inputType: TextInputType.number,
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
    );
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
                inputStyle: TextStyle(
                    fontSize: responsiveFont(14), color: kTextBlackColor),
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
                inputStyle: TextStyle(
                    fontSize: responsiveFont(14), color: kTextBlackColor),
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
                inputStyle: TextStyle(
                    fontSize: responsiveFont(14), color: kTextBlackColor),
                inputType: TextInputType.number,
                onChange: (p0) {},
                onTap: () {
                  List<Map<String, dynamic>> list = [
                    {"title": "Accountant", "id": 1},
                    {"title": "Admin", "id": 2},
                    {"title": "Scrutiny", "id": 2},
                  ];
                  commonBottonSheet(
                      context,
                      (p0) => {
                            setState(() {
                              selectedDesignationType = p0;
                              designationType.text =
                                  selectedDesignationType!['title'];
                            })
                          },
                      "Designation/Member Type",
                      list);
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
                      inputStyle: TextStyle(
                          fontSize: responsiveFont(14), color: kTextBlackColor),
                      inputType: TextInputType.number,
                      onChange: (p0) {},
                      onTap: () {
                        List<Map<String, dynamic>> list = [
                          {"title": "+91", "id": 1},
                          {"title": "+11", "id": 2},
                          {"title": "+43", "id": 2},
                        ];
                        commonBottonSheet(
                            context,
                            (p0) => {
                                  setState(() {
                                    selectedCountryCode = p0;
                                    countryCodeController.text =
                                        selectedCountryCode!['title'];
                                  })
                                },
                            "Country Code",
                            list);
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
                      controller: mobileController,
                      inputStyle: TextStyle(
                          fontSize: responsiveFont(14), color: kTextBlackColor),
                      inputType: TextInputType.number,
                      onChange: (p0) {},
                      onTap: () {
                        List<Map<String, dynamic>> list = [
                          {"title": "987547869", "id": 1},
                          {"title": "2456784653", "id": 2},
                          {"title": "8976543456", "id": 2},
                        ];
                        commonBottonSheet(
                            context,
                            (p0) => {
                                  setState(() {
                                    selectedMobile = p0;
                                    mobileController.text =
                                        selectedMobile!['title'];
                                  })
                                },
                            "Mobile no",
                            list);
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
