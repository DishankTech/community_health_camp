import 'package:community_health_app/core/utilities/no_internet_connectivity.dart';
import 'package:community_health_app/screens/doctor_desk/add_treatment_details_screen/add_treatment_details_screen.dart';
import 'package:community_health_app/screens/doctor_desk/doctor_desk_controller.dart';
import 'package:community_health_app/screens/doctor_desk/model/doctor_desk_data.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../core/common_widgets/app_bar_v1.dart';
import '../../../core/constants/constants.dart';
import '../../../core/constants/images.dart';
import '../../../core/utilities/size_config.dart';

class DoctorDeskPatientsScreen extends StatefulWidget {
  const DoctorDeskPatientsScreen({super.key});

  @override
  State<DoctorDeskPatientsScreen> createState() =>
      _DoctorDeskPatientsScreenState();
}

class _DoctorDeskPatientsScreenState extends State<DoctorDeskPatientsScreen> {
  final DoctorDeskController doctorDeskController =
      Get.put(DoctorDeskController());

  checkInternetAndLoadData() async {
    List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();

    doctorDeskController.hasInternet =
        (connectivityResult.contains(ConnectivityResult.mobile) ||
            connectivityResult.contains(ConnectivityResult.wifi));

    if (doctorDeskController.hasInternet) {
      doctorDeskController.fetchPage(1);
      doctorDeskController.pagingController.addPageRequestListener((pageKey) {
        doctorDeskController.fetchPage(pageKey);
      });
    }

    doctorDeskController.update();
  }

  @override
  void dispose() {
    // doctorDeskController.pagingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    doctorDeskController.doctorDesk?.clear();
    doctorDeskController.pagingController = PagingController(firstPageKey: 1);
    checkInternetAndLoadData();
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
                              title: "Patients List ",
                              context: context,
                              onBackButtonPress: () {
                                Navigator.pop(context);
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
                              title: "Patients List",
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
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                              child: IntrinsicHeight(
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
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
                                      responsiveHeight(25),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0,
                                        right: 8.0,
                                        left: 8.0,
                                        bottom: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Spacer(),
                                            const Text(
                                              "Total Registered Patients",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(
                                              width: responsiveWidth(8),
                                            ),
                                            Container(
                                              // width: 40,
                                              // height: 40,
                                              clipBehavior: Clip.hardEdge,
                                              padding: const EdgeInsets.only(
                                                  left: 12,
                                                  right: 12,
                                                  top: 8,
                                                  bottom: 8),
                                              decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(5),
                                                  ),
                                                  color: kPrimaryColor),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    controller
                                                            .doctorDesk?.length
                                                            .toString() ??
                                                        "",
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: responsiveHeight(10),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                width: double.infinity,
                                                color: Colors.transparent,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Camp ID : ",
                                                      style: TextStyle(
                                                        fontSize:
                                                            responsiveFont(12),
                                                        color: kBlackColor,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    Text(
                                                      controller.doctorDeskModel?.details?.data?.first.campCreateRequestId.toString() ?? "",
                                                      style: TextStyle(
                                                        fontSize:
                                                            responsiveFont(12),
                                                        // color: dashboardSubTitle,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                color: Colors.transparent,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Camp Date : ",
                                                      style: TextStyle(
                                                        fontSize:
                                                            responsiveFont(12),
                                                        color: kBlackColor,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    Text(
                                                      "",
                                                      style: TextStyle(
                                                        fontSize:
                                                            responsiveFont(12),
                                                        // color: dashboardSubTitle,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: responsiveHeight(10),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Camp Name : ",
                                              style: TextStyle(
                                                fontSize: responsiveFont(12),
                                                color: kBlackColor,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              controller.doctorDeskModel?.details?.data?.first.stakeholderNameEn ?? "",
                                              style: TextStyle(
                                                fontSize: responsiveFont(12),
                                                // color: dashboardSubTitle,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: responsiveHeight(10),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Camp Location : ",
                                              style: TextStyle(
                                                fontSize: responsiveFont(12),
                                                color: kBlackColor,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                controller.doctorDeskModel?.details?.data?.first.locationName ?? "",
                                                style: TextStyle(
                                                  fontSize: responsiveFont(12),
                                                  // color: dashboardSubTitle,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: PagedListView<int, DoctorDeskData>(
                                  pagingController: controller.pagingController,
                                  builderDelegate:
                                      PagedChildBuilderDelegate<DoctorDeskData>(
                                          itemBuilder:
                                              (context, item, index) => Stack(
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
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Flexible(
                                                                    flex: 1,
                                                                    child:
                                                                        Container(
                                                                      decoration: BoxDecoration(
                                                                          border:
                                                                              Border.all(color: Colors.blue),
                                                                          borderRadius: BorderRadius.circular(responsiveHeight(10))),
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            1.0),
                                                                        child: Image
                                                                            .asset(
                                                                          "assets/username.png",
                                                                          color:
                                                                              Colors.grey,
                                                                          fit: BoxFit
                                                                              .contain,
                                                                          // _list[i].image,
                                                                          height:
                                                                              responsiveHeight(54),
                                                                          width:
                                                                              responsiveWidth(54),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width:
                                                                        responsiveWidth(
                                                                            16),
                                                                  ),
                                                                  Flexible(
                                                                    flex: 3,
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                            controller.doctorDesk?[index].patientName ??
                                                                                "",
                                                                            style: TextStyle(
                                                                                fontSize: responsiveFont(14),
                                                                                color: kBlackColor,
                                                                                fontWeight: FontWeight.w500)),
                                                                        SizedBox(
                                                                          height:
                                                                              responsiveHeight(10),
                                                                        ),
                                                                        RichText(
                                                                          text:
                                                                              TextSpan(
                                                                            text:
                                                                                "Mobile No: ",
                                                                            style: TextStyle(
                                                                                color: kTextColor,
                                                                                fontSize: responsiveFont(12),
                                                                                fontWeight: FontWeight.bold),
                                                                            children: [
                                                                              TextSpan(text: controller.doctorDesk?[index].contactNumber ?? "", style: TextStyle(fontSize: responsiveFont(12), color: kTextColor, fontWeight: FontWeight.normal))
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              responsiveHeight(10),
                                                                        ),
                                                                        RichText(
                                                                          text:
                                                                              TextSpan(
                                                                            text:
                                                                                "Address: ",
                                                                            style: TextStyle(
                                                                                color: kTextColor,
                                                                                fontSize: responsiveFont(12),
                                                                                fontWeight: FontWeight.bold),
                                                                            children: [
                                                                              TextSpan(
                                                                                text:"${controller.doctorDeskModel?.details?.data?.first.cityEn ?? ""} "
                                                                                    "${controller.doctorDeskModel?.details?.data?.first.districtEn ?? ""} "
                                                                                    "${controller.doctorDeskModel?.details?.data?.first.countryEn ?? ""}",
                                                                                style: TextStyle(fontSize: responsiveFont(12), color: kTextColor, fontWeight: FontWeight.normal),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          top: 20,
                                                          right: 20,
                                                          child: Row(
                                                            children: [
                                                              Material(
                                                                color: Colors
                                                                    .transparent,
                                                                child: InkWell(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  onTap: () {
                                                                    // Navigator.pushNamed(context,
                                                                    //     AppRoutes.addTreatmentDetailsScreen);
                                                                    Get.to(
                                                                        AddTreatmentDetailsScreen(
                                                                      doctorDeskData:
                                                                          controller
                                                                              .doctorDesk?[index],
                                                                    ));
                                                                  },
                                                                  child: Ink(
                                                                    child: Image
                                                                        .asset(
                                                                      icEdit,
                                                                      height:
                                                                          responsiveHeight(
                                                                              36),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
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
}
