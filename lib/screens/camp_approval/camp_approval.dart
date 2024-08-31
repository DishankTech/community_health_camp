import 'package:community_health_app/core/common_widgets/app_bar_v1.dart';
import 'package:community_health_app/core/constants/constants.dart';
import 'package:community_health_app/core/constants/images.dart';
import 'package:community_health_app/core/utilities/no_internet_connectivity.dart';
import 'package:community_health_app/core/utilities/size_config.dart';
import 'package:community_health_app/screens/camp_approval/camp_approval_details.dart';
import 'package:community_health_app/screens/camp_approval/controller/camp_approval_controller.dart';
import 'package:community_health_app/screens/camp_approval/model/camp_approval_list/camp_approval_data.dart';
import 'package:community_health_app/screens/dashboard/dashboard.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CampApprovalScreen extends StatefulWidget {
  const CampApprovalScreen({super.key});

  @override
  State<CampApprovalScreen> createState() => _CampApprovalScreenState();
}

class _CampApprovalScreenState extends State<CampApprovalScreen> {
  final CampApprovalController campApprovalController =
  Get.put(CampApprovalController());

  checkInternetAndLoadData() async {
    List<ConnectivityResult> connectivityResult =
    await Connectivity().checkConnectivity();

    campApprovalController.hasInternet =
    (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi));

    if (campApprovalController.hasInternet) {
      campApprovalController.pagingController.refresh();
    }

    campApprovalController.update();
  }

  @override
  void dispose() {
    // campApprovalController.pagingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    campApprovalController.campApprovalList.clear();
    campApprovalController.pagingController = PagingController(firstPageKey: 1);

    campApprovalController.pagingController.addPageRequestListener((pageKey) {
      campApprovalController.fetchPage(pageKey);
    });
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
                  title: "Camp Approval",
                  context: context,
                  onBackButtonPress: () {
                    Get.to(() => const DashboardScreen());
                  },
                  isSearched: campApprovalController.isSearch,
                  searchWidget: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: campApprovalController.searchController,
                      onChanged: (value) async {
                        await campApprovalController.getSearchedData(value);
                      },
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              left: 8, top: 8),
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                            onPressed: () {
                              campApprovalController.isSearch = false;
                              campApprovalController.searchedDataModel = null;
                              campApprovalController.searchController.text = '';

                              campApprovalController.pagingController.refresh();
                              setState(() {});
                            },
                            icon: const Icon(Icons.cancel_presentation),
                          ),
                          hintText: "Search"),
                    ),
                  ),
                  suffix: Visibility(
                    visible: campApprovalController.isSearch == false,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(5),
                        onTap: () {
                          campApprovalController.isSearch = true;
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

              ),
              GetBuilder<CampApprovalController>(
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
                        : Expanded(
                      child: (campApprovalController.searchedDataModel ==
                          null)
                          ? PagedListView<int, CampApprovalData>(
                        pagingController:
                        campApprovalController.pagingController,
                        padding: EdgeInsets.zero,
                        builderDelegate: PagedChildBuilderDelegate<
                            CampApprovalData>(
                          itemBuilder: (context, item, index) =>
                              Stack(children: [
                                Padding(
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
                                              const Offset(0, 0),
                                              color: Colors.grey
                                                  .withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 5)
                                        ],
                                        borderRadius:
                                        BorderRadius.circular(
                                            responsiveHeight(20))),
                                    child: Padding(
                                      padding: EdgeInsets.all(
                                          responsiveHeight(20)),
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                RichText(
                                                  text: TextSpan(
                                                    text:
                                                    "Camp Request ID: ",
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
                                                          text: item
                                                              .campCreateRequestId
                                                              .toString(),
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
                                                  height:
                                                  responsiveHeight(
                                                      10),
                                                ),
                                                RichText(
                                                  text: TextSpan(
                                                    text:
                                                    "Location Name: ",
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
                                                          text:
                                                          item.locationName ??
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
                                                  height:
                                                  responsiveHeight(
                                                      10),
                                                ),
                                                RichText(
                                                  text: TextSpan(
                                                    text: "District : ",
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
                                                          text:
                                                          item.districtEn ??
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
                                                  height:
                                                  responsiveHeight(
                                                      10),
                                                ),
                                                RichText(
                                                  text: TextSpan(
                                                    text:
                                                    "Stakeholder Name : ",
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
                                                          text:
                                                          item
                                                              .stakeholderNameEn ??
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
                                                  height:
                                                  responsiveHeight(
                                                      10),
                                                ),
                                                RichText(
                                                  text: TextSpan(
                                                    text:
                                                    "Proposed Camp Date-Time : ",
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
                                                          text:
                                                          item.propCampDate ??
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
                                ),
                                Positioned(
                                  top: 20,
                                  right: 20,
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius:
                                      BorderRadius.circular(5),
                                      onTap: () {
                                        Get.to(() =>
                                            CampApprovalDetailsScreen(
                                              campApprovalId:
                                              item.campCreateRequestId ??
                                                  0,
                                            ));
                                      },
                                      child: Ink(
                                        child: Image.asset(
                                          icEye,
                                          height: responsiveHeight(24),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                      )
                          : ListView.builder(
                          itemCount: campApprovalController
                              .searchedDataModel?.details?.length,
                          itemBuilder: (context, index) {
                            return Stack(children: [
                              Padding(
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
                                            const Offset(0, 0),
                                            color: Colors.grey
                                                .withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 5)
                                      ],
                                      borderRadius:
                                      BorderRadius.circular(
                                          responsiveHeight(20))),
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                        responsiveHeight(20)),
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
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
                                              RichText(
                                                text: TextSpan(
                                                  text:
                                                  "Camp Request ID: ",
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
                                                        text: campApprovalController
                                                            .searchedDataModel
                                                            ?.details?[
                                                        index]
                                                            .campCreateRequestId
                                                            .toString(),
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
                                                height:
                                                responsiveHeight(
                                                    10),
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                  text:
                                                  "Location Name: ",
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
                                                        text: campApprovalController
                                                            .searchedDataModel
                                                            ?.details?[
                                                        index]
                                                            .locationName ??
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
                                                height:
                                                responsiveHeight(
                                                    10),
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                  text: "District : ",
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
                                                        text: campApprovalController
                                                            .searchedDataModel
                                                            ?.details?[
                                                        index]
                                                            .districtEn ??
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
                                                height:
                                                responsiveHeight(
                                                    10),
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                  text:
                                                  "Stakeholder Name : ",
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
                                                        text: campApprovalController
                                                            .searchedDataModel
                                                            ?.details?[
                                                        index]
                                                            .stakeholderNameEn ??
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
                                                height:
                                                responsiveHeight(
                                                    10),
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                  text:
                                                  "Proposed Camp Date-Time : ",
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
                                                        text: campApprovalController
                                                            .searchedDataModel
                                                            ?.details?[
                                                        index]
                                                            .propCampDate ??
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
                              ),
                              Positioned(
                                top: 20,
                                right: 20,
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius:
                                    BorderRadius.circular(5),
                                    onTap: () {
                                      Get.to(() =>
                                          CampApprovalDetailsScreen(
                                            campApprovalId:
                                            campApprovalController
                                                .searchedDataModel
                                                ?.details?[
                                            index]
                                                .campCreateRequestId ??
                                                0,
                                          ));
                                    },
                                    child: Ink(
                                      child: Image.asset(
                                        icEye,
                                        height: responsiveHeight(24),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]);
                          }),
                    )
                        : InternetIssue(
                      onRetryPressed: () {
                        checkInternetAndLoadData();
                      },
                    );
                  })
            ],
          ),
        ));
  }
}
