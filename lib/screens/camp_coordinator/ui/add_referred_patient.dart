import 'dart:convert';

import 'package:community_health_app/core/common_widgets/app_bar_v1.dart';
import 'package:community_health_app/core/common_widgets/app_button.dart';
import 'package:community_health_app/core/common_widgets/app_round_textfield.dart';
import 'package:community_health_app/core/common_widgets/drop_down.dart';
import 'package:community_health_app/core/constants/constants.dart';
import 'package:community_health_app/core/constants/fonts.dart';
import 'package:community_health_app/core/constants/images.dart';
import 'package:community_health_app/core/routes/app_routes.dart';
import 'package:community_health_app/core/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../models/camp_coordinator_registered_patient_model.dart';
import 'package:http/http.dart' as http;

class AddReferredPatient extends StatefulWidget {
  const AddReferredPatient({super.key});

  @override
  State<AddReferredPatient> createState() => _AddReferredPatientState();
}

class _AddReferredPatientState extends State<AddReferredPatient> {
  XFile? capturedFile;
  List<CardData> carbonCommentsList = [];

  TextEditingController patientNameController = TextEditingController();
  TextEditingController listpatientNameController = TextEditingController();

  TextEditingController referredTo = TextEditingController();
  TextEditingController referredToId = TextEditingController();

  Map<String, dynamic>? selectedDesignationType;

  TextEditingController countryCodeController = TextEditingController();

  Map<String, dynamic>? selectedCountryCode;

  TextEditingController mobileController = TextEditingController();

  Map<String, dynamic>? selectedMobile;

  List<CampCoordRegisteredPatientModel> campregisteredpatients = [];

  bool isLoading = false;

  List<Map<String, dynamic>> extractedStackholderData = [];

  @override
  void initState() {
    // TODO: implement initState
    patientNameController.text = "";
    countryCodeController.text = "";
    mobileController.text = "";
    referredTo.text = "";
    // carbonCommentsList.add(CardData(""));
    clearAllFields();
    getStakeholdersDetails();

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
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: isLoading
                      ? Container(
                          width: SizeConfig.designScreenWidth,
                          height: SizeConfig.screenHeight * 0.7,
                          color: Colors.black
                              .withOpacity(0.3), // Semi-transparent overlay
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(color: Colors.red),
                              SizedBox(height: 10),
                              Text(
                                'Please wait..',
                                style: TextStyle(
                                  color:
                                      Colors.white, // Text color for visibility
                                  fontFamily: Montserrat,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Column(
                          children: [
                            SizedBox(
                              height: responsiveHeight(20),
                            ),
                            AppRoundTextField(
                              controller: patientNameController,
                              inputStyle: TextStyle(
                                  fontSize: responsiveFont(14),
                                  color: kTextBlackColor),
                              inputType: TextInputType.name,
                              onChange: (p0) {},
                              label: RichText(
                                text: const TextSpan(
                                    text: 'Patient Name',
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
                            ),
                            SizedBox(
                              height: responsiveHeight(30),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: AppRoundTextField(
                                    controller: countryCodeController,
                                    inputStyle: TextStyle(
                                        fontSize: responsiveFont(14),
                                        color: kTextBlackColor),
                                    // inputType: TextInputType.number,
                                    onChange: (p0) {},
                                    onTap: () {
                                      List<Map<String, dynamic>> list = [
                                        {"title": "+91", "id": 1},
                                      ];
                                      commonBottonSheet(
                                          context,
                                          (p0) => {
                                                setState(() {
                                                  selectedCountryCode = p0;
                                                  countryCodeController.text =
                                                      selectedCountryCode![
                                                          'title'];
                                                })
                                              },
                                          "Country Code",
                                          list);
                                    },
                                    maxLength: 3,
                                    readOnly: true,
                                    label: RichText(
                                      text: const TextSpan(
                                          text: 'Country Code',
                                          style: TextStyle(
                                              color: kHintColor,
                                              fontFamily: Montserrat),
                                          children: [
                                            TextSpan(
                                                text: "*",
                                                style: TextStyle(
                                                    color: Colors.red))
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
                                        fontSize: responsiveFont(14),
                                        color: kTextBlackColor),
                                    inputType: TextInputType.number,
                                    onChange: (p0) {},
                                    maxLength: 10,
                                    label: RichText(
                                      text: const TextSpan(
                                          text: 'Mobile No',
                                          style: TextStyle(
                                              color: kHintColor,
                                              fontFamily: Montserrat),
                                          children: [
                                            TextSpan(
                                                text: "*",
                                                style: TextStyle(
                                                    color: Colors.red))
                                          ]),
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
                              inputStyle: TextStyle(
                                  fontSize: responsiveFont(14),
                                  color: kTextBlackColor),
                              onChange: (p0) {},
                              onTap: () {
                                List<Map<String, dynamic>> list = [
                                  {"title": "Hospital", "id": 1},
                                  {"title": "NGO", "id": 2},
                                  {"title": "STEM", "id": 3},
                                  {"title": "USER", "id": 4}
                                ];
                                commonStackholderSheet(
                                    context,
                                    (p0) => {
                                          setState(() {
                                            selectedDesignationType = p0;
                                            referredTo.text =
                                                selectedDesignationType![
                                                    'title'];
                                            referredToId.text =
                                                selectedDesignationType!['id']
                                                    .toString();
                                            print(referredToId.text);
                                          })
                                        },
                                    "Referred To",
                                    extractedStackholderData);
                              },
                              readOnly: true,
                              label: RichText(
                                text: const TextSpan(
                                    text: 'Referred To',
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
                              padding: const EdgeInsets.only(
                                  top: 12, bottom: 12, right: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    child: Image.asset("assets/icons/add.png"),
                                    onTap: () {
                                      if (patientNameController.text.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Enter Patient Name',
                                            ),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      } else if (countryCodeController
                                          .text.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Select Country Code',
                                            ),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      } else if (mobileController
                                          .text.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Enter Mobile Number',
                                            ),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      } else {
                                        addCard();
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    width: responsiveWidth(10),
                                  ),
                                  /*InkWell(
                                    child: Image.asset("assets/icons/remove.png"),
                                    onTap: () {
                                      removeCard(carbonCommentsList.length );
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
            Visibility(
              visible: campregisteredpatients.isNotEmpty ? true : false,
              child: Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: campregisteredpatients.length,
                    itemBuilder: (context, index) {
                      listpatientNameController.text =
                          campregisteredpatients[index].name;
                      return Container(
                        margin: const EdgeInsets.all(8),
                        width: SizeConfig.screenWidth * 0.95,
                        // height: SizeConfig.screenHeight /3,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(responsiveHeight(25)),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.grey.withOpacity(0.5), // Shadow color
                              spreadRadius: 2, // Spread radius
                              blurRadius: 7, // Blur radius
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: responsiveHeight(10),
                              ),
                              Container(
                                child: RichText(
                                  text: TextSpan(
                                    text: "Patient Name: ",
                                    style: TextStyle(
                                        color: kTextColor,
                                        fontSize: responsiveFont(14),
                                        fontWeight: FontWeight.bold),
                                    children: [
                                      TextSpan(
                                          text: campregisteredpatients[index]
                                              .name,
                                          style: TextStyle(
                                              fontSize: responsiveFont(14),
                                              color: kTextColor,
                                              fontWeight: FontWeight.normal))
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: responsiveHeight(10),
                              ),
                              Container(
                                child: RichText(
                                  text: TextSpan(
                                    text: "Mobile Number: ",
                                    style: TextStyle(
                                        color: kTextColor,
                                        fontSize: responsiveFont(14),
                                        fontWeight: FontWeight.bold),
                                    children: [
                                      TextSpan(
                                          text: campregisteredpatients[index]
                                              .mobile,
                                          style: TextStyle(
                                              fontSize: responsiveFont(14),
                                              color: kTextColor,
                                              fontWeight: FontWeight.normal))
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: responsiveHeight(10),
                              ),
                              Container(
                                child: RichText(
                                  text: TextSpan(
                                    text: "Referred To: ",
                                    style: TextStyle(
                                        color: kTextColor,
                                        fontSize: responsiveFont(14),
                                        fontWeight: FontWeight.bold),
                                    children: [
                                      TextSpan(
                                          text: campregisteredpatients[index]
                                              .referredTo,
                                          style: TextStyle(
                                              fontSize: responsiveFont(14),
                                              color: kTextColor,
                                              fontWeight: FontWeight.normal))
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5, bottom: 5, right: 12),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        child: Image.asset(
                                          "assets/icons/remove.png",
                                          color: Colors.red,
                                        ),
                                        onTap: () {
                                          // removeCard(carbonCommentsList.length - 1);
                                          removeCard(
                                              campregisteredpatients.length -
                                                  1);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
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
              height: responsiveHeight(10),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: AppButton(
                      onTap: () {
                        sendPostRequest();
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
                      onTap: () {
                        clearAllFields();
                      },
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
    );
  }

  void addCard() {
    // carbonCommentsList.add(CardData(""));
    setState(() {
      campregisteredpatients.add(CampCoordRegisteredPatientModel(
          mobile: mobileController.text.trim(),
          name: patientNameController.text.trim(),
          referredTo: referredTo.text,
          referredToId: referredToId.text));
      print(campregisteredpatients);
      patientNameController.text = "";
      countryCodeController.text = "";
      mobileController.text = "";
      referredTo.text = "";
    });
  }

  void removeCard(int index) {
    if (campregisteredpatients.isNotEmpty) {
      setState(() {
        campregisteredpatients.removeAt(index);
        print(campregisteredpatients);
        // carbonCommentsList.removeAt(index);
      });
    }
  }

  Future<List> getStakeholdersDetails() async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(
        'http://210.89.42.117:8085/api/administrator/masters/all-stake-holder-master-pagination');
    var headers = {'Content-Type': 'application/json'};
    try {
      // final response = await http.post(url);

      var body = json.encode({
        "total_pages": 20,
        "page": 1,
        "total_count": 10,
        "per_page": 10,
        "data": null
      });

      print(body);

      http.Response response =
          await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        Map<String, dynamic> decodedJson = jsonDecode(response.body);

        var detailsArray = decodedJson['details'];
        List<dynamic> dataArray = detailsArray['data'];

        setState(() {
          isLoading = false;
        });

        // Create a List of Maps to store the desired information
        extractedStackholderData = dataArray.map((item) {
          return {
            'stakeholder_master_id': item['stakeholder_master_id'],
            'stakeholder_sub_type2_en':
                item['stakeholder_sub_type2_en'].toString(),
          };
        }).toList();
        print(extractedStackholderData);
        return extractedStackholderData;
      } else {
        setState(() {
          isLoading = false;
        });
        throw Exception('Failed to load data: ${response.reasonPhrase}');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      throw Exception('Exception occurred: $e');
    }
  }

  Future<void> sendPostRequest() async {
    setState(() {
      isLoading = true;
    });

    for (int i = 0; i < campregisteredpatients.length; i++) {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = json.encode({
        "tt_camp_dashboard_ref_patients_list": [
          {
            "dashboard_ref_patients_id": null,
            "camp_dashboard_id": null,
            "patient_id": null,
            "patient_name": campregisteredpatients[i].name,
            "age": 0,
            "lookup_det_id_gender": null,
            "contact_number": campregisteredpatients[i].mobile,
            "org_id": 1,
            "status": 1,
            "tt_camp_dashboard_ref_patients_det_list": [
              {
                "dashboard_ref_patients_det_id": null,
                "dashboard_ref_patients_id": null,
                "lookup_det_hier_id_stakeholder_sub_type2": null,
                "stakeholder_master_id": int.parse(
                    campregisteredpatients[i].referredToId.toString()),
                "org_id": 1,
                "status": 1
              }
            ]
          }
        ]
      });
      print(body);
      var response = await http.post(
        Uri.parse(
            'http://210.89.42.117:8085/api/administrator/masters/add/dashboard-patient-ref-details'),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        print(response.body);
        final data = json.decode(response.body);
        if (data['status_code'] == 200) {
          setState(() {
            campregisteredpatients.removeAt(i);
          });
        }
      } else {
        print(
            'Request failed with status: ${response.statusCode}. ${response.reasonPhrase}');
      }
    }

    if (campregisteredpatients.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Patients Saved Successfully',
          ),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushNamed(context, AppRoutes.campCoordinator);
    }
  }

  void clearAllFields() {
    setState(() {
      campregisteredpatients.clear();
      patientNameController.text = "";
      countryCodeController.text = "";
      mobileController.text = "";
      referredTo.text = "";
      referredToId.text = "";
    });
  }
}

class CardData {
  String? cardTitle;

  CardData(this.cardTitle);
}
