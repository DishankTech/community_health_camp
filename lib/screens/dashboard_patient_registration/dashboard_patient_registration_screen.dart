import 'package:community_health_app/screens/dashboard_patient_registration/sf_date_range_picker_view/sf_date_range_picker_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../core/common_widgets/app_bar_v1.dart';
import '../../core/common_widgets/app_button.dart';
import '../../core/common_widgets/app_round_textfield.dart';
import '../../core/constants/fonts.dart';
import '../../core/utilities/size_config.dart';
import 'package:community_health_app/core/constants/images.dart';
import 'package:community_health_app/core/constants/constants.dart';
import 'package:pie_chart/pie_chart.dart';

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
  Map<String, double> dataMap = {
    "Food Items": 18.47,
    "Clothes": 17.70,
    "Technology": 4.25,
    "Cosmetics": 3.51,
    "Other": 2.83,
  };

  List<Color> colorList = [
    const Color(0xffD95AF3),
    const Color(0xff3EE094),
    const Color(0xff3398F6),
    const Color(0xffFA4A42),
    const Color(0xffFE9539)
  ];

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
              selectedStartDateWithRange = startDate;
              selectedEndDateWithRange = endDate;

              selectedDateWithRange =
                  "$selectedStartDateWithRange - $selectedEndDateWithRange";
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
    selectedDateWithRange = startDate;
  }

  void _showDownloadReportBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: false,
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
                    const Spacer(),
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: AppButton(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            title: "Download",
                            textStyle: TextStyle(
                                fontSize: responsiveFont(14),
                                color: kWhiteColor,
                                fontWeight: FontWeight.bold),
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
                            textStyle: TextStyle(
                                fontSize: responsiveFont(14),
                                color: kWhiteColor,
                                fontWeight: FontWeight.bold),
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
                          showTodayDate();
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
                          showTodayDate();
                          _showBottomSheet();
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
                      "Today - $selectedDateWithRange",
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
                                Text(
                                  "20",
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
                                    "542",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: responsiveFont(22),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "Total Patients Registered ",
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
                              dataMap: dataMap,
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
