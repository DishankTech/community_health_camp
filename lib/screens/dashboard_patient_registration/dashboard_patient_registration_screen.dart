// ignore_for_file: use_build_context_synchronously

import 'package:community_health_app/screens/dashboard_patient_registration/DashboardFilterCountResponse.dart';
import 'package:community_health_app/screens/dashboard_patient_registration/sf_date_range_picker_view/sf_date_range_picker_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../core/common_widgets/app_bar_v1.dart';
import '../../core/common_widgets/app_button.dart';
import '../../core/common_widgets/app_round_textfield.dart';
import '../../core/constants/fonts.dart';
import '../../core/constants/network_constant.dart';
import '../../core/utilities/data_provider.dart';
import '../../core/utilities/size_config.dart';
import 'package:community_health_app/core/constants/images.dart';
import 'package:community_health_app/core/constants/constants.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:community_health_app/core/constants/network_constant.dart';

class DashboardPatientRegistrationScreen extends StatefulWidget {
  const DashboardPatientRegistrationScreen({super.key});

  @override
  State<DashboardPatientRegistrationScreen> createState() =>
      _DashboardPatientRegistrationScreenState();
}

class _DashboardPatientRegistrationScreenState
    extends State<DashboardPatientRegistrationScreen> {
  bool isSelectedToday = true;
  bool isSelectedPatientsRegistered = true;
  bool isSelectedPatientsTreated = false;
  bool isSelectedPatientsReferred = false;

  String selectedDateWithRange = "";

  String selectedStartDateWithRange = "";
  String selectedEndDateWithRange = "";

  bool _isLoading = false;
  DashboardFilterCountDetails? detailsCount;
  String todayTitle = "Today";
  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      constraints: const BoxConstraints(
        minWidth: double.infinity,
      ),
      backgroundColor: Colors.white,
      isDismissible: true,
      builder: (
        BuildContext context,
      ) {
        return SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.width * 1.33,
          child: SfDateRangePickerView(
            onDidSelectedDateRange: (startDate, endDate) {
              final DateFormat formatter = DateFormat('dd MMM yyyy');
              final String startDateL =
                  formatter.format(DateTime.parse(startDate));
              final String endDateL = formatter.format(DateTime.parse(endDate));
              print('Start Date: $startDate');
              print('End Date: $endDate');

              final DateFormat formatter1 = DateFormat('yyyy-MM-dd');
              final String startDate1 =
                  formatter1.format(DateTime.parse(startDate));
              final String startDate2 =
                  formatter1.format(DateTime.parse(endDate));

              selectedStartDateWithRange = startDate1;
              selectedEndDateWithRange = startDate2;
              selectedDateWithRange = "$startDateL - $endDateL";
              filterCountDashboard();
              setState(() {});
            },
          ),
        );
      },
    ).whenComplete(() {
      setState(() {});
    });
  }

  showTodayDate() {
    final DateFormat formatter = DateFormat('dd MMM yyyy');
    final String startDate = formatter.format(DateTime.now());

    final DateFormat formatter1 = DateFormat('yyyy-MM-dd');
    final String startDate1 = formatter1.format(DateTime.now());

    selectedDateWithRange = startDate;
    selectedStartDateWithRange = startDate1;
    selectedEndDateWithRange = startDate1;
  }

  void _showDownloadReportBottomSheet() {
    showModalBottomSheet(
      context: context,
      constraints: const BoxConstraints(
        minWidth: double.infinity,
      ),
      backgroundColor: Colors.white,
      isDismissible: true,
      builder: (
        BuildContext context,
      ) {
        return Container(
          width: double.infinity,
          // height: MediaQuery.of(context).size.width * 0.70,
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: responsiveHeight(50),
                color: Colors.transparent,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Download Report",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: responsiveFont(18),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SizedBox(
                    width: responsiveHeight(30),
                    height: responsiveHeight(30),
                    child: Image.asset(icSquareClose),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 80, 20, 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppRoundTextField(
                      controller: TextEditingController(),
                      textCapitalization: TextCapitalization.none,
                      readOnly: true,
                      obscureText: false,
                      label: RichText(
                        text: const TextSpan(
                          text: 'From Date',
                          style: TextStyle(
                              color: kHintColor, fontFamily: Montserrat),
                          children: [
                            TextSpan(
                              text: "*",
                              style: TextStyle(color: Colors.red),
                            )
                          ],
                        ),
                      ),
                      hint: "",
                      suffix: GestureDetector(
                        onTap: () {},
                        child: SizedBox(
                          height: responsiveHeight(20),
                          width: responsiveHeight(20),
                          child: Image.asset(icCalendar),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: responsiveHeight(30),
                    ),
                    AppRoundTextField(
                      controller: TextEditingController(),
                      textCapitalization: TextCapitalization.none,
                      obscureText: false,
                      readOnly: true,
                      label: RichText(
                        text: const TextSpan(
                          text: 'To Date',
                          style: TextStyle(
                              color: kHintColor, fontFamily: Montserrat),
                          children: [
                            TextSpan(
                              text: "*",
                              style: TextStyle(color: Colors.red),
                            )
                          ],
                        ),
                      ),
                      hint: "",
                      suffix: GestureDetector(
                        onTap: () {},
                        child: SizedBox(
                          height: responsiveHeight(20),
                          width: responsiveHeight(20),
                          child: Image.asset(icCalendar),
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
                              Navigator.pop(context);
                            },
                            title: "Download",
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
                              Navigator.pop(context);
                            },
                            title: "Cancel",
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
            ],
          ),
        );
      },
    ).whenComplete(() {
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();

    showTodayDate();
    filterCountDashboard();
  }

  filterCountDashboard() async {
    setState(() {
      _isLoading = true; // Show loader
    });

    try {
      var headers = {'Content-Type': 'application/json'};
      var url = kBaseUrl + kFilterCountDashboard;
      print(url);
      var request = http.Request('POST', Uri.parse(url));
      request.body = json.encode({
        "days": 0,
        "start_date": selectedStartDateWithRange,
        "end_date": selectedEndDateWithRange
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      http.Response finalResponse = await http.Response.fromStream(response);

      if (response.statusCode == 200) {
        setState(() {
          _isLoading = false;

          // Hide loader
        });

        var responseBody = json.decode(finalResponse.body);
        // Get the status code as a string
        DashboardFilterCountResponse dashboardFilterCountResponse =
            DashboardFilterCountResponse.fromJson(responseBody);

        print(responseBody);
        if (dashboardFilterCountResponse.details == null) {
        } else {
          detailsCount = dashboardFilterCountResponse.details;
        }
        String statusCode = responseBody['status_code'].toString();
        if (statusCode == "200") {
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Login Failed',
              ),
              backgroundColor: Colors.red,
            ),
          );
        }

        //navigate to dashboard page
      } else {
        setState(() {
          _isLoading = false; // Hide loader
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Something went wrong',
            ),
            backgroundColor: Colors.red,
          ),
        );
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
  }

  getTotalCount() {
    if (isSelectedPatientsRegistered) {
      return detailsCount?.totalPatients.toString() ?? "0";
    } else if (isSelectedPatientsTreated) {
      return detailsCount?.totalTreatedPatients.toString() ?? "0";
    } else {
      return detailsCount?.totalReferredPatients.toString() ?? "0";
    }
  }

  String getTotalTitle() {
    if (isSelectedPatientsRegistered) {
      return "Patients Registered";
    } else if (isSelectedPatientsTreated) {
      return "Patients Treated";
    } else {
      return "Patients Referred";
    }
  }

  Map<String, double> getPichartData() {
    if (isSelectedPatientsRegistered) {
      Map<String, double> dataMap = {
        "Amravati": 99,
        "Ahmednagar": 10,
        "Raigad": 95,
        "Sindhudurga": 150,
      };
      return dataMap;
    } else if (isSelectedPatientsTreated) {
      Map<String, double> dataMap = {
        "Amravati": 131,
        "Ahmednagar": 5,
        "Raigad": 50,
        "Sindhudurga": 5,
      };
      return dataMap;
    } else {
      Map<String, double> dataMap = {
        "Amravati": 18.47,
        "Ahmednagar": 17.70,
        "Raigad": 45,
        "Sindhudurga": 1,
      };
      return dataMap;
    }
  }

  List<Color> colorList = [
    const Color(0xffD95AF3),
    const Color(0xff3EE094),
    const Color(0xff3398F6),
    const Color(0xffFA4A42),
    const Color(0xffFE9539)
  ];
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
          image: DecorationImage(image: AssetImage(patRegBg), fit: BoxFit.fill),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            mAppBarV1(
              title: "Dashboard",
              context: context,
              leading: GestureDetector(
                onTap: () {},
                child: Image.asset(
                  icMenu,
                  height: responsiveHeight(30),
                ),
              ),
              suffix: GestureDetector(
                onTap: () {
                  _showDownloadReportBottomSheet();
                },
                child: Image.asset(
                  downloadIcon,
                  height: responsiveHeight(30),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 4),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: responsiveHeight(68),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(
                    responsiveHeight(20),
                  ),
                  border: Border.all(
                    color: Colors.white,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          isSelectedToday = true;
                          todayTitle = "Today";
                          showTodayDate();
                          filterCountDashboard();
                          setState(() {});
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: isSelectedToday
                                ? Colors.white
                                : Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                responsiveHeight(20),
                              ),
                              bottomLeft: Radius.circular(
                                responsiveHeight(20),
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: responsiveHeight(30),
                                height: responsiveHeight(30),
                                child: Image.asset(
                                  iccalendar,
                                  color: isSelectedToday
                                      ? kTodayColor
                                      : Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: responsiveHeight(10),
                              ),
                              Text(
                                "Today",
                                style: TextStyle(
                                  color: isSelectedToday
                                      ? Colors.black
                                      : Colors.white,
                                  fontSize: responsiveFont(13),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          isSelectedToday = false;
                          todayTitle = "Date Range ";
                          showTodayDate();
                          _showBottomSheet();
                          filterCountDashboard();
                          setState(() {});
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: isSelectedToday
                                ? Colors.white.withOpacity(0.2)
                                : Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(
                                responsiveHeight(20),
                              ),
                              bottomRight: Radius.circular(
                                responsiveHeight(20),
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: responsiveHeight(30),
                                height: responsiveHeight(30),
                                child: Image.asset(
                                  calendarMonth,
                                  color: isSelectedToday
                                      ? Colors.white
                                      : kTodayColor,
                                ),
                              ),
                              SizedBox(
                                width: responsiveHeight(10),
                              ),
                              Text(
                                "Custom Date",
                                style: TextStyle(
                                  color: isSelectedToday
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: responsiveFont(13),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 4),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: responsiveHeight(140),
                padding: const EdgeInsets.fromLTRB(20, 12, 8, 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 0),
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5)
                  ],
                  borderRadius: BorderRadius.circular(
                    responsiveHeight(20),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$todayTitle - $selectedDateWithRange",
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: responsiveFont(16),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: responsiveHeight(4),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: responsiveHeight(40),
                          height: responsiveHeight(40),
                          child: Image.asset(
                            campingtenticon,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.transparent,
                            padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _isLoading
                                    ? const CircularProgressIndicator()
                                    : Text(
                                        detailsCount?.totalCampConduct
                                                .toString() ??
                                            "0",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: responsiveFont(22),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                Text(
                                  "Camps Conducted",
                                  style: TextStyle(
                                    color: dashboardSubTitle,
                                    fontSize: responsiveFont(14),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 4),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: responsiveHeight(190),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          isSelectedPatientsRegistered = true;
                          isSelectedPatientsTreated = false;
                          isSelectedPatientsReferred = false;
                          setState(() {});
                        },
                        child: Container(
                          color: Colors.transparent,
                          padding: const EdgeInsets.all(4),
                          child: Stack(
                            children: [
                              SizedBox(
                                width: responsiveHeight(180),
                                height: responsiveHeight(180),
                                child: Image.asset(
                                  isSelectedPatientsRegistered
                                      ? selectedGrid
                                      : unSelectedGrid,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: responsiveHeight(6),
                                  ),
                                  Center(
                                    child: SizedBox(
                                      width: responsiveHeight(60),
                                      height: responsiveHeight(60),
                                      child: Image.asset(icpatientregistration),
                                    ),
                                  ),
                                  Text(
                                    "Patients\nRegistered",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: dashboardSubTitle,
                                      fontSize: responsiveFont(13),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    height: responsiveHeight(10),
                                  ),
                                ],
                              ),
                              isSelectedPatientsRegistered
                                  ? Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 10, 10, 0),
                                        child: SizedBox(
                                          width: responsiveHeight(30),
                                          height: responsiveHeight(30),
                                          child: Image.asset(icCircleCheck),
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          isSelectedPatientsRegistered = false;
                          isSelectedPatientsTreated = true;
                          isSelectedPatientsReferred = false;
                          setState(() {});
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: Stack(
                            children: [
                              SizedBox(
                                width: responsiveHeight(180),
                                height: responsiveHeight(180),
                                child: Image.asset(
                                  isSelectedPatientsTreated
                                      ? selectedGrid
                                      : unSelectedGrid,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: responsiveHeight(6),
                                  ),
                                  Center(
                                    child: SizedBox(
                                      width: responsiveHeight(60),
                                      height: responsiveHeight(60),
                                      child: Image.asset(icExamination),
                                    ),
                                  ),
                                  Text(
                                    "Patients\nTreated",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: dashboardSubTitle,
                                      fontSize: responsiveFont(13),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    height: responsiveHeight(10),
                                  ),
                                ],
                              ),
                              isSelectedPatientsTreated
                                  ? Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 10, 10, 0),
                                        child: SizedBox(
                                          width: responsiveHeight(30),
                                          height: responsiveHeight(30),
                                          child: Image.asset(icCircleCheck),
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          isSelectedPatientsRegistered = false;
                          isSelectedPatientsTreated = false;
                          isSelectedPatientsReferred = true;
                          setState(() {});
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Stack(
                            children: [
                              SizedBox(
                                width: responsiveHeight(180),
                                height: responsiveHeight(180),
                                child: Image.asset(
                                  isSelectedPatientsReferred
                                      ? selectedGrid
                                      : unSelectedGrid,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: responsiveHeight(6),
                                  ),
                                  Center(
                                    child: SizedBox(
                                      width: responsiveHeight(60),
                                      height: responsiveHeight(60),
                                      child: Image.asset(icDoctorsOffice),
                                    ),
                                  ),
                                  Text(
                                    "Patients\nReferred",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: dashboardSubTitle,
                                      fontSize: responsiveFont(13),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    height: responsiveHeight(10),
                                  ),
                                ],
                              ),
                              isSelectedPatientsReferred
                                  ? Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 10, 10, 0),
                                        child: SizedBox(
                                          width: responsiveHeight(30),
                                          height: responsiveHeight(30),
                                          child: Image.asset(icCircleCheck),
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 0),
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 5)
                      ],
                      borderRadius: BorderRadius.circular(
                        responsiveHeight(20),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          color: Colors.transparent,
                          padding: const EdgeInsets.fromLTRB(20, 12, 8, 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    getTotalCount(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: responsiveFont(22),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    getTotalTitle(),
                                    style: TextStyle(
                                      color: dashboardSubTitle,
                                      fontSize: responsiveFont(13),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Container(
                                height: responsiveHeight(60),
                                padding:
                                    const EdgeInsets.fromLTRB(16, 4, 16, 4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        offset: const Offset(0, 0),
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 5)
                                  ],
                                  borderRadius: BorderRadius.circular(
                                    responsiveHeight(60),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "District",
                                          style: TextStyle(
                                            color: dashboardSubTitle,
                                            fontSize: responsiveFont(12),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          "All",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: responsiveFont(12),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: responsiveHeight(60),
                                    ),
                                    SizedBox(
                                      width: responsiveHeight(20),
                                      height: responsiveHeight(20),
                                      child: Image.asset(icArrowDown),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: responsiveHeight(10),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: responsiveHeight(460),
                            color: Colors.transparent,
                            padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                            child: PieChart(
                              dataMap: getPichartData(),
                              colorList: colorList,

                              centerText: "",
                              ringStrokeWidth: 34,
                              chartType: ChartType.ring,
                              animationDuration: const Duration(seconds: 0),
                              chartValuesOptions: const ChartValuesOptions(
                                  showChartValues: true,
                                  showChartValuesOutside: false,
                                  showChartValuesInPercentage: false,
                                  showChartValueBackground: false),
                              legendOptions: const LegendOptions(
                                  showLegends: true,
                                  legendShape: BoxShape.circle,
                                  legendTextStyle: TextStyle(fontSize: 15),
                                  legendPosition: LegendPosition.bottom,
                                  showLegendsInRow: true),
                              // gradientList: gradientList,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
