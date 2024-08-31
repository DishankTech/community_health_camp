import 'package:community_health_app/core/utilities/no_internet_connectivity.dart';
import 'package:community_health_app/screens/doctor_desk/doctor_desk_controller.dart';
import 'package:community_health_app/screens/doctor_desk/doctor_desk_patients_screen/doctor_desk_patients_screen.dart';
import 'package:community_health_app/screens/doctor_desk/model/doctor_desk_details/doc_desk_data.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

import '../../../core/common_widgets/app_bar_v1.dart';
import '../../../core/constants/constants.dart';
import '../../../core/constants/images.dart';
import '../../../core/utilities/size_config.dart';

class DoctorDeskDetailsScreen extends StatefulWidget {
  const DoctorDeskDetailsScreen({super.key});

  @override
  State<DoctorDeskDetailsScreen> createState() =>
      _DoctorDeskDetailsScreenState();
}

class _DoctorDeskDetailsScreenState extends State<DoctorDeskDetailsScreen> {
  final DoctorDeskController doctorDeskController =
      Get.put(DoctorDeskController());

  checkInternetAndLoadData() async {
    List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();

    doctorDeskController.hasInternet =
        (connectivityResult.contains(ConnectivityResult.mobile) ||
            connectivityResult.contains(ConnectivityResult.wifi));

    if (doctorDeskController.hasInternet) {
      doctorDeskController.docPagingController.refresh();
    }

    doctorDeskController.update();
  }

  @override
  void initState() {
    doctorDeskController.docPagingController =
        PagingController(firstPageKey: 1);
    doctorDeskController.docPagingController.addPageRequestListener((pageKey) {
      doctorDeskController.fetchPagedoctorDeskDetailsList(pageKey);
    });
    checkInternetAndLoadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage(patRegBg), fit: BoxFit.fill),
        ),
        child: GetBuilder<DoctorDeskController>(
            init: DoctorDeskController(),
            builder: (controller) {
              return controller.hasInternet
                  ? controller.isLoading
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            mAppBarV1(
                              title: "Doctor Desk Details",
                              context: context,
                              onBackButtonPress: () {
                                Get.to(const DoctorDeskPatientsScreen());

                              },
                            ),
                            Container(
                              height: SizeConfig.screenHeight * 0.7,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(responsiveHeight(25)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    // Shadow color
                                    spreadRadius: 2,
                                    // Spread radius
                                    blurRadius: 7,
                                    // Blur radius
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: const Center(
                                  child: CircularProgressIndicator()),
                            )
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            mAppBarV1(
                              title: "Doctor Desk Details",
                              context: context,
                              leading: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Image.asset(
                                  icArrowBack,
                                  height: responsiveHeight(30),
                                ),
                              ),
                            ),
                            Expanded(
                              child: PagedListView<int, DocDeskData>(
                                  pagingController:
                                      controller.docPagingController,
                                  padding: EdgeInsets.zero,
                                  builderDelegate:
                                      PagedChildBuilderDelegate<DocDeskData>(
                                          itemBuilder:
                                              (context, item, index) => Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 8.0,
                                                                  right: 8.0,
                                                                  bottom: 8.0),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  offset:
                                                                      const Offset(
                                                                          0, 0),
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.5),
                                                                  spreadRadius:
                                                                      1,
                                                                  blurRadius: 5,
                                                                )
                                                              ],
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                responsiveHeight(
                                                                    20),
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                responsiveHeight(
                                                                    20),
                                                              ),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Row(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Flexible(
                                                                        flex: 1,
                                                                        child:
                                                                            Container(
                                                                          decoration: BoxDecoration(
                                                                              border: Border.all(color: Colors.blue),
                                                                              borderRadius: BorderRadius.circular(responsiveHeight(10))),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(1.0),
                                                                            child:
                                                                                Icon(
                                                                              Icons.person,
                                                                              size: responsiveHeight(54),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width: responsiveWidth(
                                                                            16),
                                                                      ),
                                                                      Flexible(
                                                                        flex: 3,
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(item.patientName ?? "",
                                                                                style: TextStyle(fontSize: responsiveFont(14), color: kBlackColor, fontWeight: FontWeight.bold)),
                                                                            SizedBox(
                                                                              height: responsiveHeight(10),
                                                                            ),
                                                                            Row(
                                                                              children: [
                                                                                RichText(
                                                                                  text: TextSpan(
                                                                                    text: "Age: ",
                                                                                    style: TextStyle(color: kTextColor, fontSize: responsiveFont(12), fontWeight: FontWeight.bold),
                                                                                    children: [
                                                                                      TextSpan(text: item.age != null ? item.age.toString() : "", style: TextStyle(fontSize: responsiveFont(12), color: kTextColor, fontWeight: FontWeight.normal))
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: responsiveHeight(10),
                                                                                ),
                                                                                RichText(
                                                                                  text: TextSpan(
                                                                                    text: "Gender: ",
                                                                                    style: TextStyle(color: kTextColor, fontSize: responsiveFont(12), fontWeight: FontWeight.bold),
                                                                                    children: [
                                                                                      TextSpan(text: item.lookupDetDescEn ?? "", style: TextStyle(fontSize: responsiveFont(12), color: kTextColor, fontWeight: FontWeight.normal))
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            SizedBox(
                                                                              height:
                                                                              responsiveHeight(10),
                                                                            ),
                                                                            Row(
                                                                              children: [
                                                                                RichText(
                                                                                  text: TextSpan(
                                                                                    text: "Camp ID: ",
                                                                                    style: TextStyle(
                                                                                        color:
                                                                                        kTextColor,
                                                                                        fontSize:
                                                                                        responsiveFont(
                                                                                            12),
                                                                                        fontWeight:
                                                                                        FontWeight
                                                                                            .bold),
                                                                                    children: [
                                                                                      TextSpan(
                                                                                          text: item.campCreateRequestId.toString() ??
                                                                                              "",
                                                                                          style: TextStyle(
                                                                                              fontSize:
                                                                                              responsiveFont(
                                                                                                  12),
                                                                                              color:
                                                                                              kTextColor,
                                                                                              fontWeight:
                                                                                              FontWeight
                                                                                                  .normal))
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width:
                                                                                  responsiveHeight(
                                                                                      10),
                                                                                ),
                                                                                RichText(
                                                                                  text: TextSpan(
                                                                                    text: "Camp Date: ",
                                                                                    style: TextStyle(
                                                                                        color:
                                                                                        kTextColor,
                                                                                        fontSize:
                                                                                        responsiveFont(
                                                                                            12),
                                                                                        fontWeight:
                                                                                        FontWeight
                                                                                            .bold),
                                                                                    children: [
                                                                                      TextSpan(
                                                                                          text: dateConversion(item.propCampDate),
                                                                                          style: TextStyle(
                                                                                              fontSize:
                                                                                              responsiveFont(
                                                                                                  12),
                                                                                              color:
                                                                                              kTextColor,
                                                                                              fontWeight:
                                                                                              FontWeight
                                                                                                  .normal))
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            SizedBox(
                                                                              height:
                                                                              responsiveHeight(10),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        responsiveHeight(
                                                                            10),
                                                                  ),

                                                                  RichText(
                                                                    text:
                                                                        TextSpan(
                                                                      text:
                                                                          "Symptoms: ",
                                                                      style: TextStyle(
                                                                          color:
                                                                              kTextColor,
                                                                          fontSize: responsiveFont(
                                                                              12),
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                      children: [
                                                                        TextSpan(
                                                                            text: item.symptons ??
                                                                                "",
                                                                            style: TextStyle(
                                                                                fontSize: responsiveFont(12),
                                                                                color: kTextColor,
                                                                                fontWeight: FontWeight.normal))
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        responsiveHeight(
                                                                            10),
                                                                  ),
                                                                  RichText(
                                                                    text:
                                                                        TextSpan(
                                                                      text:
                                                                          "Provisional Diagnosis: ",
                                                                      style: TextStyle(
                                                                          color:
                                                                              kTextColor,
                                                                          fontSize: responsiveFont(
                                                                              12),
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                      children: [
                                                                        TextSpan(
                                                                            text: item.provisionalDiagnosis ??
                                                                                "",
                                                                            style: TextStyle(
                                                                                fontSize: responsiveFont(12),
                                                                                color: kTextColor,
                                                                                fontWeight: FontWeight.normal))
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        responsiveHeight(
                                                                            10),
                                                                  ),
                                                                  RichText(
                                                                    text:
                                                                        TextSpan(
                                                                      text:
                                                                          "Refer To: ",
                                                                      style: TextStyle(
                                                                          color:
                                                                              kTextColor,
                                                                          fontSize: responsiveFont(
                                                                              12),
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                      children: [
                                                                        TextSpan(
                                                                            text: item.stakeholderNameEn ??
                                                                                "",
                                                                            style: TextStyle(
                                                                                fontSize: responsiveFont(12),
                                                                                color: kTextColor,
                                                                                fontWeight: FontWeight.normal))
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ]))),
                            ),
                          ],
                        )
                  : InternetIssue(
                      onRetryPressed: () {
                        checkInternetAndLoadData();
                      },
                    );
            }),
      ),
    );
  }

  dateConversion(dateTimeString){
    DateTime parsedDate = DateTime.parse(dateTimeString);

    // Format the date as "yyyy-MM-dd"
    String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
    return formattedDate;
  }
}
