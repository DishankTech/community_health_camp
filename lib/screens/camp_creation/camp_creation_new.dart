import 'package:community_health_app/core/common_widgets/app_bar_v1.dart';
import 'package:community_health_app/core/common_widgets/app_button.dart';
import 'package:community_health_app/core/common_widgets/app_round_textfield.dart';
import 'package:community_health_app/core/common_widgets/drop_down.dart';
import 'package:community_health_app/core/constants/constants.dart';
import 'package:community_health_app/core/constants/fonts.dart';
import 'package:community_health_app/core/constants/images.dart';
import 'package:community_health_app/core/utilities/no_internet_connectivity.dart';
import 'package:community_health_app/core/utilities/size_config.dart';
import 'package:community_health_app/screens/camp_creation/camp_creation_controller.dart';
import 'package:community_health_app/screens/camp_creation/model/member_type/member_lookup_det.dart';
import 'package:community_health_app/screens/camp_creation/model/save_camp_req/tt_camp_create.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'model/save_camp_req/tt_camp_create_det_list.dart';

class CampCreationNew extends StatefulWidget {
  const CampCreationNew({super.key});

  @override
  State<CampCreationNew> createState() => _CampCreationNewState();
}

class _CampCreationNewState extends State<CampCreationNew> {
  final CampCreationController campCreationController =
      Get.put(CampCreationController());

  DateTime? selectedDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  final GlobalKey<FormState> _formKey = GlobalKey();

  checkInternetAndLoadData() async {
    List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();

    campCreationController.hasInternet =
        (connectivityResult.contains(ConnectivityResult.mobile) ||
            connectivityResult.contains(ConnectivityResult.wifi));

    if (campCreationController.hasInternet) {
      await campCreationController.getLocationName();
      await campCreationController.getUserCode();
      await campCreationController.getStakHolder();
      await campCreationController.getMemberType();
      await campCreationController.getUserList();
    }

    campCreationController.update();
  }

  @override
  void initState() {
    // TODO: implement initState
    campCreationController.locationNameController.text = '';
    campCreationController.dateTimeController.text = "";
    campCreationController.distNameController.text = "";

    campCreationController.designationType.text = "";
    campCreationController.talukaController.text = "";

    campCreationController.stakeHolderController.text = '';
    campCreationController.userNameController.text = '';
    campCreationController.mobileController.text = '';
    campCreationController.campCreationCardList.clear();
    campCreationController.campCreationCardList.add(TtCampCreateDetails());
    checkInternetAndLoadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // SizeConfig().init(context);
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
        child: GetBuilder<CampCreationController>(
            init: CampCreationController(),
            builder: (controller) {
              return controller.hasInternet
                  ? controller.isLoading
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            mAppBarV1(
                              title: "Camp Creation",
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
                      : SingleChildScrollView(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                mAppBarV1(
                                  title: "Camp Creation",
                                  context: context,
                                  onBackButtonPress: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: SizeConfig.screenWidth * 3,
                                    // height: SizeConfig.screenHeight / 3,

                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                          responsiveHeight(25)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          // Shadow color
                                          spreadRadius: 2,
                                          // Spread radius
                                          blurRadius: 7,
                                          // Blur radius
                                          offset: const Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 12),
                                      child: Column(
                                        children: [
                                          AppRoundTextField(
                                            controller: controller
                                                .locationNameController,
                                            inputType: TextInputType.text,
                                            onChange: (p0) {},
                                            onTap: () async {
                                              await locationNameBottomSheet(
                                                  context,
                                                  (p0) async => {
                                                        controller
                                                                .selectedLocationVal =
                                                            p0.locationName,
                                                        controller
                                                            .selectedLocation = p0,
                                                        controller
                                                            .locationNameController
                                                            .text = controller
                                                                .selectedLocationVal ??
                                                            "",
                                                        controller.update(),
                                                        await controller
                                                            .getStakHoldeName(
                                                          controller
                                                              .selectedLocation
                                                              ?.lookupDetHierIdDistrict
                                                              .toString(),
                                                        ),
                                                        controller
                                                            .distNameController
                                                            .text = controller
                                                                .selectedLocation
                                                                ?.lookupDetHierDescEn ??
                                                            "",
                                                        controller
                                                            .talukaController
                                                            .text = controller
                                                                .selectedLocation
                                                                ?.talukaEn ??
                                                            "",
                                                        controller
                                                                .campCreationCardList[
                                                                    0]
                                                                .memberType =
                                                            campCreationController
                                                                .memberTypeModel
                                                                ?.details
                                                                ?.first
                                                                .lookupDet
                                                                ?.firstWhere((e) =>
                                                                    e.lookupDetDescEn ==
                                                                    "Co-ordinators")
                                                                .lookupDetDescEn,
                                                        // controller.username =
                                                        //     "${controller.locationNameController.text.trim()}"
                                                        //         "${controller.campNumber}",
                                                        controller.update(),
                                                      },
                                                  "Location",
                                                  controller.locationNameModel
                                                          ?.details ??
                                                      [],
                                                  true);
                                            },
                                            // maxLength: 12,
                                            readOnly: true,
                                            validators: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                campCreationController
                                                        .errorLocation =
                                                    'Please select location';
                                                campCreationController.update();
                                                return '';
                                              } else {
                                                campCreationController
                                                    .errorLocation = null;
                                                campCreationController.update();
                                              }

                                              return null;
                                            },
                                            errorText: campCreationController
                                                .errorLocation,
                                            label: RichText(
                                              text: const TextSpan(
                                                  text: 'Location ',
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
                                              height:
                                                  getProportionateScreenHeight(
                                                      20),
                                              width:
                                                  getProportionateScreenHeight(
                                                      20),
                                              child: Center(
                                                child: Image.asset(
                                                  icArrowDownOrange,
                                                  height:
                                                      getProportionateScreenHeight(
                                                          20),
                                                  width:
                                                      getProportionateScreenHeight(
                                                          20),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: responsiveHeight(10),
                                          ),
                                          AppRoundTextField(
                                            controller:
                                                controller.distNameController,
                                            // initialValue: controller.selectedLocation?.lookupDetHierDescEn ?? "",
                                            inputType: TextInputType.text,
                                            onChange: (p0) {},
                                            // onTap: () async {
                                            //   return null;
                                            // },
                                            errorText: campCreationController
                                                .errorDistrict,
                                            validators: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                campCreationController
                                                        .errorDistrict =
                                                    'Please select district';
                                                campCreationController.update();
                                                return '';
                                              } else {
                                                campCreationController
                                                    .errorDistrict = null;
                                                campCreationController.update();
                                              }

                                              return null;
                                            },
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
                                              height:
                                                  getProportionateScreenHeight(
                                                      20),
                                              width:
                                                  getProportionateScreenHeight(
                                                      20),
                                              child: Center(
                                                child: Image.asset(
                                                  icArrowDownOrange,
                                                  height:
                                                      getProportionateScreenHeight(
                                                          20),
                                                  width:
                                                      getProportionateScreenHeight(
                                                          20),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: responsiveHeight(10),
                                          ),
                                          AppRoundTextField(
                                            readOnly: true,
                                            initialValue: controller.campId,
                                            inputStyle: TextStyle(
                                                fontSize: responsiveFont(14),
                                                color: kTextBlackColor),
                                            inputType: TextInputType.text,
                                            onChange: (p0) {},
                                            errorText: campCreationController
                                                .errorCampId,
                                            validators: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                campCreationController
                                                    .errorCampId =
                                                'Please enter campID';
                                                campCreationController.update();
                                                return '';
                                              } else {
                                                campCreationController
                                                    .errorCampId = null;
                                                campCreationController.update();
                                              }

                                              return null;
                                            },
                                            label: RichText(
                                              text: const TextSpan(
                                                  text: 'Camp ID',
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
                                            height: responsiveHeight(10),
                                          ),
                                          AppRoundTextField(
                                            controller:
                                                controller.talukaController,
                                            // initialValue: controller.selectedLocation?.lookupDetHierDescEn ?? "",
                                            inputType: TextInputType.text,
                                            onChange: (p0) {},
                                            onTap: () async {
                                              return null;
                                            },
                                            errorText: campCreationController
                                                .errorTaluka,
                                            validators: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                campCreationController
                                                        .errorTaluka =
                                                    'Please select taluka';
                                                campCreationController.update();
                                                return '';
                                              } else {
                                                campCreationController
                                                    .errorTaluka = null;
                                                campCreationController.update();
                                              }

                                              return null;
                                            },
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
                                              height:
                                                  getProportionateScreenHeight(
                                                      20),
                                              width:
                                                  getProportionateScreenHeight(
                                                      20),
                                              child: Center(
                                                child: Image.asset(
                                                  icArrowDownOrange,
                                                  height:
                                                      getProportionateScreenHeight(
                                                          20),
                                                  width:
                                                      getProportionateScreenHeight(
                                                          20),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: responsiveHeight(10),
                                          ),
                                          AppRoundTextField(
                                            controller: controller
                                                .stakeHolderController,
                                            inputType: TextInputType.text,
                                            onChange: (p0) {},
                                            onTap: () async {
                                              await stakeHolderNameBottomSheet(
                                                  context,
                                                  (p0) => {
                                                        controller
                                                                .selectedStakeHVal =
                                                            p0.stakeholderNameEn,
                                                        controller
                                                            .selectedStakeHName = p0,
                                                        controller
                                                            .stakeHolderController
                                                            .text = controller
                                                                .selectedStakeHVal ??
                                                            "",
                                                        controller.update()
                                                      },
                                                  "Stakeholder Name",
                                                  controller
                                                          .stakeHolderNameModel
                                                          ?.details ??
                                                      [],
                                                  true);
                                            },
                                            // maxLength: 12,
                                            readOnly: true,
                                            errorText: campCreationController
                                                .errorStakeHolder,
                                            validators: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                campCreationController
                                                        .errorStakeHolder =
                                                    'Please select stakeholder';
                                                campCreationController.update();
                                                return '';
                                              } else {
                                                campCreationController
                                                    .errorStakeHolder = null;
                                                campCreationController.update();
                                              }

                                              return null;
                                            },
                                            label: RichText(
                                              text: const TextSpan(
                                                  text: 'Stakeholder Name',
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
                                              height:
                                                  getProportionateScreenHeight(
                                                      20),
                                              width:
                                                  getProportionateScreenHeight(
                                                      20),
                                              child: Center(
                                                child: Image.asset(
                                                  icArrowDownOrange,
                                                  height:
                                                      getProportionateScreenHeight(
                                                          20),
                                                  width:
                                                      getProportionateScreenHeight(
                                                          20),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: responsiveHeight(10),
                                          ),
                                          AppRoundTextField(
                                            controller:
                                                controller.dateTimeController,
                                            inputType: TextInputType.text,
                                            onChange: (p0) {},
                                            onTap: () {
                                              selectDateTime(context);
                                            },
                                            readOnly: true,
                                            errorText: campCreationController
                                                .errorDate,
                                            validators: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                campCreationController
                                                        .errorDate =
                                                    'Please select date';
                                                campCreationController.update();
                                                return '';
                                              } else {
                                                campCreationController
                                                    .errorDate = null;
                                                campCreationController.update();
                                              }

                                              return null;
                                            },
                                            label: RichText(
                                              text: const TextSpan(
                                                  text:
                                                      'Proposed camp date & time',
                                                  style: TextStyle(color: kHintColor, fontFamily: Montserrat),
                                                  children: [
                                                    TextSpan(
                                                        text: "*",
                                                        style: TextStyle(
                                                            color: Colors.red))
                                                  ]),
                                            ),
                                            hint: "",
                                            suffix: SizedBox(
                                              height:
                                                  getProportionateScreenHeight(
                                                      20),
                                              width:
                                                  getProportionateScreenHeight(
                                                      20),
                                              child: Center(
                                                child: Image.asset(
                                                  icCalendar,
                                                  height:
                                                      getProportionateScreenHeight(
                                                          20),
                                                  width:
                                                      getProportionateScreenHeight(
                                                          20),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: responsiveHeight(10),
                                          ),
                                          AppRoundTextField(
                                            initialValue: controller
                                                .campCreationCardList[0]
                                                .memberType,
                                            inputStyle: TextStyle(
                                                fontSize: responsiveFont(14),
                                                color: kTextBlackColor),
                                            inputType: TextInputType.text,
                                            onTap: () {
                                              commonBottomSheets(
                                                  context,
                                                  (p0) => {
                                                        controller
                                                            .campCreationCardList[
                                                                0]
                                                            .memberType = (p0
                                                                    as MemberLookupDet)
                                                                .lookupDetDescEn ??
                                                            '',
                                                        controller
                                                                .campCreationCardList[
                                                                    0]
                                                                .lookupDetIdType =
                                                            p0.lookupDetId,
                                                        setState(() {})
                                                      },
                                                  "Designation/Member Type",
                                                  campCreationController
                                                      .memberTypeList,false);
                                            },
                                            errorText: campCreationController
                                                .errorDesignation,
                                            validators: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                campCreationController
                                                        .errorDesignation =
                                                    'Please select designation';
                                                campCreationController.update();
                                                return '';
                                              } else {
                                                campCreationController
                                                    .errorDesignation = null;
                                                campCreationController.update();
                                              }

                                              return null;
                                            },
                                            readOnly: true,
                                            label: RichText(
                                              text: const TextSpan(
                                                  text:
                                                      'Designation/Member Type',
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
                                            height: responsiveHeight(10),
                                          ),
                                          SizedBox(
                                            height: responsiveHeight(10),
                                          ),
                                          AppRoundTextField(
                                            controller: campCreationController
                                                .userNameController,
                                            // initialValue: controller
                                            //     .campCreationCardList[0].userName,
                                            inputStyle: TextStyle(
                                                fontSize: responsiveFont(14),
                                                color: kTextBlackColor),
                                            inputType: TextInputType.text,
                                            onChange: (p0) {
                                              campCreationController
                                                  .userNameController.text = p0;
                                              print("AppRoundTextField: $p0");
                                              // controller.userNameController.text = p0;
                                            },
                                            errorText: campCreationController
                                                .errorFullName,
                                            validators: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                campCreationController
                                                        .errorFullName =
                                                    'Please enter full name';
                                                campCreationController.update();
                                                return '';
                                              } else {
                                                campCreationController
                                                    .errorFullName = null;
                                                campCreationController.update();
                                              }

                                              return null;
                                            },
                                            label: RichText(
                                              text: const TextSpan(
                                                  text: 'Full Name',
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
                                            height: responsiveHeight(10),
                                          ),
                                          SizedBox(
                                            height: responsiveHeight(10),
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: AppRoundTextField(
                                                  controller: controller
                                                      .countryCodeController,

                                                  inputStyle: TextStyle(
                                                      fontSize:
                                                          responsiveFont(14),
                                                      color: kTextBlackColor),
                                                  inputType:
                                                      TextInputType.number,
                                                  onChange: (p0) {},
                                                  errorText:
                                                      campCreationController
                                                          .errorCountryCode,
                                                  validators: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      campCreationController
                                                              .errorCountryCode =
                                                          'Please select contry code';
                                                      campCreationController
                                                          .update();
                                                      return '';
                                                    } else {
                                                      campCreationController
                                                              .errorCountryCode =
                                                          null;
                                                      campCreationController
                                                          .update();
                                                    }

                                                    return null;
                                                  },
                                                  onTap: () {
                                                    List<Map<String, dynamic>>
                                                        list = [
                                                      {"title": "+91", "id": 1}
                                                    ];
                                                    commonBottonSheet(
                                                        context,
                                                        (p0) => {
                                                              controller
                                                                      .countryCodeController
                                                                      .text =
                                                                  p0['title'],
                                                              // controller.campCreationCardList[0].selectedCountry = p0['title'],
                                                              campCreationController
                                                                  .update()
                                                            },
                                                        "Country Code",
                                                        list);
                                                  },
                                                  // maxLength: 12,
                                                  readOnly: true,
                                                  label: RichText(
                                                    text: const TextSpan(
                                                        text: 'Country Code',
                                                        style: TextStyle(
                                                            color: kHintColor,
                                                            fontFamily:
                                                                Montserrat),
                                                        children: [
                                                          TextSpan(
                                                              text: "*",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red))
                                                        ]),
                                                  ),
                                                  hint: "",
                                                  suffix: SizedBox(
                                                    height:
                                                        responsiveHeight(20),
                                                    width: responsiveHeight(20),
                                                    child: Center(
                                                      child: Image.asset(
                                                        icArrowDownOrange,
                                                        height:
                                                            responsiveHeight(
                                                                20),
                                                        width: responsiveHeight(
                                                            20),
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
                                                  // initialValue: controller
                                                  //     .campCreationCardList[0]
                                                  //     .userMobileNumber,

                                                  controller: controller
                                                      .mobileController,
                                                  inputStyle: TextStyle(
                                                      fontSize:
                                                          responsiveFont(14),
                                                      color: kTextBlackColor),
                                                  inputType:
                                                      TextInputType.number,
                                                  onChange: (p0) {
                                                    // controller
                                                    //     .campCreationCardList[0]
                                                    //     .userMobileNumber = p0;
                                                    controller.mobileController
                                                        .text = p0;
                                                  },

                                                  validators: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      campCreationController
                                                              .errorMobile =
                                                          'Please enter your mobile number';

                                                      campCreationController
                                                          .update();
                                                      return '';
                                                    }
                                                    // else if (RegExp(
                                                    //         r"^(0/91)?[6-9][0-9]{9}")
                                                    //     .hasMatch(value)) {
                                                    //   campCreationController
                                                    //           .errorMobile =
                                                    //       'Please enter a valid 10-digit Indian mobile number';
                                                    //   campCreationController
                                                    //       .update();
                                                    //   return '';
                                                    // }
                                                    else {
                                                      campCreationController
                                                          .errorMobile = null;
                                                      campCreationController
                                                          .update();
                                                    }
                                                    return null; // Validation passed
                                                  },
                                                  errorText:
                                                      campCreationController
                                                          .errorMobile,
                                                  maxLength: 10,
                                                  label: RichText(
                                                    text: const TextSpan(
                                                        text: 'Mobile No',
                                                        style: TextStyle(
                                                            color: kHintColor,
                                                            fontFamily:
                                                                Montserrat),
                                                        children: [
                                                          TextSpan(
                                                              text: "*",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red))
                                                        ]),
                                                  ),
                                                  hint: "",
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: responsiveHeight(10),
                                          ),
                                          AppRoundTextField(
                                            readOnly: true,
                                            initialValue: controller.username,
                                            inputStyle: TextStyle(
                                                fontSize: responsiveFont(14),
                                                color: kTextBlackColor),
                                            inputType: TextInputType.text,
                                            onChange: (p0) {},
                                            errorText: campCreationController
                                                .errorUserName,
                                            validators: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                campCreationController
                                                        .errorUserName =
                                                    'Please enter username';
                                                campCreationController.update();
                                                return '';
                                              } else {
                                                campCreationController
                                                    .errorUserName = null;
                                                campCreationController.update();
                                              }

                                              return null;
                                            },
                                            label: RichText(
                                              text: const TextSpan(
                                                  text: 'Username',
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
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: responsiveHeight(10),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        flex: 1,
                                        child: AppButton(
                                          title: "Save",
                                          onTap: () {
                                            if (_formKey.currentState
                                                    ?.validate() ==
                                                true) {
                                              campCreationController
                                                      .saveCampReqModel
                                                      .ttCampCreate =
                                                  TtCampCreate();
                                              campCreationController
                                                  .saveCampReqModel
                                                  .ttCampCreate
                                                  ?.campCreateRequestId = null;

                                              campCreationController
                                                      .saveCampReqModel
                                                      .ttCampCreate
                                                      ?.stakeholderMasterId =
                                                  controller.selectedStakeHName
                                                      ?.stakeholderMasterId;

                                              campCreationController
                                                      .saveCampReqModel
                                                      .ttCampCreate
                                                      ?.locationMasterId =
                                                  campCreationController
                                                      .selectedLocation
                                                      ?.locationMasterId;

                                              String isoFormatDate =
                                                  convertToIsoFormat(
                                                      campCreationController
                                                          .dateTimeController
                                                          .text);
                                              campCreationController
                                                      .saveCampReqModel
                                                      .ttCampCreate
                                                      ?.propCampDate =
                                                  isoFormatDate;

                                              campCreationController
                                                  .saveCampReqModel
                                                  .ttCampCreate
                                                  ?.orgId = 1;

                                              campCreationController
                                                  .saveCampReqModel
                                                  .ttCampCreate
                                                  ?.status = 1;

                                              campCreationController
                                                  .saveCampReqModel
                                                  .ttCampCreate
                                                  ?.campNumber = controller.campId;

                                              campCreationController
                                                  .saveCampReqModel
                                                  .ttCampCreate
                                                  ?.requestOrCreateFlag = "c";

                                              campCreationController
                                                  .saveCampReqModel
                                                  .ttCampCreateDetList = [];

                                              campCreationController
                                                  .saveCampReqModel
                                                  .ttCampCreateDetList
                                                  ?.add(TtCampCreateDetails(
                                                      campCreateRequestDetId:
                                                          null,
                                                      campCreateRequestId: null,
                                                      lookupDetIdType:
                                                          campCreationController
                                                              .memberTypeList[0]
                                                              ?.lookupDetId,
                                                      userId: controller
                                                          .campCreationCardList[
                                                              0]
                                                          .userId,
                                                      userName:
                                                          controller.username,
                                                      userLogin:
                                                          controller.username,
                                                      userMobileNumber:
                                                          controller
                                                              .mobileController
                                                              .text,
                                                      status: 1,
                                                      isInactive: null));
                                              campCreationController
                                                  .userCreation(
                                                      "${controller.locationNameController.text}"
                                                      "${controller.campNumber}",
                                                      campCreationController
                                                          .userNameController
                                                          .text,
                                                      campCreationController
                                                          .mobileController
                                                          .text,
                                                      campCreationController
                                                          .memberTypeList[0]
                                                          ?.lookupDetId);
                                              campCreationController
                                                  .saveCampCreation();
                                            }
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
                                          title: "Clear",
                                          onTap: () {
                                            campCreationController.locationNameController.text = '';
                                            campCreationController.dateTimeController.text = "";
                                            campCreationController.distNameController.text = "";

                                            campCreationController.designationType.text = "";
                                            campCreationController.talukaController.text = "";

                                            campCreationController.stakeHolderController.text = '';
                                            campCreationController.userNameController.text = '';
                                            campCreationController.mobileController.text = '';
                                            campCreationController.username = '';
                                            campCreationController.campCreationCardList.clear();
                                          },
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
      ),
    );
  }

  // void addCard() {
  //   campCreationController.campCreationCardList.add(TtCampCreateDetails());
  //   setState(() {});
  // }
  //
  // void removeCard(int index) {
  //   if (campCreationController.campCreationCardList.length > 1) {
  //     setState(() {
  //       campCreationController.campCreationCardList.removeAt(index);
  //     });
  //   }
  // }

  String convertToIsoFormat(String dateString) {
    // Split the date and time portions
    final parts = dateString.split('|');
    final datePart = parts[0].trim();
    final timePart = parts[1].trim();

    // Parse the date part
    final parsedDate = DateFormat('d MMM yyyy').parse(datePart);

    // Parse the start time (8.00 am)
    final startTimePart = timePart.split('to')[0].trim();
    final parsedStartTime = DateFormat('h.mm a').parse(startTimePart);

    // Combine date and time into a single DateTime object
    final combinedDateTime = DateTime(
      parsedDate.year,
      parsedDate.month,
      parsedDate.day,
      parsedStartTime.hour,
      parsedStartTime.minute,
    );

    // Format the combined DateTime object into the desired ISO 8601 format
    final isoFormat = combinedDateTime.toUtc().toIso8601String();

    return isoFormat;
  }

  Future<void> selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      // setState(() {
      selectedDate = pickedDate;
      // });
      campCreationController.update();

      final TimeOfDay? pickedStartTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedStartTime != null) {
        // setState(() {
        startTime = pickedStartTime;
        // });
        campCreationController.update();

        final TimeOfDay? pickedEndTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (pickedEndTime != null) {
          // setState(() {
          endTime = pickedEndTime;
          // });
          campCreationController.update();
        }
      }
    }
    getFormattedDateTime();
  }

  String getFormattedDateTime() {
    if (selectedDate != null && startTime != null && endTime != null) {
      final String formattedDate =
          DateFormat('d MMM yyyy').format(selectedDate!);
      final String formattedStartTime = _formatTimeOfDay(startTime!);
      final String formattedEndTime = _formatTimeOfDay(endTime!);
      campCreationController.dateTimeController.text =
          '$formattedDate  |  $formattedStartTime to $formattedEndTime';
      return '$formattedDate  |  $formattedStartTime to $formattedEndTime';
    }
    return 'No date/time selected';
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('h.mm a').format(dt);
  }
}
