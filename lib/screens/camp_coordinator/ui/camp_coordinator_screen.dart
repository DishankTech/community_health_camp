import 'dart:convert';

import 'package:community_health_app/core/common_widgets/app_bar_v1.dart';
import 'package:community_health_app/core/common_widgets/app_button.dart';
import 'package:community_health_app/core/common_widgets/app_round_textfield.dart';
import 'package:community_health_app/core/common_widgets/drop_down.dart';
import 'package:community_health_app/core/constants/constants.dart';
import 'package:community_health_app/core/constants/fonts.dart';
import 'package:community_health_app/core/constants/images.dart';
import 'package:community_health_app/core/routes/app_routes.dart';
import 'package:community_health_app/core/utilities/data_provider.dart';
import 'package:community_health_app/core/utilities/size_config.dart';
import 'package:community_health_app/screens/camp_coordinator/ui/add_referred_patient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as picker;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/camp_coordinator_registered_patient_model.dart';

class CampCoordinator extends StatefulWidget {
  const CampCoordinator({super.key});

  @override
  State<CampCoordinator> createState() => _CampCoordinatorState();
}

class _CampCoordinatorState extends State<CampCoordinator> {
  XFile? capturedFile;
  List<CardData> carbonCommentsList = [];

  TextEditingController stakHolderController = TextEditingController();

  Map<String, dynamic>? selectedStak;

  TextEditingController locationNameController = TextEditingController();
  TextEditingController locationNameIDController = TextEditingController();

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
  TextEditingController patientsRegistered = TextEditingController();
  TextEditingController patientsTreated = TextEditingController();
  TextEditingController patientsReferred = TextEditingController();
  TextEditingController campStartDateTime = TextEditingController();
  TextEditingController campStartDateTimeId = TextEditingController();
  TextEditingController campCloseDateTime = TextEditingController();
  TextEditingController campCloseDateTimeUTC = TextEditingController();

  Map<String, dynamic>? selectedMobile;

  late Future<DateTime?> selectedDate;
  String date = "-";

  late Future<TimeOfDay?> selectedTime;
  String time = "-";
  late Future<void> _fetchData;

  // List<String> locationList;

  List<Map<String, dynamic>> locationData = [];
  List<Map<String, dynamic>> campStartDateTimeList = [];
  late Future<List<Map<String, dynamic>>> _locationData;

  late DateTime selectedDateTime;

  bool pressed = false;

  bool isLoadingLocation = false;
  bool isSaveLoad = false;

  // bool isLoading=false;

  @override
  void initState() {
    // TODO: implement initState
    carbonCommentsList.add(CardData(""));

    // _fetchData =
    loadInit();

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
        width: SizeConfig.designScreenWidth,
        height: SizeConfig.designScreenHeight,
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(patRegBg), fit: BoxFit.fill)),
        child: SingleChildScrollView(
            child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                mAppBarV1(
                    title: "Camp Details",
                    context: context,
                    onBackButtonPress: () {
                      Navigator.pushNamedAndRemoveUntil(context, "/dashboard_view", (Route<dynamic> route) => false);
                    }),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    isLoadingLocation
                        ? Center(child: CircularProgressIndicator())
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8.0),
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
                                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      AppRoundTextField(
                                        controller: locationNameController,
                                        onChange: (p0) {},
                                        onTap: () {
                                          commonLocationSheet(
                                              context,
                                              (p0) => {
                                                    setState(() {
                                                      selectedLocationName = p0;
                                                      print(selectedLocationName);
                                                      locationNameController.text = selectedLocationName!['title'];
                                                      locationNameIDController.text = selectedLocationName!['id'].toString();
                                                      campStartDateTime.text = "Fetching Data,please wait";
                                                      fetchCampDateList();
                                                    })
                                                  },
                                              "Locations Available",
                                              locationData);

                                          /*    showLocationBottomSheet(
                                  context,_locationData);*/
                                        },
                                        maxLength: 12,
                                        readOnly: true,
                                        label: RichText(
                                          text: const TextSpan(
                                              text: 'Location Name', style: TextStyle(color: kHintColor, fontFamily: Montserrat), children: [TextSpan(text: "*", style: TextStyle(color: Colors.red))]),
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
                                        inputType: TextInputType.none,
                                        controller: campStartDateTime,
                                        onTap: () {
                                          /*   picker.DatePicker.showDateTimePicker(context,
                                  showTitleActions: true, onChanged: (date) {
                                    print('change $date in time zone ' +
                                        date.timeZoneOffset.inHours.toString());
                                  }, onConfirm: (date) {
                                    print('confirm $date');
                                    campStartDateTime.text = '$date';
                                     fetchCampDateList();
                                  }, currentTime: DateTime.now());*/

                                          commonDateTimeSheet(
                                              context,
                                              (p0) => {
                                                    setState(() {
                                                      selectedLocationName = p0;
                                                      print(selectedLocationName);
                                                      campStartDateTime.text = selectedLocationName!['title'];
                                                      campStartDateTimeId.text = selectedLocationName!['id'].toString();
                                                    })
                                                  },
                                              "Camp Timings Available :",
                                              campStartDateTimeList);
                                        },
                                        onChange: (p0) {},
                                        label: RichText(
                                          text: const TextSpan(
                                              text: 'Camp Start date & time',
                                              style: TextStyle(color: kHintColor, fontFamily: Montserrat),
                                              children: [TextSpan(text: "*", style: TextStyle(color: Colors.red))]),
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
                                        controller: campCloseDateTime,
                                        inputType: TextInputType.none,
                                        onTap: () {
                                          picker.DatePicker.showDateTimePicker(context, showTitleActions: true, onChanged: (date) {
                                            print('change $date in time zone ' + date.timeZoneOffset.inHours.toString());
                                          }, onConfirm: (date) {
                                            print('confirm $date');
                                            campCloseDateTime.text = '$date';

                                            String localTimeString = campCloseDateTime.text;
                                            DateTime localTime = DateTime.parse(localTimeString);

                                            // Assuming the local time is in GMT+5:30 (Indian Standard Time)
                                            Duration offset = Duration(hours: 5, minutes: 30);

                                            // Convert local time to UTC
                                            DateTime utcTime = localTime.toUtc().subtract(offset);

                                            // Format to get only the time
                                            String timeOnly = DateFormat.Hms().format(utcTime);

                                            // Print the time
                                            print(timeOnly); // Output: 15:00:00
                                            campCloseDateTimeUTC.text = timeOnly;
                                          }, currentTime: DateTime.now());
                                        },
                                        onChange: (p0) {},
                                        label: RichText(
                                          text: const TextSpan(
                                              text: 'Camp Close date & time',
                                              style: TextStyle(color: kHintColor, fontFamily: Montserrat),
                                              children: [TextSpan(text: "*", style: TextStyle(color: Colors.red))]),
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
                                      ),
                                      SizedBox(
                                        height: responsiveHeight(10),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "How many patients registered today ?",
                                          style: TextStyle(fontFamily: Montserrat),
                                        ),
                                      ),
                                      SizedBox(
                                        height: responsiveHeight(2),
                                      ),
                                      AppRoundTextField(
                                        controller: patientsRegistered,
                                        inputStyle: TextStyle(fontSize: responsiveFont(14), color: kTextBlackColor),
                                        inputType: TextInputType.number,
                                        onChange: (p0) {},
                                        label: RichText(
                                          text: const TextSpan(
                                              text: 'Enter Count', style: TextStyle(color: kHintColor, fontFamily: Montserrat), children: [TextSpan(text: "*", style: TextStyle(color: Colors.red))]),
                                        ),
                                        hint: "",
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "How many patients treated Today ?",
                                          style: TextStyle(fontFamily: Montserrat),
                                        ),
                                      ),
                                      AppRoundTextField(
                                        controller: patientsTreated,
                                        inputStyle: TextStyle(fontSize: responsiveFont(14), color: kTextBlackColor),
                                        inputType: TextInputType.number,
                                        onChange: (p0) {},
                                        label: RichText(
                                          text: const TextSpan(
                                              text: 'Enter Count', style: TextStyle(color: kHintColor, fontFamily: Montserrat), children: [TextSpan(text: "*", style: TextStyle(color: Colors.red))]),
                                        ),
                                        hint: "",
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "How many patients referred Today ?",
                                          style: TextStyle(fontFamily: Montserrat),
                                        ),
                                      ),
                                      AppRoundTextField(
                                        controller: patientsReferred,
                                        inputStyle: TextStyle(fontSize: responsiveFont(14), color: kTextBlackColor),
                                        inputType: TextInputType.number,
                                        onChange: (p0) {},
                                        label: RichText(
                                          text: const TextSpan(
                                              text: 'Enter Count', style: TextStyle(color: kHintColor, fontFamily: Montserrat), children: [TextSpan(text: "*", style: TextStyle(color: Colors.red))]),
                                        ),
                                        hint: "",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: responsiveHeight(10),
                              ),
                              SizedBox(
                                height: responsiveHeight(20),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 15),
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: AppButton(
                                    onTap: () {
                                      Navigator.pushNamed(context, AppRoutes.addReferredPatient);
                                    },
                                    mWidth: SizeConfig.screenWidth * 0.6,
                                    title: "Add Referred Patient",
                                    iconData: Icon(
                                      Icons.arrow_forward,
                                      color: kWhiteColor,
                                      size: responsiveHeight(24),
                                    ),
                                  ),
                                ),
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
                                        onTap: () {
                                          saveCampDetails();
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
                  ],
                )
              ],
            ),
            if (isSaveLoad) // Show overlay based on condition
              Positioned.fill(
                child: Container(
                  width: SizeConfig.designScreenWidth,
                  height: SizeConfig.designScreenHeight,
                  color: Colors.black.withOpacity(0.3), // Semi-transparent overlay
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: Colors.red),
                      SizedBox(height: 10),
                      Text(
                        'Please wait..',
                        style: TextStyle(
                          color: Colors.white, // Text color for visibility
                          fontFamily: Montserrat,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        )),
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: responsiveHeight(20),
              ),
              AppRoundTextField(
                controller: TextEditingController(),
                inputStyle: TextStyle(fontSize: responsiveFont(14), color: kTextBlackColor),
                inputType: TextInputType.number,
                onChange: (p0) {},
                label: RichText(
                  text: const TextSpan(text: 'Enter Count', style: TextStyle(color: kHintColor, fontFamily: Montserrat), children: [TextSpan(text: "*", style: TextStyle(color: Colors.red))]),
                ),
                hint: "",
              ),
              SizedBox(
                height: responsiveHeight(20),
              ),
              AppRoundTextField(
                controller: TextEditingController(),
                inputStyle: TextStyle(fontSize: responsiveFont(14), color: kTextBlackColor),
                inputType: TextInputType.number,
                onChange: (p0) {},
                label: RichText(
                  text: const TextSpan(text: 'Login Name', style: TextStyle(color: kHintColor, fontFamily: Montserrat), children: [TextSpan(text: "*", style: TextStyle(color: Colors.red))]),
                ),
                hint: "",
              ),
              SizedBox(
                height: responsiveHeight(30),
              ),
              AppRoundTextField(
                controller: TextEditingController(),
                inputStyle: TextStyle(fontSize: responsiveFont(14), color: kTextBlackColor),
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
                              designationType.text = selectedDesignationType!['title'];
                            })
                          },
                      "Designation/Member Type",
                      list);
                },
                readOnly: true,
                label: RichText(
                  text: const TextSpan(
                      text: 'Designation/Member Type', style: TextStyle(color: kHintColor, fontFamily: Montserrat), children: [TextSpan(text: "*", style: TextStyle(color: Colors.red))]),
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
                      inputStyle: TextStyle(fontSize: responsiveFont(14), color: kTextBlackColor),
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
                                    countryCodeController.text = selectedCountryCode!['title'];
                                  })
                                },
                            "Country Code",
                            list);
                      },
                      maxLength: 12,
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
                                    mobileController.text = selectedMobile!['title'];
                                  })
                                },
                            "Mobile no",
                            list);
                      },
                      maxLength: 10,
                      label: RichText(
                        text: const TextSpan(text: 'Mobile No', style: TextStyle(color: kHintColor, fontFamily: Montserrat), children: [TextSpan(text: "*", style: TextStyle(color: Colors.red))]),
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

  Future<List<Map<String, dynamic>>> fetchLocationData() async {
    setState(() {
      isLoadingLocation = true;
    });

    final url = Uri.parse('http://210.89.42.117:8085/api/administrator/masters/dropdown/location-list');

    try {
      final response = await http.post(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> details = data['details'];

        setState(() {
          isLoadingLocation = false;
        });

        return details.map((item) {
          return {
            'location_master_id': item['location_master_id'],
            // 'lookup_det_hier_desc_en': item['lookup_det_hier_desc_en'],
            'location_name': item['location_name'],
          };
        }).toList();
      } else {
        setState(() {
          isLoadingLocation = false;
        });
        throw Exception('Failed to load data: ${response.reasonPhrase}');
      }
    } catch (e) {
      setState(() {
        isLoadingLocation = false;
      });
      throw Exception('Exception occurred: $e');
    }
  }

  Future<void> loadInit() async {
    // fetchLocationList();
    _locationData = fetchLocationData();

    locationData = await _locationData;
    setState(() {
      locationData;
      print(locationData);
    });
  }

  Future<List<Map<String, dynamic>>> fetchCampDateList() async {
    // Define the headers if needed (optional)
    campStartDateTimeList = [];
    var headers = {
      'Content-Type': 'application/json',
    };

    var locationId = locationNameIDController.text.trim();
    print(locationId);

    // Make the HTTP POST request
    var response = await http.post(
      Uri.parse('http://210.89.42.117:8085/api/administrator/camp/dropdown/camp-date-list/$locationId'),
      headers: headers,
    );

    print('http://210.89.42.117:8085/api/administrator/camp/dropdown/camp-date-list/$locationId');
    // Check the response status code
    if (response.statusCode == 200) {
      print('Response data: ${response.body}');

      var jsonResponse = json.decode(response.body);

      if (jsonResponse['message'] == "Data Not Found") {
        campStartDateTime.text = "No Data Available Try again later or Select Another Location";
      } else {
        campStartDateTime.text = "Select Camp Start Date & Time";
      }

      List<Map<String, dynamic>> detailsList = List<Map<String, dynamic>>.from(jsonResponse['details']);
      campStartDateTimeList.addAll(detailsList);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      print('Reason: ${response.reasonPhrase}');
    }
    return campStartDateTimeList;
  }

  Future<void> saveCampDetails() async {
    setState(() {
      isSaveLoad = true;
    });

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      // Define the request body
      var body = json.encode({
        "camp_dashboard_id": null,
        "camp_create_request_id": campStartDateTimeId.text.trim(),
        "camp_date": campStartDateTime.text.trim(),
        "camp_clousure_y_n": "Y",
        "camp_clousure_time": campCloseDateTimeUTC.text.trim(),
        "total_patients": int.parse(patientsRegistered.text),
        "treated_patients": int.parse(patientsTreated.text),
        "referred_patients": int.parse(patientsReferred.text),
        "remark": null,
        "org_id": 1,
        "status": 1
      });

      print(body);
      // Make the HTTP POST request
      var response = await http.post(
        Uri.parse('http://210.89.42.117:8085/api/administrator/masters/add/camp-dashboard-master'),
        headers: headers,
        body: body,
      );

      // Check the response status code
      if (response.statusCode == 200) {
        print('Response data: ${response.body}');

        final data = json.decode(response.body);
        if (data['status_code'] == 200) {
          DataProvider().storeCampDashboardId(data['uniquerId']);

          Future<List<CampCoordRegisteredPatientModel>> campRefPatientList = DataProvider().getPatientList();

          List<CampCoordRegisteredPatientModel> tempList = await campRefPatientList;
          if (tempList.isNotEmpty) {
            sendPostRequest(data['uniquerId'], tempList);
          }

          setState(() {
            isSaveLoad = false;
            // clearAllFields();
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Camp Details Saved Successfully',
              ),
              backgroundColor: Colors.green,
            ),
          );

          Navigator.pushNamed(context, AppRoutes.referredPatientList);
        }
      } else {
        setState(() {
          isSaveLoad = false;
        });
        print('Request failed with status: ${response.statusCode}.');
        print('Reason: ${response.reasonPhrase}');
      }
    } catch (e) {
      setState(() {
        isSaveLoad = false;
      });
      print(e);
    }
  }

  void clearAllFields() {
    setState(() {
      locationNameController.text = "";
      campStartDateTime.text = "";
      campCloseDateTime.text = "";
      locationNameIDController.text = "";
      campStartDateTimeList.clear();
      patientsRegistered.text = "";
      patientsTreated.text = "";
      patientsReferred.text = "";
    });
  }

  Future<void> sendPostRequest(data, List campRefPatientList) async {
    // List<CampCoordRegisteredPatientModel> campregisteredpatients = campRefPatientList;
    setState(() {
      isSaveLoad = true;
    });

    for (int i = 0; i < campRefPatientList.length; i++) {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = json.encode({
        "tt_camp_dashboard_ref_patients_list": [
          {
            "dashboard_ref_patients_id": null,
            "camp_dashboard_id": data,
            "patient_id": null,
            "patient_name": campRefPatientList[i].name,
            "age": 0,
            "lookup_det_id_gender": null,
            "contact_number": campRefPatientList[i].mobile,
            "org_id": 1,
            "status": 1,
            "tt_camp_dashboard_ref_patients_det_list": [
              {
                "dashboard_ref_patients_det_id": null,
                "dashboard_ref_patients_id": null,
                "lookup_det_hier_id_stakeholder_sub_type2": null,
                "stakeholder_master_id": int.parse(campRefPatientList[i].referredToId.toString()),
                "org_id": 1,
                "status": 1
              }
            ]
          }
        ]
      });
      print(body);
      var response = await http.post(
        Uri.parse('http://210.89.42.117:8085/api/administrator/masters/add/dashboard-patient-ref-details'),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        print(response.body);
        final data = json.decode(response.body);
        if (data['status_code'] == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Patients Saved Successfully',
              ),
              backgroundColor: Colors.green,
            ),
          );
          // Navigator.pop(context);
          SharedPreferences prefrences = await SharedPreferences.getInstance();
          await prefrences.remove('patients');
          Navigator.pushNamed(context, AppRoutes.referredPatientList);
        }
      } else {
        print('Request failed with status: ${response.statusCode}. ${response.reasonPhrase}');
      }
    }
  }
}

class CardData {
  String? cardTitle;

  CardData(this.cardTitle);
}
