import 'package:community_health_app/core/common_widgets/app_bar_v1.dart';
import 'package:community_health_app/core/common_widgets/app_button.dart';
import 'package:community_health_app/core/constants/constants.dart';
import 'package:community_health_app/core/constants/images.dart';
import 'package:community_health_app/core/utilities/no_internet_connectivity.dart';
import 'package:community_health_app/core/utilities/size_config.dart';
import 'package:community_health_app/screens/camp_approval/camp_approval.dart';
import 'package:community_health_app/screens/camp_approval/controller/camp_approval_controller.dart';
import 'package:community_health_app/screens/camp_approval/model/camp_approval_details/TtCampCreateDetList.dart';
import 'package:community_health_app/screens/camp_approval/model/save_camp_approval_req/TtDistirctCampApproval.dart';
import 'package:community_health_app/screens/camp_approval/model/save_camp_approval_req/TtDistirctCampApprovalDetList.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CampApprovalDetailsScreen extends StatefulWidget {
  final int campApprovalId;

  const CampApprovalDetailsScreen({super.key, required this.campApprovalId});

  @override
  State<CampApprovalDetailsScreen> createState() =>
      _CampApprovalDetailsScreenState();
}

class _CampApprovalDetailsScreenState extends State<CampApprovalDetailsScreen> {
  final CampApprovalController campApprovalController =
      Get.put(CampApprovalController());

  checkInternetAndLoadData() async {
    List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();

    campApprovalController.hasInternet =
        (connectivityResult.contains(ConnectivityResult.mobile) ||
            connectivityResult.contains(ConnectivityResult.wifi));

    if (campApprovalController.hasInternet) {
      campApprovalController.getCampDetails(widget.campApprovalId);
    }

    campApprovalController.update();
  }

  @override
  void initState() {
    // TODO: implement initState
    checkInternetAndLoadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        children: [
          mAppBarV1(
            title: "Camp Approval Details",
            context: context,
            onBackButtonPress: () {
              Get.to(() => const CampApprovalScreen());
            },
          ),
          Expanded(
            child: GetBuilder<CampApprovalController>(
                init: CampApprovalController(),
                builder: (controller) {
                  return campApprovalController.hasInternet
                      ? controller.isLoading
                          ? Container(
                              width: SizeConfig.screenWidth * 0.95,
                              height: SizeConfig.screenHeight * 0.7,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                      responsiveHeight(25))),
                              child: const Center(
                                  child: CircularProgressIndicator()))
                          : Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 8.0, left: 8.0, right: 0.8),
                                  child: Container(
                                    // height: responsiveHeight(100),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              offset: const Offset(0, 0),
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 5)
                                        ],
                                        borderRadius: BorderRadius.circular(
                                            responsiveHeight(20))),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.all(responsiveHeight(20)),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            flex: 3,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: responsiveHeight(10),
                                                ),
                                                RichText(
                                                  text: TextSpan(
                                                    text: "Camp Request ID: ",
                                                    style: TextStyle(
                                                        color: kTextColor,
                                                        fontSize:
                                                            responsiveFont(12),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    children: [
                                                      TextSpan(
                                                          text: controller
                                                                  .campApprovalDetailsModel
                                                                  ?.details
                                                                  ?.ttCampCreate
                                                                  ?.campCreateRequestId
                                                                  .toString() ??
                                                              "",
                                                          style: TextStyle(
                                                              fontSize:
                                                                  responsiveFont(
                                                                      12),
                                                              color: kTextColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal))
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: responsiveHeight(10),
                                                ),
                                                RichText(
                                                  text: TextSpan(
                                                    text: "Location Name: ",
                                                    style: TextStyle(
                                                        color: kTextColor,
                                                        fontSize:
                                                            responsiveFont(12),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    children: [
                                                      TextSpan(
                                                          text: controller
                                                                  .campApprovalDetailsModel
                                                                  ?.details
                                                                  ?.ttCampCreate
                                                                  ?.locationName ??
                                                              "",
                                                          style: TextStyle(
                                                              fontSize:
                                                                  responsiveFont(
                                                                      12),
                                                              color: kTextColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal))
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: responsiveHeight(10),
                                                ),
                                                RichText(
                                                  text: TextSpan(
                                                    text: "District : ",
                                                    style: TextStyle(
                                                        color: kTextColor,
                                                        fontSize:
                                                            responsiveFont(12),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    children: [
                                                      TextSpan(
                                                          text: controller
                                                                  .campApprovalDetailsModel
                                                                  ?.details
                                                                  ?.ttCampCreate
                                                                  ?.districtEn ??
                                                              "",
                                                          style: TextStyle(
                                                              fontSize:
                                                                  responsiveFont(
                                                                      12),
                                                              color: kTextColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal))
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: responsiveHeight(10),
                                                ),
                                                RichText(
                                                  text: TextSpan(
                                                    text: "Stakeholder Name : ",
                                                    style: TextStyle(
                                                        color: kTextColor,
                                                        fontSize:
                                                            responsiveFont(12),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    children: [
                                                      TextSpan(
                                                          text: controller
                                                                  .campApprovalDetailsModel
                                                                  ?.details
                                                                  ?.ttCampCreate
                                                                  ?.stakeholderNameEn ??
                                                              "",
                                                          style: TextStyle(
                                                              fontSize:
                                                                  responsiveFont(
                                                                      12),
                                                              color: kTextColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal))
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: responsiveHeight(10),
                                                ),
                                                RichText(
                                                  text: TextSpan(
                                                    text:
                                                        "Proposed Camp Date-Time : ",
                                                    style: TextStyle(
                                                        color: kTextColor,
                                                        fontSize:
                                                            responsiveFont(12),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    children: [
                                                      TextSpan(
                                                          text: controller
                                                                  .campApprovalDetailsModel
                                                                  ?.details
                                                                  ?.ttCampCreate
                                                                  ?.propCampDate ??
                                                              "",
                                                          style: TextStyle(
                                                              fontSize:
                                                                  responsiveFont(
                                                                      12),
                                                              color: kTextColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal))
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: responsiveHeight(10),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                controller.campApprovalDetailsModel!.details!
                                        .ttCampCreateDetList!.isNotEmpty
                                    ? Expanded(
                                        child: ListView.builder(
                                            itemCount: controller
                                                .campApprovalDetailsModel
                                                ?.details
                                                ?.ttCampCreateDetList
                                                ?.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8.0,
                                                    left: 8.0,
                                                    right: 0.8),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      boxShadow: [
                                                        BoxShadow(
                                                            offset:
                                                                const Offset(
                                                                    0, 0),
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.5),
                                                            spreadRadius: 1,
                                                            blurRadius: 5)
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              responsiveHeight(
                                                                  20))),
                                                  child: Padding(
                                                    padding: EdgeInsets.all(
                                                        responsiveHeight(20)),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Flexible(
                                                          flex: 3,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
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
                                                                          "User ID: ",
                                                                      style: TextStyle(
                                                                          color:
                                                                              kTextColor,
                                                                          fontSize: responsiveFont(
                                                                              12),
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                      children: [
                                                                        TextSpan(
                                                                            text: controller.campApprovalDetailsModel?.details?.ttCampCreateDetList?[index].userId.toString() ??
                                                                                "",
                                                                            style: TextStyle(
                                                                                fontSize: responsiveFont(12),
                                                                                color: kTextColor,
                                                                                fontWeight: FontWeight.normal))
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width:
                                                                        responsiveHeight(
                                                                            20),
                                                                  ),
                                                                  RichText(
                                                                    text:
                                                                        TextSpan(
                                                                      text:
                                                                          "User Name: ",
                                                                      style: TextStyle(
                                                                          color:
                                                                              kTextColor,
                                                                          fontSize: responsiveFont(
                                                                              12),
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                      children: [
                                                                        TextSpan(
                                                                            text: controller.campApprovalDetailsModel?.details?.ttCampCreateDetList?[index].lookupDetDescEn ??
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
                                                              SizedBox(
                                                                height:
                                                                    responsiveHeight(
                                                                        10),
                                                              ),
                                                              RichText(
                                                                text: TextSpan(
                                                                  text:
                                                                      "Full Name : ",
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
                                                                        text: controller
                                                                            .campApprovalDetailsModel
                                                                            ?.details
                                                                            ?.ttCampCreateDetList?[
                                                                                index]
                                                                            .userLogin,
                                                                        style: TextStyle(
                                                                            fontSize: responsiveFont(
                                                                                12),
                                                                            color:
                                                                                kTextColor,
                                                                            fontWeight:
                                                                                FontWeight.normal))
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height:
                                                                    responsiveHeight(
                                                                        10),
                                                              ),
                                                              RichText(
                                                                text: TextSpan(
                                                                  text:
                                                                      "Designation/Member Type : ",
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
                                                                        text: controller.campApprovalDetailsModel?.details?.ttCampCreateDetList?[index].stakeholderNameEn ??
                                                                            '',
                                                                        style: TextStyle(
                                                                            fontSize: responsiveFont(
                                                                                12),
                                                                            color:
                                                                                kTextColor,
                                                                            fontWeight:
                                                                                FontWeight.normal))
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height:
                                                                    responsiveHeight(
                                                                        10),
                                                              ),
                                                              RichText(
                                                                text: TextSpan(
                                                                  text:
                                                                      "Mobile No : ",
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
                                                                        text: controller.campApprovalDetailsModel?.details?.ttCampCreateDetList?[index].userMobileNumber ??
                                                                            "",
                                                                        style: TextStyle(
                                                                            fontSize: responsiveFont(
                                                                                12),
                                                                            color:
                                                                                kTextColor,
                                                                            fontWeight:
                                                                                FontWeight.normal))
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height:
                                                                    responsiveHeight(
                                                                        10),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                      )
                                    : Center(
                                        child: const Text("No Data")
                                            .paddingOnly(top: 40),
                                      ),
                                // const Spacer(),
                                Visibility(
                                  visible: controller.campApprovalDetailsModel!
                                      .details!.ttCampCreateDetList!.isNotEmpty,
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Flexible(
                                            flex: 1,
                                            child: AppButton(
                                              title: "Approve",
                                              onTap: () {
                                                controller
                                                        .saveCampApprovalReqModel
                                                        .ttDistirctCampApproval =
                                                    TtDistirctCampApproval();
                                                controller
                                                        .saveCampApprovalReqModel
                                                        .ttDistirctCampApproval
                                                        ?.confirmCampDate =
                                                    convertToDate(controller
                                                            .campApprovalDetailsModel
                                                            ?.details
                                                            ?.ttCampCreate
                                                            ?.propCampDate ??
                                                        "");
                                                controller
                                                        .saveCampApprovalReqModel
                                                        .ttDistirctCampApproval
                                                        ?.distirctCampApprovalId =
                                                    null;
                                                controller
                                                        .saveCampApprovalReqModel
                                                        .ttDistirctCampApproval
                                                        ?.campCreateRequestId =
                                                    controller
                                                        .campApprovalDetailsModel
                                                        ?.details
                                                        ?.ttCampCreate
                                                        ?.campCreateRequestId;
                                                controller
                                                    .saveCampApprovalReqModel
                                                    .ttDistirctCampApproval
                                                    ?.status = 1;
                                                controller
                                                    .saveCampApprovalReqModel
                                                    .ttDistirctCampApproval
                                                    ?.orgId = 1;

                                                TtDistirctCampApprovalDetList
                                                    ttDistrictCampApproval =
                                                    TtDistirctCampApprovalDetList();

                                                controller
                                                    .saveCampApprovalReqModel
                                                    .ttDistirctCampApprovalDetList = [];
                                                for (TtCampCreateDetList item
                                                    in controller
                                                            .campApprovalDetailsModel
                                                            ?.details
                                                            ?.ttCampCreateDetList ??
                                                        []) {
                                                  controller
                                                      .saveCampApprovalReqModel
                                                      .ttDistirctCampApprovalDetList
                                                      ?.add(TtDistirctCampApprovalDetList(
                                                          distirctCampApprovalDetId:
                                                              null,
                                                          distirctCampApprovalId:
                                                              null,
                                                          stakeholderMasterIdRef:
                                                              1,
                                                          acceptedYN: '',
                                                          suggestedDate: controller
                                                                  .campApprovalDetailsModel
                                                                  ?.details
                                                                  ?.ttCampCreate
                                                                  ?.propCampDate ??
                                                              "",
                                                          orgId: 1,
                                                          status: 1,
                                                          isInactive: null));
                                                }

                                                controller
                                                    .saveCampApprovalDetails();
                                              },
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
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                      : InternetIssue(
                          onRetryPressed: () {
                            checkInternetAndLoadData();
                          },
                        );
                }),
          )
        ],
      ),
    ));
  }

  String convertToDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    return formattedDate;
  }
}
