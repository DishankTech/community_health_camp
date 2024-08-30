import 'package:community_health_app/core/utilities/no_internet_connectivity.dart';
import 'package:community_health_app/screens/doctor_desk/add_treatment_details_screen/add_treatment_details_screen.dart';
import 'package:community_health_app/screens/doctor_desk/doctor_desk_controller.dart';
import 'package:community_health_app/screens/doctor_desk/doctor_desk_patients_screen/doctor_desk_details.dart';
import 'package:community_health_app/screens/doctor_desk/model/doctor_desk_data.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
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
      doctorDeskController.pagingController.refresh();
    }

    doctorDeskController.update();
  }

  @override
  void initState() {
    doctorDeskController.pagingController = PagingController(firstPageKey: 1);
    doctorDeskController.pagingController.addPageRequestListener((pageKey) {
      doctorDeskController.fetchPage(pageKey);
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
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            mAppBarV1(
                              title: "Patients List",
                              suffix: Row(
                                children: [
                                  Visibility(
                                    visible:
                                        doctorDeskController.isSearch == false,
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(5),
                                        onTap: () {
                                          doctorDeskController.isSearch = true;
                                          setState(() {});
                                        },
                                        child: Ink(
                                          child: const Icon(
                                            Icons.search,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      doctorDeskController.isSearch = false;
                                      doctorDeskController.pagingController
                                          .refresh();
                                      doctorDeskController.searchedDataModel =
                                          null;
                                      Get.to(const DoctorDeskDetailsScreen());
                                    },
                                    child: Image.asset(
                                      "assets/stethoscope.png",
                                      height: responsiveHeight(30),
                                    ),
                                  )
                                ],
                              ),
                              isSearched: doctorDeskController.isSearch,
                              searchWidget: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                                child: TextField(
                                  controller:
                                      doctorDeskController.searchController,
                                  onChanged: (value) async {
                                    await doctorDeskController
                                        .getSearchedData(value);
                                  },
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                          left: 8, top: 8),
                                      border: InputBorder.none,
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          doctorDeskController.isSearch = false;
                                          doctorDeskController
                                              .searchedDataModel = null;
                                          doctorDeskController.pagingController
                                              .refresh();
                                          doctorDeskController
                                              .searchController.text = '';
                                          setState(() {});
                                        },
                                        icon: const Icon(
                                            Icons.cancel_presentation),
                                      ),
                                      hintText: "Search"),
                                ),
                              ),
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
                              child:
                                  (doctorDeskController.searchedDataModel ==
                                          null)
                                      ? PagedListView<int, DoctorDeskData>(
                                          padding: EdgeInsets.zero,
                                          pagingController:
                                              controller.pagingController,
                                          shrinkWrap: true,
                                          builderDelegate:
                                              PagedChildBuilderDelegate<
                                                      DoctorDeskData>(
                                                  itemBuilder:
                                                      (context, item, index) =>
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 8.0,
                                                                    right: 8.0,
                                                                    bottom:
                                                                        8.0),
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    offset:
                                                                        const Offset(
                                                                            0,
                                                                            0),
                                                                    color: Colors
                                                                        .grey
                                                                        .withOpacity(
                                                                            0.5),
                                                                    spreadRadius:
                                                                        1,
                                                                    blurRadius:
                                                                        5,
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
                                                                  // crossAxisAlignment:
                                                                  //     CrossAxisAlignment
                                                                  //         .start,
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Flexible(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                Container(
                                                                              decoration: BoxDecoration(border: Border.all(color: Colors.blue), borderRadius: BorderRadius.circular(responsiveHeight(10))),
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(1.0),
                                                                                child: Icon(
                                                                                  Icons.person,
                                                                                  size: responsiveHeight(54),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                responsiveWidth(16),
                                                                          ),
                                                                          Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text(item.patientName ?? "", style: TextStyle(fontSize: responsiveFont(14), color: kBlackColor, fontWeight: FontWeight.bold)),
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
                                                                                        TextSpan(text: item.age.toString() ?? "", style: TextStyle(fontSize: responsiveFont(12), color: kTextColor, fontWeight: FontWeight.normal))
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
                                                                                        TextSpan(text: item.gender ?? "", style: TextStyle(fontSize: responsiveFont(12), color: kTextColor, fontWeight: FontWeight.normal))
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height: responsiveHeight(10),
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  RichText(
                                                                                    text: TextSpan(
                                                                                      text: "Camp ID: ",
                                                                                      style: TextStyle(color: kTextColor, fontSize: responsiveFont(12), fontWeight: FontWeight.bold),
                                                                                      children: [
                                                                                        TextSpan(text: item.campCreateRequestId.toString() ?? "", style: TextStyle(fontSize: responsiveFont(12), color: kTextColor, fontWeight: FontWeight.normal))
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: responsiveHeight(10),
                                                                                  ),
                                                                                  RichText(
                                                                                    text: TextSpan(
                                                                                      text: "Camp Date: ",
                                                                                      style: TextStyle(color: kTextColor, fontSize: responsiveFont(12), fontWeight: FontWeight.bold),
                                                                                      children: [
                                                                                        TextSpan(text: item.campDate ?? "", style: TextStyle(fontSize: responsiveFont(12), color: kTextColor, fontWeight: FontWeight.normal))
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Material(
                                                                      color: Colors
                                                                          .transparent,
                                                                      child:
                                                                          InkWell(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5),
                                                                        onTap:
                                                                            () {
                                                                          // Navigator.pushNamed(context,
                                                                          //     AppRoutes.addTreatmentDetailsScreen);
                                                                          Get.to(
                                                                              AddTreatmentDetailsScreen(
                                                                            doctorDeskData:
                                                                                item,
                                                                          ));
                                                                        },
                                                                        child:
                                                                            Ink(
                                                                          child:
                                                                              Image.asset(
                                                                            icEdit,
                                                                            height:
                                                                                responsiveHeight(36),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          )))
                                      : ListView.builder(
                                          itemCount: controller
                                              .searchedDataModel
                                              ?.details
                                              ?.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0,
                                                  right: 8.0,
                                                  bottom: 8.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      offset:
                                                          const Offset(0, 0),
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      spreadRadius: 1,
                                                      blurRadius: 5,
                                                    )
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    responsiveHeight(20),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(
                                                    responsiveHeight(20),
                                                  ),
                                                  child: Row(
                                                    // crossAxisAlignment:
                                                    //     CrossAxisAlignment
                                                    //         .start,
                                                    children: [
                                                      Expanded(
                                                        child: Row(
                                                          children: [
                                                            Flexible(
                                                              flex: 1,
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .blue),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            responsiveHeight(10))),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          1.0),
                                                                  child: Icon(
                                                                    Icons
                                                                        .person,
                                                                    size:
                                                                        responsiveHeight(
                                                                            54),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  responsiveWidth(
                                                                      16),
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                    controller
                                                                            .searchedDataModel
                                                                            ?.details?[
                                                                                index]
                                                                            .patientName ??
                                                                        "",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            responsiveFont(
                                                                                14),
                                                                        color:
                                                                            kBlackColor,
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                                SizedBox(
                                                                  height:
                                                                      responsiveHeight(
                                                                          10),
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    RichText(
                                                                      text:
                                                                          TextSpan(
                                                                        text:
                                                                            "Age: ",
                                                                        style: TextStyle(
                                                                            color:
                                                                                kTextColor,
                                                                            fontSize:
                                                                                responsiveFont(12),
                                                                            fontWeight: FontWeight.bold),
                                                                        children: [
                                                                          TextSpan(
                                                                              text: controller.searchedDataModel?.details?[index].age.toString() ?? "",
                                                                              style: TextStyle(fontSize: responsiveFont(12), color: kTextColor, fontWeight: FontWeight.normal))
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          responsiveHeight(
                                                                              10),
                                                                    ),
                                                                    RichText(
                                                                      text:
                                                                          TextSpan(
                                                                        text:
                                                                            "Gender: ",
                                                                        style: TextStyle(
                                                                            color:
                                                                                kTextColor,
                                                                            fontSize:
                                                                                responsiveFont(12),
                                                                            fontWeight: FontWeight.bold),
                                                                        children: [
                                                                          TextSpan(
                                                                              text: controller.searchedDataModel?.details?[index].genderDescEn ?? "",
                                                                              style: TextStyle(fontSize: responsiveFont(12), color: kTextColor, fontWeight: FontWeight.normal))
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
                                                                Row(
                                                                  children: [
                                                                    RichText(
                                                                      text:
                                                                          TextSpan(
                                                                        text:
                                                                            "Camp ID: ",
                                                                        style: TextStyle(
                                                                            color:
                                                                                kTextColor,
                                                                            fontSize:
                                                                                responsiveFont(12),
                                                                            fontWeight: FontWeight.bold),
                                                                        children: [
                                                                          TextSpan(
                                                                              text: controller.searchedDataModel?.details?[index].campCreateRequestId.toString() ?? "",
                                                                              style: TextStyle(fontSize: responsiveFont(12), color: kTextColor, fontWeight: FontWeight.normal))
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          responsiveHeight(
                                                                              10),
                                                                    ),
                                                                    RichText(
                                                                      text:
                                                                          TextSpan(
                                                                        text:
                                                                            "Camp Date: ",
                                                                        style: TextStyle(
                                                                            color:
                                                                                kTextColor,
                                                                            fontSize:
                                                                                responsiveFont(12),
                                                                            fontWeight: FontWeight.bold),
                                                                        children: [
                                                                          TextSpan(
                                                                              text: controller.searchedDataModel?.details?[index].campDate ?? "",
                                                                              style: TextStyle(fontSize: responsiveFont(12), color: kTextColor, fontWeight: FontWeight.normal))
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                RichText(
                                                                  text:
                                                                      TextSpan(
                                                                    text:
                                                                        "Mobile No: ",
                                                                    style: TextStyle(
                                                                        color:
                                                                            kTextColor,
                                                                        fontSize:
                                                                            responsiveFont(
                                                                                12),
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                    children: [
                                                                      TextSpan(
                                                                          text: controller.searchedDataModel?.details?[index].contactNumber ??
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
                                                                        "Address: ",
                                                                    style: TextStyle(
                                                                        color:
                                                                            kTextColor,
                                                                        fontSize:
                                                                            responsiveFont(
                                                                                12),
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                    children: [
                                                                      TextSpan(
                                                                        text:
                                                                            "${controller.searchedDataModel?.details?[index].locationName ?? ""} "
                                                                            "${controller.searchedDataModel?.details?[index].cityDescEn ?? ""} "
                                                                            "${controller.searchedDataModel?.details?[index].districtDescEn ?? ""} "
                                                                            "${controller.searchedDataModel?.details?[index].talukaDescEn ?? ""}"
                                                                            "${controller.searchedDataModel?.details?[index].stateDescEn ?? ""}",
                                                                        // text: "",
                                                                        style: TextStyle(
                                                                            fontSize: responsiveFont(
                                                                                12),
                                                                            color:
                                                                                kTextColor,
                                                                            fontWeight:
                                                                                FontWeight.normal),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Material(
                                                        color:
                                                            Colors.transparent,
                                                        child: InkWell(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          onTap: () {
                                                            Get.to(
                                                                AddTreatmentDetailsScreen(
                                                              searchedDat: controller
                                                                  .searchedDataModel
                                                                  ?.details?[index],
                                                            ));
                                                          },
                                                          child: Ink(
                                                            child: Image.asset(
                                                              icEdit,
                                                              height:
                                                                  responsiveHeight(
                                                                      36),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
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
