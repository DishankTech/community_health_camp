import 'package:community_health_app/core/common_widgets/app_bar_v1.dart';
import 'package:community_health_app/core/common_widgets/app_button.dart';
import 'package:community_health_app/core/common_widgets/app_round_textfield.dart';
import 'package:community_health_app/core/common_widgets/drop_down.dart';
import 'package:community_health_app/core/constants/constants.dart';
import 'package:community_health_app/core/constants/fonts.dart';
import 'package:community_health_app/core/constants/images.dart';
import 'package:community_health_app/core/utilities/no_internet_connectivity.dart';
import 'package:community_health_app/core/utilities/size_config.dart';
import 'package:community_health_app/screens/location_master/controller/location_master_controller.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationMasterScreen extends StatefulWidget {
  const LocationMasterScreen({super.key});

  @override
  State<LocationMasterScreen> createState() => _LocationMasterScreenState();
}

class _LocationMasterScreenState extends State<LocationMasterScreen> {
  final LocationMasterController locationMasterController =
      Get.put(LocationMasterController());

  checkInternetAndLoadData() async {
    List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();
    // setState(() {
    locationMasterController.hasInternet =
        (connectivityResult.contains(ConnectivityResult.mobile) ||
            connectivityResult.contains(ConnectivityResult.wifi));
    // });
    locationMasterController.update();
    if (locationMasterController.hasInternet) {
      await locationMasterController.getDivisionList();
    }
    // setState(() {});
    locationMasterController.update();
  }

  @override
  void initState() {
    // TODO: implement initState
    checkInternetAndLoadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          image:
              DecorationImage(image: AssetImage(patRegBg), fit: BoxFit.fill)),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            mAppBarV1(title: "Location Master", context: context),
            SizedBox(
              height: responsiveHeight(10),
            ),
            GetBuilder<LocationMasterController>(
                init: LocationMasterController(),
                builder: (controller) {
                  return locationMasterController.hasInternet
                      ? controller.isLoading
                          ? Container(
                              width: SizeConfig.screenWidth * 0.95,
                              // height: SizeConfig.screenHeight * 0.7,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                      responsiveHeight(25))),
                              child: const Center(
                                  child: CircularProgressIndicator()))
                          : Container(
                              width: SizeConfig.screenWidth * 0.95,
                              // height: SizeConfig.screenHeight * 0.7,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                      responsiveHeight(25))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: responsiveHeight(20),
                                    ),
                                    AppRoundTextField(
                                      controller:
                                          locationMasterController.locationName,
                                      inputStyle: TextStyle(
                                          fontSize: responsiveFont(14),
                                          color: kTextBlackColor),
                                      inputType: TextInputType.text,
                                      onChange: (p0) {},
                                      maxLength: 12,
                                      label: RichText(
                                        text: const TextSpan(
                                            text: 'Location Name',
                                            style: TextStyle(
                                                color: kHintColor,
                                                fontFamily: Montserrat),
                                            children: [
                                              TextSpan(
                                                  text: "*",
                                                  style: TextStyle(
                                                      color: Colors.red))
                                            ]),
                                      ),
                                      hint: "",
                                    ),
                                    SizedBox(
                                      height: responsiveHeight(20),
                                    ),
                                    AppRoundTextField(
                                      controller:
                                          locationMasterController.contactNo,
                                      inputStyle: TextStyle(
                                          fontSize: responsiveFont(14),
                                          color: kTextBlackColor),
                                      inputType: TextInputType.number,
                                      onChange: (p0) {},
                                      maxLength: 12,
                                      label: RichText(
                                        text: const TextSpan(
                                            text: 'Contact No',
                                            style: TextStyle(
                                                color: kHintColor,
                                                fontFamily: Montserrat),
                                            children: [
                                              TextSpan(
                                                  text: "*",
                                                  style: TextStyle(
                                                      color: Colors.red))
                                            ]),
                                      ),
                                      hint: "",
                                    ),
                                    SizedBox(
                                      height: responsiveHeight(30),
                                    ),
                                    AppRoundTextField(
                                      controller: locationMasterController
                                          .contactPerson,
                                      inputStyle: TextStyle(
                                          fontSize: responsiveFont(14),
                                          color: kTextBlackColor),
                                      inputType: TextInputType.text,
                                      onChange: (p0) {},
                                      maxLength: 12,
                                      label: RichText(
                                        text: const TextSpan(
                                            text: 'Contact Person Name',
                                            style: TextStyle(
                                                color: kHintColor,
                                                fontFamily: Montserrat),
                                            children: [
                                              TextSpan(
                                                  text: "*",
                                                  style: TextStyle(
                                                      color: Colors.red))
                                            ]),
                                      ),
                                      hint: "",
                                    ),
                                    SizedBox(
                                      height: responsiveHeight(30),
                                    ),
                                    AppRoundTextField(
                                      controller:
                                          locationMasterController.emailId,
                                      inputStyle: TextStyle(
                                          fontSize: responsiveFont(14),
                                          color: kTextBlackColor),
                                      inputType: TextInputType.emailAddress,
                                      onChange: (p0) {},
                                      maxLength: 12,
                                      label: RichText(
                                        text: const TextSpan(
                                            text: 'Email Id',
                                            style: TextStyle(
                                                color: kHintColor,
                                                fontFamily: Montserrat),
                                            children: [
                                              TextSpan(
                                                  text: "*",
                                                  style: TextStyle(
                                                      color: Colors.red))
                                            ]),
                                      ),
                                      hint: "",
                                    ),
                                    SizedBox(
                                      height: responsiveHeight(30),
                                    ),
                                    AppRoundTextField(
                                      controller:
                                          locationMasterController.address1,
                                      inputStyle: TextStyle(
                                          fontSize: responsiveFont(14),
                                          color: kTextBlackColor),
                                      inputType: TextInputType.streetAddress,
                                      onChange: (p0) {},
                                      maxLength: 12,
                                      label: RichText(
                                        text: const TextSpan(
                                            text: 'Address 1',
                                            style: TextStyle(
                                                color: kHintColor,
                                                fontFamily: Montserrat),
                                            children: [
                                              TextSpan(
                                                  text: "*",
                                                  style: TextStyle(
                                                      color: Colors.red))
                                            ]),
                                      ),
                                      hint: "",
                                    ),
                                    SizedBox(
                                      height: responsiveHeight(30),
                                    ),
                                    AppRoundTextField(
                                      controller:
                                          locationMasterController.address2,
                                      inputStyle: TextStyle(
                                          fontSize: responsiveFont(14),
                                          color: kTextBlackColor),
                                      inputType: TextInputType.streetAddress,
                                      onChange: (p0) {},
                                      maxLength: 12,
                                      label: RichText(
                                        text: const TextSpan(
                                            text: 'Address 2',
                                            style: TextStyle(
                                                color: kHintColor,
                                                fontFamily: Montserrat),
                                            children: [
                                              TextSpan(
                                                  text: "*",
                                                  style: TextStyle(
                                                      color: Colors.red))
                                            ]),
                                      ),
                                      hint: "",
                                    ),
                                    SizedBox(
                                      height: responsiveHeight(30),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: AppRoundTextField(
                                            controller: locationMasterController
                                                .countryController,
                                            inputStyle: TextStyle(
                                                fontSize: responsiveFont(14),
                                                color: kTextBlackColor),
                                            inputType: TextInputType.number,
                                            onChange: (p0) {},
                                            onTap: () {
                                              commonBottomSheet(
                                                  context,
                                                  (p0) => {
                                                        locationMasterController
                                                                .selectedCountryVal =
                                                            p0.lookupDetDescEn,
                                                        locationMasterController
                                                            .selectedCountry = p0,
                                                        locationMasterController
                                                                .countryController
                                                                .text =
                                                            locationMasterController
                                                                    .selectedCountryVal ??
                                                                "",
                                                        locationMasterController
                                                            .update()
                                                      },
                                                  "Country",
                                                  locationMasterController
                                                          .divisinModel
                                                          ?.details?[0]
                                                          .lookupDet ??
                                                      []);
                                            },
                                            maxLength: 12,
                                            readOnly: true,
                                            label: RichText(
                                              text: const TextSpan(
                                                  text: 'Country',
                                                  style: TextStyle(
                                                      color: kHintColor,
                                                      fontFamily: Montserrat),
                                                  children: [
                                                    TextSpan(
                                                        text: "*",
                                                        style: TextStyle(
                                                            color: Colors.red))
                                                  ]),
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
                                            controller: locationMasterController
                                                .stateController,
                                            inputStyle: TextStyle(
                                                fontSize: responsiveFont(14),
                                                color: kTextBlackColor),
                                            inputType: TextInputType.number,
                                            onChange: (p0) {},
                                            onTap: () {
                                              commonBottomSheet(
                                                  context,
                                                  (p0) => {
                                                        locationMasterController
                                                                .selectedStateVal =
                                                            p0.lookupDetDescEn,
                                                        locationMasterController
                                                            .selectedState = p0,
                                                        locationMasterController
                                                                .stateController
                                                                .text =
                                                            locationMasterController
                                                                    .selectedStateVal ??
                                                                "",
                                                        locationMasterController
                                                            .update()
                                                      },
                                                  "State",
                                                  locationMasterController
                                                          .divisinModel
                                                          ?.details?[0]
                                                          .lookupDet ??
                                                      []);
                                            },
                                            maxLength: 12,
                                            readOnly: true,
                                            label: RichText(
                                              text: const TextSpan(
                                                  text: 'State',
                                                  style: TextStyle(
                                                      color: kHintColor,
                                                      fontFamily: Montserrat),
                                                  children: [
                                                    TextSpan(
                                                        text: "*",
                                                        style: TextStyle(
                                                            color: Colors.red))
                                                  ]),
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
                                      ],
                                    ),
                                    SizedBox(
                                      height: responsiveHeight(30),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: AppRoundTextField(
                                            controller: locationMasterController
                                                .distController,
                                            inputStyle: TextStyle(
                                                fontSize: responsiveFont(14),
                                                color: kTextBlackColor),
                                            inputType: TextInputType.number,
                                            onChange: (p0) {},
                                            onTap: () {
                                              // List<Map<String, dynamic>> list =
                                              //     [
                                              //   {"title": "Hospital", "id": 1},
                                              //   {"title": "NGO", "id": 2},
                                              //   {"title": "STEM", "id": 3},
                                              //   {"title": "USER", "id": 4}
                                              // ];

                                              commonBottomSheet(
                                                  context,
                                                  (p0) => {
                                                        locationMasterController
                                                                .selectedDistVal =
                                                            p0.lookupDetDescEn,
                                                        locationMasterController
                                                            .selectedDist = p0,
                                                        locationMasterController
                                                                .distController
                                                                .text =
                                                            locationMasterController
                                                                    .selectedDistVal ??
                                                                "",
                                                        locationMasterController
                                                            .update()
                                                      },
                                                  "District",
                                                  locationMasterController
                                                          .divisinModel
                                                          ?.details?[0]
                                                          .lookupDet ??
                                                      []);
                                            },
                                            maxLength: 12,
                                            readOnly: true,
                                            label: RichText(
                                              text: const TextSpan(
                                                  text: 'District',
                                                  style: TextStyle(
                                                      color: kHintColor,
                                                      fontFamily: Montserrat),
                                                  children: [
                                                    TextSpan(
                                                        text: "*",
                                                        style: TextStyle(
                                                            color: Colors.red))
                                                  ]),
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
                                            controller: locationMasterController
                                                .talukaController,
                                            inputStyle: TextStyle(
                                                fontSize: responsiveFont(14),
                                                color: kTextBlackColor),
                                            inputType: TextInputType.number,
                                            onChange: (p0) {},
                                            onTap: () {
                                              commonBottomSheet(
                                                  context,
                                                  (p0) => {
                                                        locationMasterController
                                                                .selectedTalukaVal =
                                                            p0.lookupDetDescEn,
                                                        locationMasterController
                                                            .selectedTaluka = p0,
                                                        locationMasterController
                                                                .talukaController
                                                                .text =
                                                            locationMasterController
                                                                    .selectedTalukaVal ??
                                                                "",
                                                        locationMasterController
                                                            .update()
                                                      },
                                                  "Taluka",
                                                  locationMasterController
                                                          .divisinModel
                                                          ?.details?[0]
                                                          .lookupDet ??
                                                      []);
                                            },
                                            maxLength: 12,
                                            readOnly: true,
                                            label: RichText(
                                              text: const TextSpan(
                                                  text: 'Taluka',
                                                  style: TextStyle(
                                                      color: kHintColor,
                                                      fontFamily: Montserrat),
                                                  children: [
                                                    TextSpan(
                                                        text: "*",
                                                        style: TextStyle(
                                                            color: Colors.red))
                                                  ]),
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
                                      ],
                                    ),
                                    SizedBox(
                                      height: responsiveHeight(30),
                                    ),
                                    AppRoundTextField(
                                      controller: locationMasterController
                                          .cityController,
                                      inputStyle: TextStyle(
                                          fontSize: responsiveFont(14),
                                          color: kTextBlackColor),
                                      inputType: TextInputType.number,
                                      onChange: (p0) {},
                                      onTap: () {
                                        commonBottomSheet(
                                            context,
                                            (p0) => {
                                                  locationMasterController
                                                          .selectedCityVal =
                                                      p0.lookupDetDescEn,
                                                  locationMasterController
                                                      .selectedCity = p0,
                                                  locationMasterController
                                                          .cityController.text =
                                                      locationMasterController
                                                              .selectedCityVal ??
                                                          "",
                                                  locationMasterController
                                                      .update(),
                                                },
                                            "City",
                                            locationMasterController
                                                    .divisinModel
                                                    ?.details?[0]
                                                    .lookupDet ??
                                                []);
                                      },
                                      maxLength: 12,
                                      readOnly: true,
                                      label: RichText(
                                        text: const TextSpan(
                                            text: 'City',
                                            style: TextStyle(
                                                color: kHintColor,
                                                fontFamily: Montserrat),
                                            children: [
                                              TextSpan(
                                                  text: "*",
                                                  style: TextStyle(
                                                      color: Colors.red))
                                            ]),
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
                                        Flexible(
                                          flex: 1,
                                          child: AppButton(
                                            onTap: () {
                                              locationMasterController
                                                  .saveLocationMaster();
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
                                    )
                                  ],
                                ),
                              ),
                            )
                      : InternetIssue(
                          onRetryPressed: () {
                            checkInternetAndLoadData();
                          },
                        );
                }),
          ],
        ),
      ),
    ));
  }
}
