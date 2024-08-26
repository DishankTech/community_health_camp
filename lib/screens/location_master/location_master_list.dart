import 'package:community_health_app/core/common_widgets/app_bar_v1.dart';
import 'package:community_health_app/core/constants/constants.dart';
import 'package:community_health_app/core/constants/images.dart';
import 'package:community_health_app/core/utilities/no_internet_connectivity.dart';
import 'package:community_health_app/core/utilities/size_config.dart';
import 'package:community_health_app/screens/dashboard/dashboard.dart';
import 'package:community_health_app/screens/location_master/add_location_master.dart';
import 'package:community_health_app/screens/location_master/controller/location_master_controller.dart';
import 'package:community_health_app/screens/location_master/model/location_master_list/location_list_data.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class LocationMasterList extends StatefulWidget {
  const LocationMasterList({super.key});

  @override
  State<LocationMasterList> createState() => _LocationMasterListState();
}

class _LocationMasterListState extends State<LocationMasterList> {
  final LocationMasterController locationMasterController =
      Get.put(LocationMasterController());

  checkInternetAndLoadData() async {
    List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();

    locationMasterController.hasInternet =
        (connectivityResult.contains(ConnectivityResult.mobile) ||
            connectivityResult.contains(ConnectivityResult.wifi));

    if (locationMasterController.hasInternet) {
      locationMasterController.fetchPage(1);

      locationMasterController.pagingController
          .addPageRequestListener((pageKey) {
        locationMasterController.fetchPage(pageKey);
      });
    }

    locationMasterController.update();
  }

  @override
  void dispose() {
    // locationMasterController.pagingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    locationMasterController.locations.clear();
    locationMasterController.pagingController = PagingController(firstPageKey: 1);

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
            title: "Locations",
            context: context,
            onBackButtonPress: (){
              Get.to(() => const DashboardScreen());
            },
            suffix: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(5),
                onTap: () {
                  // Navigator.pushNamed(context, AppRoutes.addLocationMaster,
                  //     arguments: LocDetails(false, null));
                  Get.to(() => const AddLocationMaster(
                        isView: false,
                        locationId: null,
                      ));
                },
                child: Ink(
                  child: Image.asset(
                    icSquarePlus,
                    height: responsiveHeight(24),
                  ),
                ),
              ),
            ),
          ),
          GetBuilder<LocationMasterController>(
              init: LocationMasterController(),
              builder: (controller) {
                return locationMasterController.hasInternet
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
                            child: PagedListView<int, LocationListData>(
                              pagingController:
                                  locationMasterController.pagingController,
                              builderDelegate:
                                  PagedChildBuilderDelegate<LocationListData>(
                                itemBuilder: (context, item, index) =>
                                    Stack(children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0, left: 8.0, right: 0.8),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                offset: const Offset(0, 0),
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 1,
                                                blurRadius: 5)
                                          ],
                                          borderRadius: BorderRadius.circular(
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
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  RichText(
                                                    text: TextSpan(
                                                      text: "Location Name: ",
                                                      style: TextStyle(
                                                          color: kTextColor,
                                                          fontSize:
                                                              responsiveFont(
                                                                  12),
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      children: [
                                                        TextSpan(
                                                            text: item
                                                                .locationName,
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
                                                        responsiveHeight(10),
                                                  ),
                                                  RichText(
                                                    text: TextSpan(
                                                      text: "Address: ",
                                                      style: TextStyle(
                                                          color: kTextColor,
                                                          fontSize:
                                                              responsiveFont(
                                                                  12),
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      children: [
                                                        TextSpan(
                                                            text: item.address1,
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
                                                        responsiveHeight(10),
                                                  ),

                                                  RichText(
                                                    text: TextSpan(
                                                      text: "Contact No : ",
                                                      style: TextStyle(
                                                          color: kTextColor,
                                                          fontSize:
                                                              responsiveFont(
                                                                  12),
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      children: [
                                                        TextSpan(
                                                            text: item
                                                                .contactNumber,
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
                                                        responsiveHeight(10),
                                                  ),
                                                  RichText(
                                                    text: TextSpan(
                                                      text: "Contact Person : ",
                                                      style: TextStyle(
                                                          color: kTextColor,
                                                          fontSize:
                                                              responsiveFont(
                                                                  12),
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      children: [
                                                        TextSpan(
                                                            text: item
                                                                .contactPersonName,
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
                                                        responsiveHeight(10),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: RichText(
                                                          text: TextSpan(
                                                            text: "District: ",
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
                                                                      .districtDesEn
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
                                                      ),
                                                      SizedBox(
                                                        height:
                                                        responsiveHeight(
                                                            10),
                                                      ),
                                                      Expanded(
                                                        child: RichText(
                                                          text: TextSpan(
                                                            text: "City: ",
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
                                                                      .cityDescEn
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
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height:
                                                    responsiveHeight(10),
                                                  ),

                                                  RichText(
                                                    text: TextSpan(
                                                      text: "Email id : ",
                                                      style: TextStyle(
                                                          color: kTextColor,
                                                          fontSize:
                                                              responsiveFont(
                                                                  12),
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      children: [
                                                        TextSpan(
                                                            text: item.emailId,
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
                                                        responsiveHeight(10),
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
                                          color: Colors.transparent,
                                          child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            onTap: () {
                                              // Navigator.pushNamed(context,
                                              //     AppRoutes.addLocationMaster,
                                              //     arguments: LocDetails(true,
                                              //         item.locationMasterId!));
                                              Get.to(() => AddLocationMaster(
                                                    isView: false,
                                                    isEdit: true,
                                                    locationId:
                                                        item.locationMasterId,
                                                  ));
                                            },
                                            child: Ink(
                                              child: Image.asset(
                                                icEdit,
                                                height: responsiveHeight(24),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: responsiveHeight(10),
                                        ),
                                        Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            onTap: () {
                                              Get.to(() => AddLocationMaster(
                                                    isView: true,
                                                    isEdit: false,
                                                    locationId:
                                                        item.locationMasterId,
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
                                      ],
                                    ),
                                  ),
                                ]),
                              ),
                            ),

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

class LocDetails {
  bool? isView;
  int? locationId;

  LocDetails(this.isView, this.locationId);
}
