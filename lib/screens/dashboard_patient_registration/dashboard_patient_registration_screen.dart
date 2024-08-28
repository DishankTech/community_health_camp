// ignore_for_file: use_build_context_synchronously, unused_element
import 'dart:io';

import 'package:community_health_app/core/utilities/permission_service.dart';
import 'package:community_health_app/screens/dashboard_patient_registration/bloc/dashboard_bloc.dart';
import 'package:community_health_app/screens/dashboard_patient_registration/dashboard_card_view/dashboard_card_view.dart';
import 'package:community_health_app/screens/dashboard_patient_registration/models/dashboard_filter_count_response.dart';
import 'package:community_health_app/screens/dashboard_patient_registration/models/district_date_wise_camp_response_model.dart';
import 'package:community_health_app/screens/dashboard_patient_registration/sf_date_range_picker_view/SfDateRangePickerView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../core/common_widgets/app_bar_v1.dart';
import '../../core/common_widgets/app_button.dart';
import '../../core/common_widgets/app_round_textfield.dart';
import '../../core/constants/fonts.dart';
import '../../core/constants/network_constant.dart';
import '../../core/utilities/size_config.dart';
import 'package:community_health_app/core/constants/images.dart';
import 'package:community_health_app/core/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DashboardPatientRegistrationScreen extends StatefulWidget {
  const DashboardPatientRegistrationScreen({super.key});

  @override
  State<DashboardPatientRegistrationScreen> createState() =>
      _DashboardPatientRegistrationScreenState();
}

class _DashboardPatientRegistrationScreenState
    extends State<DashboardPatientRegistrationScreen> {
  int _selectedDateFilter = 0;
  bool isSelectedTillDate = true;
  bool isSelectedPatientsRegistered = true;
  bool isSelectedPatientsTreated = false;
  bool isSelectedPatientsReferred = false;

  String selectedDateWithRange = "";

  String selectedStartDateWithRange = "";
  String selectedEndDateWithRange = "";

  bool isLoading = false;

  bool isPDFDownload = true;
  DashboardFilterCountDetails? detailsCount;
  int _selectedIndex = -1;

  late List<ChartData> patientsSummaryPieData;
  String todayTitle = "Today";

  List<List<ChartData>> campConductedDistrictWiseList = [];
  List<List<ChartData>> totalPatientsRegisteredTillDateList = [];
  List<List<ChartData>> totalPatientsTreatmentsTillDateList = [];
  List<List<ChartData>> totalPatientsReferredTillDateList = [];
  List<List<ChartData>> totalPatientsSubReferredTillDateList = [];

  bool isShowPatientsSummary = true;
  bool isShowPatientsRegistered = false;
  bool isShowPatientsTreatments = false;
  bool isShowPatientsReferred = false;
  bool isShowPatientsSubReferred = false;
  int barSteps = 0;

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      // isScrollControlled: true,
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
          // height: MediaQuery.of(context).size.width * 1.33,
          child: SfDateRangePickerView(
            onDidSelectedDateRange: (startDate, endDate) {
              final DateFormat formatter = DateFormat('dd MMM yyyy');
              final String startDateL = formatter.format(startDate);
              final String endDateL = formatter.format(endDate);
              print('Start Date: $startDate');
              print('End Date: $endDate');

              final DateFormat formatter1 = DateFormat('yyyy-MM-dd');
              final String startDate1 = formatter1.format(startDate);
              final String startDate2 = formatter1.format(endDate);

              selectedStartDateWithRange = startDate1;
              selectedEndDateWithRange = startDate2;
              selectedDateWithRange = "$startDateL - $endDateL";
              context.read<DashboardBloc>().add(GetCount(payload: {
                    "days": 0,
                    "start_date": selectedStartDateWithRange,
                    "end_date": selectedEndDateWithRange
                  }));
              context
                  .read<DashboardBloc>()
                  .add(GetDateWiseDistrictCount(payload: {
                    "days": 0,
                    "start_date": selectedStartDateWithRange,
                    "end_date": selectedEndDateWithRange
                  }));
              // filterCountDashboard();
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
    String fromDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String toDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    TextEditingController fromDateTextController = TextEditingController();
    TextEditingController toDateTextController = TextEditingController();

    fromDateTextController.text = fromDate;
    toDateTextController.text = toDate;

    int reportType = 0;
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
        return StatefulBuilder(
          builder: (context, setState) =>
              BlocListener<DashboardBloc, DashboardState>(
            listener: (context, state) {
              if (state.getExcelDataStatus.isFailure) {
                ScaffoldMessenger.of(context)
                  ..clearSnackBars()
                  ..showSnackBar(const SnackBar(
                    content: Text('Unable to get report'),
                    duration: Duration(seconds: 3),
                    backgroundColor: Colors.red,
                  ));
                Navigator.pop(context);
              }
              if (state.getExcelDataStatus.isSuccess) {
                if (state.getExcelDataResponse ==
                    'File Downloaded Successfully') {
                  ScaffoldMessenger.of(context)
                    ..clearSnackBars()
                    ..showSnackBar(SnackBar(
                      content: Text(state.getExcelDataResponse),
                      duration: const Duration(seconds: 3),
                      backgroundColor: Colors.green,
                    ));
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context)
                    ..clearSnackBars()
                    ..showSnackBar(SnackBar(
                      content: Text(state.getExcelDataResponse),
                      duration: const Duration(seconds: 3),
                      backgroundColor: Colors.red,
                    ));
                  Navigator.pop(context);
                }
              }
            },
            child: Container(
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
                    padding: const EdgeInsets.fromLTRB(20, 80, 20, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppRoundTextField(
                          controller: fromDateTextController,
                          textCapitalization: TextCapitalization.none,
                          readOnly: true,
                          onTap: () async {
                            var date = await showDatePicker(
                                context: context,
                                firstDate: DateTime(2024, 1),
                                lastDate: DateTime.now());
                            fromDate = DateFormat('yyyy-MM-dd')
                                .format(date ?? DateTime.now());
                            fromDateTextController.text = fromDate;
                            setState(() {});
                          },
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
                          controller: toDateTextController,
                          textCapitalization: TextCapitalization.none,
                          onTap: () async {
                            var date = await showDatePicker(
                                context: context,
                                firstDate: DateTime.parse(fromDate),
                                lastDate: DateTime.now());
                            toDate = DateFormat('yyyy-MM-dd')
                                .format(date ?? DateTime.now());
                            toDateTextController.text = toDate;
                            setState(() {});
                          },
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
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: responsiveHeight(90),
                          color: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(
                                      () {
                                        reportType = 0;
                                      },
                                    );
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: responsiveFont(30),
                                          height: responsiveHeight(30),
                                          child: reportType == 0
                                              ? Image.asset(icCircleDot)
                                              : Image.asset(icCircle),
                                        ),
                                        SizedBox(
                                          width: responsiveHeight(6),
                                        ),
                                        Text(
                                          "PDF",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: responsiveFont(14),
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
                                    setState(
                                      () {
                                        reportType = 1;
                                      },
                                    );
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: responsiveFont(30),
                                          height: responsiveHeight(30),
                                          child: reportType == 1
                                              ? Image.asset(icCircleDot)
                                              : Image.asset(icCircle),
                                        ),
                                        SizedBox(
                                          width: responsiveHeight(6),
                                        ),
                                        Text(
                                          "Excel",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: responsiveFont(14),
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
                        BlocBuilder<DashboardBloc, DashboardState>(
                          builder: (context, state) {
                            return state.getExcelDataStatus.isInProgress
                                ? const CircularProgressIndicator()
                                : Row(
                                    children: [
                                      Flexible(
                                        flex: 1,
                                        child: AppButton(
                                          onTap: () {
                                            // Navigator.pop(context);
                                            context.read<DashboardBloc>().add(
                                                    GetExcelData(payload: {
                                                  "start_date": fromDate,
                                                  "end_date": toDate,
                                                  "district_id": null
                                                }));
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
                                  );
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> downloadFile() async {
    // Request storage permissions
    if (await Permission.storage.request().isGranted) {
      try {
        // The URL from which to download the file
        final url =
            'http://210.89.42.117:8085/api/administrator/masters/download-excel/';

        // Make the request
        final response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          // Get the filename from the headers if needed
          final contentDisposition = response.headers['content-disposition'];
          final filename = contentDisposition?.split('filename=')?.last ??
              'downloaded_file.xlsx';

          // Get the application's documents directory
          final directory = await getApplicationDocumentsDirectory();

          // Create the file
          final file = File('${directory.path}/$filename');

          // Write the file
          await file.writeAsBytes(response.bodyBytes);

          print('File saved to ${file.path}');
        } else {
          print('Failed to download file: ${response.statusCode}');
        }
      } catch (e) {
        print('Error: $e');
        PermissionService().requestPermissions();
      }
    } else {
      print('Storage permission denied.');
    }
  }

  @override
  void initState() {
    super.initState();
    getPatientsSummaryPieChartData();
    getCampConductedDistrictWiseBarChartData();
    getTotalPatientsRegisteredTillDateBarChartData();
    getTotalPatientsTreatmentsTillDateBarChartData();
    getTotalPatientsReferredTillDateBarChartData();
    getTotalPatientsSubReferredTillDateBarChartData();
    showTodayDate();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<DashboardBloc>().add(GetCount(payload: {
            "days": 0,
            "start_date": selectedStartDateWithRange,
            "end_date": selectedEndDateWithRange
          }));
      context.read<DashboardBloc>().add(GetDateWiseDistrictCount(payload: {
            "days": 0,
            "start_date": selectedStartDateWithRange,
            "end_date": selectedEndDateWithRange
          }));
    });
    // filterCountDashboard();
  }

  getPatientsSummaryPieChartData() {
    patientsSummaryPieData = [];
  }

  getCampConductedDistrictWiseBarChartData() {
    List<ChartData> chartDataList = [];

    final List<List<ChartData>> chartDataFinalList = [];

    for (ChartData obj in chartDataList) {
      chartDataFinalList.add([obj]);
    }
    campConductedDistrictWiseList = chartDataFinalList;
  }

  List<BarSeries<ChartData, String>> _getBarCampConductedDistrictWiseSeries() {
    return List<BarSeries<ChartData, String>>.generate(
      campConductedDistrictWiseList.length,
      (index) {
        return BarSeries<ChartData, String>(
          dataSource: campConductedDistrictWiseList[index],
          animationDuration: 0,
          animationDelay: 0,
          xValueMapper: (ChartData data, _) => data.category,
          yValueMapper: (ChartData data, _) => data.value,
          color: campConductedDistrictWiseBarChartcolor,
          width: 0.8,
        );
      },
    );
  }

  getTotalPatientsRegisteredTillDateBarChartData() {
    List<ChartData> chartDataList = [];

    final List<List<ChartData>> chartDataFinalList = [];

    for (ChartData obj in chartDataList) {
      chartDataFinalList.add([obj]);
    }
    totalPatientsRegisteredTillDateList = chartDataFinalList;
  }

  List<BarSeries<ChartData, String>>
      _getBarTotalPatientsRegisteredTillDateSeries() {
    return List<BarSeries<ChartData, String>>.generate(
      totalPatientsRegisteredTillDateList.length,
      (index) {
        return BarSeries<ChartData, String>(
          dataSource: totalPatientsRegisteredTillDateList[index],
          animationDuration: 0,
          animationDelay: 0,
          xValueMapper: (ChartData data, _) => data.category,
          yValueMapper: (ChartData data, _) => data.value,
          color: totlPaitentRegisterdPieChartColor,
        );
      },
    );
  }

  getTotalPatientsTreatmentsTillDateBarChartData() {
    List<ChartData> chartDataList = [];

    final List<List<ChartData>> chartDataFinalList = [];

    for (ChartData obj in chartDataList) {
      chartDataFinalList.add([obj]);
    }
    totalPatientsTreatmentsTillDateList = chartDataFinalList;
  }

  List<BarSeries<ChartData, String>>
      _getBarTotalPatientsTreatmentsTillDateSeries() {
    return List<BarSeries<ChartData, String>>.generate(
      totalPatientsTreatmentsTillDateList.length,
      (index) {
        return BarSeries<ChartData, String>(
          dataSource: totalPatientsTreatmentsTillDateList[index],
          animationDuration: 0,
          animationDelay: 0,
          xValueMapper: (ChartData data, _) => data.category,
          yValueMapper: (ChartData data, _) => data.value,
          color: totlPaitentTreatementPieChartColor,
        );
      },
    );
  }

  getTotalPatientsReferredTillDateBarChartData() {
    List<ChartData> chartDataList = [];

    final List<List<ChartData>> chartDataFinalList = [];

    for (ChartData obj in chartDataList) {
      chartDataFinalList.add([obj]);
    }
    totalPatientsReferredTillDateList = chartDataFinalList;
  }

  List<BarSeries<ChartData, String>>
      _getBarTotalPatientsReferredTillDateSeries() {
    return List<BarSeries<ChartData, String>>.generate(
      totalPatientsReferredTillDateList.length,
      (index) {
        return BarSeries<ChartData, String>(
          dataSource: totalPatientsReferredTillDateList[index],
          animationDuration: 0,
          animationDelay: 0,
          xValueMapper: (ChartData data, _) => data.category,
          yValueMapper: (ChartData data, _) => data.value,
          color: totlPaitentReferredPieChartColor,
          onPointTap: (pointInteractionDetails) {
            print("object");
            barSteps = 2;
            isShowPatientsSubReferred = true;
            setState(() {});
          },
        );
      },
    );
  }

  getTotalPatientsSubReferredTillDateBarChartData() {
    List<ChartData> chartDataList = [];

    final List<List<ChartData>> chartDataFinalList = [];

    for (ChartData obj in chartDataList) {
      chartDataFinalList.add([obj]);
    }
    totalPatientsSubReferredTillDateList = chartDataFinalList;
  }

  List<BarSeries<ChartData, String>>
      _getBarTotalPatientsSubReferredTillDateSeries() {
    return List<BarSeries<ChartData, String>>.generate(
      totalPatientsSubReferredTillDateList.length,
      (index) {
        return BarSeries<ChartData, String>(
          dataSource: totalPatientsSubReferredTillDateList[index],
          animationDuration: 0,
          animationDelay: 0,
          xValueMapper: (ChartData data, _) => data.category,
          yValueMapper: (ChartData data, _) => data.value,
          color: totlPaitentSubReferredPieChartColor,
        );
      },
    );
  }

  getBarTitleName() {
    if (_selectedIndex == -1) {
      return "Patients Summary";
    } else if (_selectedIndex == 0) {
      return "Total Patients Registered - Till Date";
    } else if (_selectedIndex == 1) {
      return "Total Patients Treated - Till Date";
    } else if (_selectedIndex == 2) {
      if (isShowPatientsReferred && isShowPatientsSubReferred == false) {
        return "Total Patients Treated - Till Date";
      }
      return "Total Patients Treated - Till Date - Pune";
    }
    return "Total Patients Referred - Till Date";
  }
  // filterCountDashboard() async {
  //   setState(() {
  //     isLoading = true; // Show loader
  //   });

  //   try {
  //     var headers = {'Content-Type': 'application/json'};
  //     var url = kBaseUrl + kFilterCountDashboard;
  //     print(url);
  //     var request = http.Request('POST', Uri.parse(url));
  //     request.body = json.encode({
  //       "days": 0,
  //       "start_date": selectedStartDateWithRange,
  //       "end_date": selectedEndDateWithRange
  //     });
  //     request.headers.addAll(headers);

  //     http.StreamedResponse response = await request.send();
  //     http.Response finalResponse = await http.Response.fromStream(response);

  //     if (response.statusCode == 200) {
  //       setState(() {
  //         isLoading = false;
  //       });

  //       var responseBody = json.decode(finalResponse.body);
  //       // Get the status code as a string
  //       DashboardFilterCountResponse dashboardFilterCountResponse =
  //           DashboardFilterCountResponse.fromJson(responseBody);

  //       print(responseBody);
  //       if (dashboardFilterCountResponse.details == null) {
  //       } else {
  //         detailsCount = dashboardFilterCountResponse.details;
  //       }
  //       String statusCode = responseBody['status_code'].toString();
  //       if (statusCode == "200") {
  //       } else {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(
  //             content: Text(
  //               'Login Failed',
  //             ),
  //             backgroundColor: Colors.red,
  //           ),
  //         );
  //       }

  //       //navigate to dashboard page
  //     } else {
  //       setState(() {
  //         isLoading = false; // Hide loader
  //       });
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text(
  //             'Something went wrong',
  //           ),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //       print(response.reasonPhrase);
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // getTotalCount() {
  //   if (isSelectedPatientsRegistered) {
  //     return detailsCount?.totalPatients.toString() ?? "0";
  //   } else if (isSelectedPatientsTreated) {
  //     return detailsCount?.totalTreatedPatients.toString() ?? "0";
  //   } else {
  //     return detailsCount?.totalReferredPatients.toString() ?? "0";
  //   }
  // }

  // String getTotalTitle() {
  //   if (isSelectedPatientsRegistered) {
  //     return "Patients Registered";
  //   } else if (isSelectedPatientsTreated) {
  //     return "Patients Treated";
  //   } else {
  //     return "Patients Referred";
  //   }
  // }

  // List<ChartData> chartData =
  //     List.generate(36, (index) => ChartData('La $index', index.toDouble()));

  // final List<List<ChartData>> chartDataList = [
  //   [
  //     ChartData('Pune', 99),
  //   ],
  //   [
  //     ChartData('Mumbai', 25),
  //   ],
  //   [
  //     ChartData('Nagpur', 15),
  //   ],
  //   [
  //     ChartData('Nashik', 15),
  //   ],
  //   [
  //     ChartData('Satara', 15),
  //   ],
  //   [
  //     ChartData('Wardha', 15),
  //   ],
  // ];

  // List<BarSeries<ChartData, String>> _getBarSeries() {
  //   return List<BarSeries<ChartData, String>>.generate(
  //     chartDataList.length,
  //     (index) {
  //       return BarSeries<ChartData, String>(
  //         dataSource: chartDataList[index],
  //         xValueMapper: (ChartData data, _) => data.category,
  //         yValueMapper: (ChartData data, _) => data.value,
  //         // spacing: 0.3,
  //         // onPointTap: (pointInteractionDetails) {
  //         //   print("object");
  //         // },
  //       );
  //     },
  //   );
  // }
  Widget getPieOrBarChartLayout() {
    if (isShowPatientsSummary) {
      return SfCircularChart(
        legend: const Legend(
          isVisible: true,
          position: LegendPosition.bottom,
          alignment: ChartAlignment.center,
          orientation: LegendItemOrientation.horizontal,
          overflowMode: LegendItemOverflowMode.wrap,
          itemPadding: 8,
          textStyle: TextStyle(
            fontSize: 12,
            color: Colors.black,
          ),
        ),
        series: <PieSeries<ChartData, String>>[
          PieSeries<ChartData, String>(
            dataSource: patientsSummaryPieData,
            animationDuration: 0,
            animationDelay: 0,
            pointColorMapper: (ChartData data, _) => data.color,
            xValueMapper: (ChartData data, _) => data.category,
            yValueMapper: (ChartData data, _) => data.value,
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              textStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontStyle: FontStyle.normal,
              ),
            ),
            explode: false,
            explodeIndex: _selectedIndex,
            onPointTap: (ChartPointDetails details) {
              setState(() {
                _selectedIndex = details.pointIndex!;

                if (_selectedIndex == 0) {
                  isShowPatientsSummary = false;
                  isShowPatientsRegistered = true;
                  isShowPatientsTreatments = false;
                  isShowPatientsReferred = false;
                  barSteps = 1;
                } else if (_selectedIndex == 1) {
                  isShowPatientsSummary = false;
                  isShowPatientsRegistered = false;
                  isShowPatientsTreatments = true;
                  isShowPatientsReferred = false;
                  barSteps = 1;
                } else if (_selectedIndex == 2) {
                  isShowPatientsSummary = false;
                  isShowPatientsRegistered = false;
                  isShowPatientsTreatments = false;
                  isShowPatientsReferred = true;
                  barSteps = 1;
                }
                print(_selectedIndex);
              });
            },
          ),
        ],
      );
    } else if (isShowPatientsRegistered) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(8, 30, 8, 8),
        child: SfCartesianChart(
          isTransposed: true,
          primaryXAxis: CategoryAxis(
            labelRotation: -45,
            autoScrollingMode: AutoScrollingMode.start,
            initialVisibleMinimum: (campConductedDistrictWiseList.length - 20),
            initialVisibleMaximum: (campConductedDistrictWiseList.length - 0),
          ),
          primaryYAxis: const NumericAxis(
            minimum: 0,
            // maximum: 40,
            interval: 10,
          ),
          zoomPanBehavior: ZoomPanBehavior(
            enablePanning: true,
          ),
          series: _getBarTotalPatientsRegisteredTillDateSeries(),
        ),
      );
    } else if (isShowPatientsTreatments) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(8, 30, 8, 8),
        child: SfCartesianChart(
          isTransposed: true,
          primaryXAxis: CategoryAxis(
            labelRotation: -45,
            autoScrollingMode: AutoScrollingMode.start,
            initialVisibleMinimum: (campConductedDistrictWiseList.length - 20),
            initialVisibleMaximum: (campConductedDistrictWiseList.length - 0),
          ),
          primaryYAxis: const NumericAxis(
            minimum: 0,
            // maximum: 40,
            interval: 10,
          ),
          zoomPanBehavior: ZoomPanBehavior(
            enablePanning: true,
          ),
          series: _getBarTotalPatientsTreatmentsTillDateSeries(),
        ),
      );
    } else if (isShowPatientsReferred && isShowPatientsSubReferred == false) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(8, 30, 8, 8),
        child: SfCartesianChart(
          isTransposed: true,
          primaryXAxis: CategoryAxis(
            labelRotation: -45,
            autoScrollingMode: AutoScrollingMode.start,
            initialVisibleMinimum: (campConductedDistrictWiseList.length - 20),
            initialVisibleMaximum: (campConductedDistrictWiseList.length - 0),
          ),
          primaryYAxis: const NumericAxis(
            minimum: 0,
            // maximum: 40,
            interval: 10,
          ),
          zoomPanBehavior: ZoomPanBehavior(
            enablePanning: true,
          ),
          series: _getBarTotalPatientsReferredTillDateSeries(),
        ),
      );
    } else if (isShowPatientsReferred && isShowPatientsSubReferred) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(8, 30, 8, 8),
        child: SfCartesianChart(
          isTransposed: true,
          primaryXAxis: CategoryAxis(
            labelRotation: -45,
            autoScrollingMode: AutoScrollingMode.start,
            initialVisibleMinimum: (campConductedDistrictWiseList.length - 20),
            initialVisibleMaximum: (campConductedDistrictWiseList.length - 0),
          ),
          primaryYAxis: const NumericAxis(
            minimum: 0,
            // maximum: 40,
            interval: 10,
          ),
          zoomPanBehavior: ZoomPanBehavior(
            enablePanning: true,
          ),
          series: _getBarTotalPatientsSubReferredTillDateSeries(),
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
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
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(
                  icArrowBack,
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
                          _selectedDateFilter = 0;
                          todayTitle = "Today";
                          showTodayDate();
                          _selectedIndex = -1;
                          isShowPatientsSummary = true;
                          isShowPatientsTreatments = false;
                          isShowPatientsReferred = false;
                          // filterCountDashboard();
                          context.read<DashboardBloc>().add(GetCount(payload: {
                                "days": 0,
                                "start_date": DateFormat('yyyy-MM-dd')
                                    .format(DateTime.now()),
                                "end_date": DateFormat('yyyy-MM-dd')
                                    .format(DateTime.now())
                              }));
                          context
                              .read<DashboardBloc>()
                              .add(GetDateWiseDistrictCount(payload: {
                                "start_date": DateFormat('yyyy-MM-dd')
                                    .format(DateTime.now()),
                                "end_date": DateFormat('yyyy-MM-dd')
                                    .format(DateTime.now()),
                                "district_id": 0
                              }));
                          setState(() {});
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: _selectedDateFilter == 0
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
                                  color: _selectedDateFilter == 0
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
                                  color: _selectedDateFilter == 0
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
                    const VerticalDivider(
                      color: Colors.grey,
                      width: 0,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _selectedDateFilter = 1;
                          todayTitle = "Till Date";
                          showTodayDate();
                          _selectedIndex = -1;
                          isShowPatientsSummary = true;
                          isShowPatientsTreatments = false;
                          isShowPatientsReferred = false;
                          // filterCountDashboard();
                          context.read<DashboardBloc>().add(GetCount(
                                  payload: const {
                                    "days": null,
                                    "start_date": null,
                                    "end_date": null
                                  }));
                          context.read<DashboardBloc>().add(
                                  GetDateWiseDistrictCount(payload: const {
                                "start_date": null,
                                "end_date": null,
                                "district_id": null
                              }));
                          setState(() {});
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: _selectedDateFilter == 1
                                ? Colors.white
                                : Colors.white.withOpacity(0.2),
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
                                  color: _selectedDateFilter == 1
                                      ? kPrimaryColor
                                      : kPrimaryColor.withOpacity(0.5),
                                ),
                              ),
                              SizedBox(
                                width: responsiveHeight(10),
                              ),
                              Text(
                                "Till Date",
                                style: TextStyle(
                                  color: _selectedDateFilter == 1
                                      ? kBlackColor
                                      : kBlackColor.withOpacity(0.5),
                                  fontSize: responsiveFont(13),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const VerticalDivider(
                      color: Colors.grey,
                      width: 0,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _selectedDateFilter = 2;
                          todayTitle = "Date Range ";
                          showTodayDate();
                          _showBottomSheet();
                          _selectedIndex = -1;
                          isShowPatientsSummary = true;
                          isShowPatientsTreatments = false;
                          isShowPatientsReferred = false;
                          // filterCountDashboard();
                          setState(() {});
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: _selectedDateFilter == 2
                                ? Colors.white
                                : Colors.white.withOpacity(0.2),
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
                                  color: _selectedDateFilter == 2
                                      ? kPrimaryColor
                                      : kPrimaryColor.withOpacity(0.5),
                                ),
                              ),
                              SizedBox(
                                width: responsiveHeight(10),
                              ),
                              Text(
                                "Custom",
                                style: TextStyle(
                                  color: _selectedDateFilter == 2
                                      ? kBlackColor
                                      : kBlackColor.withOpacity(0.5),
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
            Expanded(
              child: SingleChildScrollView(
                child: BlocBuilder<DashboardBloc, DashboardState>(
                  builder: (context, state) {
                    DashboardFilterCountResponse? dashboardFilterCountResponse;
                    bool noData = false;
                    if (state.getCountStatus.isSuccess) {
                      dashboardFilterCountResponse =
                          DashboardFilterCountResponse.fromJson(
                              jsonDecode(state.getCountResponse));
                      if (dashboardFilterCountResponse!.details != null) {
                        if (dashboardFilterCountResponse!
                                    .details!.totalPatients ==
                                0 &&
                            dashboardFilterCountResponse!
                                    .details!.totalReferredPatients ==
                                0 &&
                            dashboardFilterCountResponse!
                                    .details!.totalTreatedPatients ==
                                0) {
                          noData = true;
                        } else {
                          noData = false;
                          patientsSummaryPieData = [
                            ChartData(
                                "Patients Registered",
                                double.parse(dashboardFilterCountResponse!
                                    .details!.totalPatients!
                                    .toString()),
                                totlPaitentRegisterdPieChartColor),
                            ChartData(
                                "Patients Treated",
                                double.parse(dashboardFilterCountResponse!
                                    .details!.totalTreatedPatients!
                                    .toString()),
                                totlPaitentTreatementPieChartColor),
                            ChartData(
                                "Patients Referred",
                                double.parse(dashboardFilterCountResponse!
                                    .details!.totalReferredPatients!
                                    .toString()),
                                totlPaitentReferredPieChartColor),
                          ];
                        }
                      }
                    }
                    return Container(
                      color: Colors.transparent,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(responsiveHeight(10),
                                responsiveHeight(10), responsiveHeight(10), 0),
                            child: Container(
                              color: Colors.transparent,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 10, 10, 10),
                                    color: Colors.transparent,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        DashboardCardView(
                                          titleString: "Camps Conducted",
                                          tillDateCount: "100",
                                          todayString:
                                              dashboardFilterCountResponse !=
                                                          null &&
                                                      dashboardFilterCountResponse!
                                                              .details !=
                                                          null
                                                  ? dashboardFilterCountResponse
                                                      .details!.totalCampConduct
                                                      .toString()
                                                  : '',
                                          isLoading:
                                              state.getCountStatus.isInProgress,
                                        ),
                                        SizedBox(
                                          width: responsiveWidth(10),
                                        ),
                                        DashboardCardView(
                                          titleString: "Patients Registered",
                                          tillDateCount: "100",
                                          todayString:
                                              dashboardFilterCountResponse !=
                                                          null &&
                                                      dashboardFilterCountResponse!
                                                              .details !=
                                                          null
                                                  ? dashboardFilterCountResponse
                                                      .details!.totalPatients
                                                      .toString()
                                                  : '',
                                          isLoading:
                                              state.getCountStatus.isInProgress,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 10, 10, 10),
                                    color: Colors.transparent,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        DashboardCardView(
                                          titleString: "Treatments Completed",
                                          tillDateCount: "100",
                                          todayString:
                                              dashboardFilterCountResponse !=
                                                          null &&
                                                      dashboardFilterCountResponse!
                                                              .details !=
                                                          null
                                                  ? dashboardFilterCountResponse
                                                      .details!
                                                      .totalTreatedPatients
                                                      .toString()
                                                  : '',
                                          isLoading:
                                              state.getCountStatus.isInProgress,
                                        ),
                                        SizedBox(
                                          width: responsiveWidth(10),
                                        ),
                                        DashboardCardView(
                                          titleString: "Patients Referred",
                                          tillDateCount: "100",
                                          todayString:
                                              dashboardFilterCountResponse !=
                                                          null &&
                                                      dashboardFilterCountResponse!
                                                              .details !=
                                                          null
                                                  ? dashboardFilterCountResponse
                                                      .details!
                                                      .totalReferredPatients
                                                      .toString()
                                                  : '',
                                          isLoading:
                                              state.getCountStatus.isInProgress,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          //Pie Chart View
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                            child: Container(
                              width: double.infinity,
                              height: responsiveHeight(480),
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
                              child: Stack(
                                children: [
                                  isShowPatientsSummary
                                      ? Container()
                                      : Align(
                                          alignment: Alignment.topRight,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 8, 10, 0),
                                            child: GestureDetector(
                                              onTap: () {
                                                // if (barSteps == 0) {
                                                //   _selectedIndex = -1;
                                                //   isShowPatientsSummary = true;
                                                //   isShowPatientsTreatments = false;
                                                //   isShowPatientsReferred = false;
                                                // } else
                                                if (barSteps == 1) {
                                                  _selectedIndex = -1;
                                                  isShowPatientsSummary = true;
                                                  isShowPatientsTreatments =
                                                      false;
                                                  isShowPatientsReferred =
                                                      false;
                                                } else if (barSteps == 2) {
                                                  isShowPatientsSummary = false;
                                                  isShowPatientsTreatments =
                                                      false;
                                                  isShowPatientsReferred = true;
                                                  isShowPatientsSubReferred =
                                                      false;
                                                }
                                                barSteps -= 1;
                                                setState(() {});
                                              },
                                              child: Container(
                                                width: responsiveWidth(35),
                                                height: responsiveHeight(35),
                                                decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    responsiveHeight(8),
                                                  ),
                                                ),
                                                child: Center(
                                                  child:
                                                      Image.asset(icArrowBack),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 10, 0, 0),
                                    child: Text(
                                      getBarTitleName(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: responsiveFont(11),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  state.getCountStatus.isInProgress
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : noData
                                          ? const Align(
                                              alignment:
                                                  FractionalOffset.center,
                                              child: Text(
                                                  "Data not available for selected date"),
                                            )
                                          : getPieOrBarChartLayout(),
                                ],
                              ),
                            ),
                          ),
                          //Bar chart
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                            child: Container(
                              width: double.infinity,
                              height: responsiveHeight(480),
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
                              child: Stack(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 10, 0, 0),
                                    child: Text(
                                      "Camp Conducted District Wise",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: responsiveFont(11),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 30, 8, 8),
                                    child: BlocBuilder<DashboardBloc,
                                        DashboardState>(
                                      builder: (context, state) {
                                        bool noData = true;
                                        DistrictDateWiseCampResponseModel?
                                            districtDateWiseCampResponseModel;
                                        if (state.getDateWiseDistrictCountStatus
                                            .isSuccess) {
                                          if (state
                                              .getDateWiseDistrictCountResponse
                                              .isNotEmpty) {
                                            districtDateWiseCampResponseModel =
                                                DistrictDateWiseCampResponseModel
                                                    .fromJson(jsonDecode(state
                                                        .getDateWiseDistrictCountResponse));
                                            List<ChartData> chartDataList = [];
                                            if (districtDateWiseCampResponseModel != null &&
                                                districtDateWiseCampResponseModel
                                                        .details !=
                                                    null &&
                                                districtDateWiseCampResponseModel
                                                    .details!.isNotEmpty) {
                                              noData = false;
                                              for (var element
                                                  in districtDateWiseCampResponseModel
                                                      .details!) {
                                                chartDataList.add(ChartData(
                                                    element
                                                        .lookupDetHierDescEn!,
                                                    double.parse(element
                                                        .districtWiseCamp
                                                        .toString()),
                                                    kPrimaryColor));
                                              }

                                              final List<List<ChartData>>
                                                  chartDataFinalList = [];

                                              for (ChartData obj
                                                  in chartDataList) {
                                                chartDataFinalList.add([obj]);
                                              }
                                              campConductedDistrictWiseList =
                                                  chartDataFinalList;
                                            } else {
                                              noData = true;
                                            }
                                          }
                                        }

                                        return state
                                                .getDateWiseDistrictCountStatus
                                                .isInProgress
                                            ? const Center(
                                                child:
                                                    CircularProgressIndicator())
                                            : noData
                                                ? const Align(
                                                    alignment:
                                                        FractionalOffset.center,
                                                    child: Text(
                                                        "Data not available for selected date"),
                                                  )
                                                : SfCartesianChart(
                                                    isTransposed: true,
                                                    primaryXAxis: CategoryAxis(
                                                      labelRotation: -70,
                                                      autoScrollingMode:
                                                          AutoScrollingMode
                                                              .start,
                                                      initialVisibleMinimum:
                                                          (campConductedDistrictWiseList
                                                                  .length -
                                                              20),
                                                      initialVisibleMaximum:
                                                          (campConductedDistrictWiseList
                                                                  .length -
                                                              0),
                                                    ),
                                                    primaryYAxis:
                                                        const NumericAxis(
                                                      minimum: 0,
                                                      // maximum: 40,
                                                      interval: 3,
                                                    ),
                                                    zoomPanBehavior:
                                                        ZoomPanBehavior(
                                                      enablePanning: true,
                                                    ),
                                                    series:
                                                        _getBarCampConductedDistrictWiseSeries(),
                                                  );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: responsiveHeight(30),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            // ),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.category, this.value, [this.color]);

  final String category;
  final double value;
  final Color? color;
}
