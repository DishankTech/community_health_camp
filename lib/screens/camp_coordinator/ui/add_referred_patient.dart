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

import '../models/camp_coordinator_registered_patient_model.dart';

class AddReferredPatient extends StatefulWidget {
  const AddReferredPatient({super.key});

  @override
  State<AddReferredPatient> createState() => _AddReferredPatientState();
}

class _AddReferredPatientState extends State<AddReferredPatient> {
  XFile? capturedFile;
  List<CardData> carbonCommentsList = [];

/*  TextEditingController stakHolderController = TextEditingController();

  Map<String, dynamic>? selectedStak;

  TextEditingController locationNameController = TextEditingController();

  Map<String, dynamic>? selectedLocationName;

  TextEditingController campNameController = TextEditingController();

  Map<String, dynamic>? selectedCampName;

  TextEditingController userNameController = TextEditingController();*/

  TextEditingController patientNameController = TextEditingController();

  TextEditingController referredTo = TextEditingController();

  Map<String, dynamic>? selectedDesignationType;

  TextEditingController countryCodeController = TextEditingController();

  Map<String, dynamic>? selectedCountryCode;

  TextEditingController mobileController = TextEditingController();

  Map<String, dynamic>? selectedMobile;

  List<CampCoordRegisteredPatientModel> campregisteredpatients = [];

  @override
  void initState() {
    // TODO: implement initState
    patientNameController.text = "";
    countryCodeController.text = "";
    mobileController.text = "";
    referredTo.text = "";
    // carbonCommentsList.add(CardData(""));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Change to your desired color
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light, // For light text/icons on the status bar
    ));
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(patRegBg), fit: BoxFit.fill)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              mAppBarV1(title: "Add Referred Patient", context: context),
              SizedBox(
                height: responsiveHeight(10),
              ),
              Padding(
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
                          controller: patientNameController,
                          inputStyle: TextStyle(fontSize: responsiveFont(14), color: kTextBlackColor),
                          inputType: TextInputType.name,
                          onChange: (p0) {},
                          label: RichText(
                            text:
                                const TextSpan(text: 'Patient Name', style: TextStyle(color: kHintColor, fontFamily: Montserrat), children: [TextSpan(text: "*", style: TextStyle(color: Colors.red))]),
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
                                controller: countryCodeController,
                                inputStyle: TextStyle(fontSize: responsiveFont(14), color: kTextBlackColor),
                                // inputType: TextInputType.number,
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
                                              countryCodeController.text = selectedCountryCode!['title'];
                                            })
                                          },
                                      "Country Code",
                                      list);
                                },
                                maxLength: 3,
                                readOnly: true,
                                label: RichText(
                                  text: const TextSpan(
                                      text: 'Country Code', style: TextStyle(color: kHintColor, fontFamily: Montserrat), children: [TextSpan(text: "*", style: TextStyle(color: Colors.red))]),
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
                                inputStyle: TextStyle(fontSize: responsiveFont(14), color: kTextBlackColor),
                                inputType: TextInputType.number,
                                onChange: (p0) {},
                                maxLength: 12,
                                label: RichText(
                                  text: const TextSpan(
                                      text: 'Mobile No', style: TextStyle(color: kHintColor, fontFamily: Montserrat), children: [TextSpan(text: "*", style: TextStyle(color: Colors.red))]),
                                ),
                                hint: "",
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: responsiveHeight(30),
                        ),
                        AppRoundTextField(
                          controller: referredTo,
                          inputStyle: TextStyle(fontSize: responsiveFont(14), color: kTextBlackColor),
                          onChange: (p0) {},
                          onTap: () {
                            List<Map<String, dynamic>> list = [
                              {"title": "Hospital", "id": 1},
                              {"title": "NGO", "id": 2},
                              {"title": "STEM", "id": 3},
                              {"title": "USER", "id": 4}
                            ];
                            commonBottonSheet(
                                context,
                                (p0) => {
                                      setState(() {
                                        selectedDesignationType = p0;
                                        referredTo.text = selectedDesignationType!['title'];
                                      })
                                    },
                                "Referred To",
                                list);
                          },
                          readOnly: true,
                          label: RichText(
                            text:
                                const TextSpan(text: 'Referred To', style: TextStyle(color: kHintColor, fontFamily: Montserrat), children: [TextSpan(text: "*", style: TextStyle(color: Colors.red))]),
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
                              /*InkWell(
                                child: Image.asset("assets/icons/remove.png"),
                                onTap: () {
                                  removeCard(carbonCommentsList.length - 1);
                                },
                              ),*/
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: campregisteredpatients.length,
                  itemBuilder: (context, index) {
                    patientNameController.text = campregisteredpatients[index].name;
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
                                controller: patientNameController,
                                inputStyle: TextStyle(fontSize: responsiveFont(14), color: kTextBlackColor),
                                inputType: TextInputType.name,
                                onChange: (p0) {},
                                label: RichText(
                                  text: const TextSpan(
                                      text: 'Patient Name', style: TextStyle(color: kHintColor, fontFamily: Montserrat), children: [TextSpan(text: "*", style: TextStyle(color: Colors.red))]),
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
                                      controller: countryCodeController,
                                      inputStyle: TextStyle(fontSize: responsiveFont(14), color: kTextBlackColor),
                                      // inputType: TextInputType.number,
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
                                                    countryCodeController.text = selectedCountryCode!['title'];
                                                  })
                                                },
                                            "Country Code",
                                            list);
                                      },
                                      maxLength: 3,
                                      readOnly: true,
                                      label: RichText(
                                        text: const TextSpan(
                                            text: 'Country Code', style: TextStyle(color: kHintColor, fontFamily: Montserrat), children: [TextSpan(text: "*", style: TextStyle(color: Colors.red))]),
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
                                      inputStyle: TextStyle(fontSize: responsiveFont(14), color: kTextBlackColor),
                                      inputType: TextInputType.number,
                                      onChange: (p0) {},
                                      maxLength: 12,
                                      label: RichText(
                                        text: const TextSpan(
                                            text: 'Mobile No', style: TextStyle(color: kHintColor, fontFamily: Montserrat), children: [TextSpan(text: "*", style: TextStyle(color: Colors.red))]),
                                      ),
                                      hint: "",
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: responsiveHeight(30),
                              ),
                              AppRoundTextField(
                                controller: referredTo,
                                inputStyle: TextStyle(fontSize: responsiveFont(14), color: kTextBlackColor),
                                onChange: (p0) {},
                                onTap: () {
                                  List<Map<String, dynamic>> list = [
                                    {"title": "Hospital", "id": 1},
                                    {"title": "NGO", "id": 2},
                                    {"title": "STEM", "id": 3},
                                    {"title": "USER", "id": 4}
                                  ];
                                  commonBottonSheet(
                                      context,
                                      (p0) => {
                                            setState(() {
                                              selectedDesignationType = p0;
                                              referredTo.text = selectedDesignationType!['title'];
                                            })
                                          },
                                      "Referred To",
                                      list);
                                },
                                readOnly: true,
                                label: RichText(
                                  text: const TextSpan(
                                      text: 'Referred To', style: TextStyle(color: kHintColor, fontFamily: Montserrat), children: [TextSpan(text: "*", style: TextStyle(color: Colors.red))]),
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
                              Padding(
                                padding: const EdgeInsets.only(top: 12, bottom: 12, right: 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Visibility(
                                      visible: index == 0 ? true : false,
                                      child: InkWell(
                                        child: Image.asset("assets/icons/add.png"),
                                        onTap: () {
                                          addCard();
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: responsiveWidth(10),
                                    ),
                                    Visibility(
                                      visible: index == 0 ? false : true,
                                      child: InkWell(
                                        child: Image.asset("assets/icons/remove.png"),
                                        onTap: () {
                                          removeCard(carbonCommentsList.length - 1);
                                        },
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
                  }),
              /*  Column(
                children: carbonCommentsList
                    .asMap()
                    .entries
                    .map((entry) {
                  int index = entry.key;
                  CardData cardData = entry.value;
                  return campCard(index, cardData);
                }).toList(),
              ),*/
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
                readOnly: index == 0 ? false : true,
                controller: patientNameController,
                inputStyle: TextStyle(fontSize: responsiveFont(14), color: kTextBlackColor),
                inputType: TextInputType.name,
                onChange: (p0) {},
                label: RichText(
                  text: const TextSpan(text: 'Patient Name', style: TextStyle(color: kHintColor, fontFamily: Montserrat), children: [TextSpan(text: "*", style: TextStyle(color: Colors.red))]),
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
                      controller: countryCodeController,
                      inputStyle: TextStyle(fontSize: responsiveFont(14), color: kTextBlackColor),
                      // inputType: TextInputType.number,
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
                                    countryCodeController.text = selectedCountryCode!['title'];
                                  })
                                },
                            "Country Code",
                            list);
                      },
                      maxLength: 3,
                      readOnly: true,
                      label: RichText(
                        text: const TextSpan(text: 'Country Code', style: TextStyle(color: kHintColor, fontFamily: Montserrat), children: [TextSpan(text: "*", style: TextStyle(color: Colors.red))]),
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
                      inputStyle: TextStyle(fontSize: responsiveFont(14), color: kTextBlackColor),
                      inputType: TextInputType.number,
                      onChange: (p0) {},
                      maxLength: 12,
                      label: RichText(
                        text: const TextSpan(text: 'Mobile No', style: TextStyle(color: kHintColor, fontFamily: Montserrat), children: [TextSpan(text: "*", style: TextStyle(color: Colors.red))]),
                      ),
                      hint: "",
                    ),
                  )
                ],
              ),
              SizedBox(
                height: responsiveHeight(30),
              ),
              AppRoundTextField(
                controller: referredTo,
                inputStyle: TextStyle(fontSize: responsiveFont(14), color: kTextBlackColor),
                onChange: (p0) {},
                onTap: () {
                  List<Map<String, dynamic>> list = [
                    {"title": "Hospital", "id": 1},
                    {"title": "NGO", "id": 2},
                    {"title": "STEM", "id": 3},
                    {"title": "USER", "id": 4}
                  ];
                  commonBottonSheet(
                      context,
                      (p0) => {
                            setState(() {
                              selectedDesignationType = p0;
                              referredTo.text = selectedDesignationType!['title'];
                            })
                          },
                      "Referred To",
                      list);
                },
                readOnly: true,
                label: RichText(
                  text: const TextSpan(text: 'Referred To', style: TextStyle(color: kHintColor, fontFamily: Montserrat), children: [TextSpan(text: "*", style: TextStyle(color: Colors.red))]),
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
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 12, right: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Visibility(
                      visible: index == 0 ? true : false,
                      child: InkWell(
                        child: Image.asset("assets/icons/add.png"),
                        onTap: () {
                          addCard();
                        },
                      ),
                    ),
                    SizedBox(
                      width: responsiveWidth(10),
                    ),
                    Visibility(
                      visible: index == 0 ? false : true,
                      child: InkWell(
                        child: Image.asset("assets/icons/remove.png"),
                        onTap: () {
                          removeCard(carbonCommentsList.length - 1);
                        },
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

  void addCard() {
    /*patientNameController.text = "";
    countryCodeController.text = "";
    mobileController.text = "";
    referredTo.text = "";*/

    // carbonCommentsList.add(CardData(""));
    setState(() {
      campregisteredpatients
          .add(CampCoordRegisteredPatientModel(mobile: countryCodeController.text + mobileController.text.trim(), name: patientNameController.text.trim(), referredTo: referredTo.text));
    });
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
