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

class CampCreation extends StatefulWidget {
  const CampCreation({super.key});

  @override
  State<CampCreation> createState() => _CampCreationState();
}

class _CampCreationState extends State<CampCreation> {
  final CampCreationController campCreationController =
      Get.put(CampCreationController());

  DateTime? selectedDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  checkInternetAndLoadData() async {
    List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();

    campCreationController.hasInternet =
        (connectivityResult.contains(ConnectivityResult.mobile) ||
            connectivityResult.contains(ConnectivityResult.wifi));

    if (campCreationController.hasInternet) {
      campCreationController.getLocationName();
      campCreationController.getStakHolder();
      campCreationController.getMemberType();
      campCreationController.getUserList();
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

    campCreationController.stakeHolderController.text = '';

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
                                        offset: const Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 12),
                                    child: Column(
                                      children: [
                                        AppRoundTextField(
                                          controller:
                                              controller.locationNameController,
                                          inputType: TextInputType.text,
                                          onChange: (p0) {},
                                          onTap: () async {
                                            await commonBottomSheet(
                                                context,
                                                (p0) async => {
                                                      controller
                                                              .selectedLocationVal =
                                                          p0.lookupDetHierDescEn,
                                                      controller
                                                          .selectedLocation = p0,
                                                      controller
                                                          .locationNameController
                                                          .text = controller
                                                              .selectedLocationVal ??
                                                          "",
                                                      await controller.getDist(
                                                          controller
                                                              .selectedLocation
                                                              ?.lookupDetHierIdDistrict
                                                              .toString(),
                                                          false),
                                                      controller.update()
                                                    },
                                                "Location name",
                                                controller.locationNameModel
                                                        ?.details ??
                                                    []);
                                          },
                                          // maxLength: 12,
                                          readOnly: true,
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
                                          suffix: SizedBox(
                                            height:
                                                getProportionateScreenHeight(
                                                    20),
                                            width: getProportionateScreenHeight(
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
                                          inputType: TextInputType.text,
                                          onChange: (p0) {},
                                          onTap: () async {
                                            if (controller
                                                        .selectedLocationVal !=
                                                    null &&
                                                controller.distModel?.details !=
                                                    null) {
                                              await commonBottomSheet(
                                                  context,
                                                  (p0) => {
                                                        controller
                                                                .selectedDistVal =
                                                            p0.lookupDetHierDescEn,
                                                        controller
                                                            .selectedDist = p0,
                                                        controller
                                                            .distNameController
                                                            .text = controller
                                                                .selectedDistVal ??
                                                            "",
                                                        controller.update()
                                                      },
                                                  "Dist Name",
                                                  controller
                                                          .distModel?.details ??
                                                      []);
                                            }
                                          },
                                          readOnly: true,
                                          label: RichText(
                                            text: const TextSpan(
                                                text: 'Dist Name',
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
                                            width: getProportionateScreenHeight(
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
                                              controller.stakeHolderController,
                                          inputType: TextInputType.text,
                                          onChange: (p0) {},
                                          onTap: () async {
                                            await commonBottomSheet(
                                                context,
                                                (p0) => {
                                                      controller
                                                              .selectedStakeHVal =
                                                          p0.lookupDetHierDescEn,
                                                      controller
                                                          .selectedStakeH = p0,
                                                      controller
                                                          .stakeHolderController
                                                          .text = controller
                                                              .selectedStakeHVal ??
                                                          "",
                                                      controller.update()
                                                    },
                                                "Stakeholder Type",
                                                controller
                                                        .stakeHolderModel
                                                        ?.details
                                                        ?.first
                                                        .lookupDetHierarchical ??
                                                    []);
                                          },
                                          // maxLength: 12,
                                          readOnly: true,
                                          label: RichText(
                                            text: const TextSpan(
                                                text: 'Stakeholder Type',
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
                                            width: getProportionateScreenHeight(
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
                                          label: RichText(
                                            text: const TextSpan(
                                                text:
                                                    'Proposed camp date & time',
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
                                            width: getProportionateScreenHeight(
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
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: responsiveHeight(10),
                              ),
                              Column(
                                children: controller.campCreationCardList
                                    .asMap()
                                    .entries
                                    .map((entry) {
                                  int index = entry.key;
                                  TtCampCreateDetails cardData = entry.value;
                                  return CamCreationCard(
                                    index: index,
                                    addCard: () {
                                      addCard();
                                    },
                                    removeCard: () {
                                      removeCard(index);
                                    },
                                  );
                                }).toList(),
                              ),
                              SizedBox(
                                height: responsiveHeight(30),
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
                                          campCreationController
                                              .saveCampReqModel
                                              .ttCampCreate = TtCampCreate();
                                          campCreationController
                                              .saveCampReqModel
                                              .ttCampCreate
                                              ?.campCreateRequestId = null;

                                          // campCreationController
                                          //         .saveCampReqModel
                                          //         .ttCampCreate
                                          //         ?.stakeholderMasterId =
                                          //     campCreationController
                                          //         .selectedStakeH
                                          //         ?.lookupDetHierId;

                                          campCreationController
                                              .saveCampReqModel
                                              .ttCampCreate
                                              ?.stakeholderMasterId = 1;

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
                                                      .dateTimeController.text);
                                          campCreationController
                                              .saveCampReqModel
                                              .ttCampCreate
                                              ?.propCampDate = isoFormatDate;

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
                                                  .ttCampCreateDetList =
                                              campCreationController
                                                  .campCreationCardList;

                                          campCreationController
                                              .saveCampCreation();
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

  void addCard() {
    campCreationController.campCreationCardList.add(TtCampCreateDetails());
    setState(() {});
  }

  void removeCard(int index) {
    if (campCreationController.campCreationCardList.length > 1) {
      setState(() {
        campCreationController.campCreationCardList.removeAt(index);
      });
    }
  }

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

class CamCreationCard extends StatefulWidget {
  final Function addCard;
  final Function removeCard;
  final int index;
  const CamCreationCard(
      {super.key,
      required this.addCard,
      required this.removeCard,
      required this.index});

  @override
  State<CamCreationCard> createState() => _CamCreationCardState();
}

class _CamCreationCardState extends State<CamCreationCard> {
  @override
  Widget build(BuildContext context) {
    CampCreationController campCreationController = Get.find();
    TtCampCreateDetails details =
        campCreationController.campCreationCardList[widget.index];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: SizeConfig.screenWidth * 0.95,
        // height: SizeConfig.screenHeight /3,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(responsiveHeight(25)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Shadow color
              spreadRadius: 2, // Spread radius
              blurRadius: 7, // Blur radius
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: responsiveHeight(30),
              ),
              AppRoundTextField(
                key: UniqueKey(),
                initialValue: details.memberType,
                inputStyle: TextStyle(
                    fontSize: responsiveFont(14), color: kTextBlackColor),
                inputType: TextInputType.text,
                onTap: () {
                  commonBottomSheets(
                      context,
                      (p0) => {
                            details.memberType =
                                (p0 as MemberLookupDet).lookupDetDescEn ?? '',
                            details.lookupDetIdType = p0.lookupDetId,
                            setState(() {})
                          },
                      "Designation/Member Type",
                      campCreationController
                              .memberTypeModel?.details?.first.lookupDet ??
                          []);
                },
                readOnly: true,
                label: RichText(
                  text: const TextSpan(
                      text: 'Designation/Member Type',
                      style:
                          TextStyle(color: kHintColor, fontFamily: Montserrat),
                      children: [
                        TextSpan(text: "*", style: TextStyle(color: Colors.red))
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
              AppRoundTextField(
                key: ValueKey('TF3${widget.index}'),
                // controller: campCreationController.userNameController,
                initialValue: details.userName,
                inputStyle: TextStyle(
                    fontSize: responsiveFont(14), color: kTextBlackColor),
                inputType: TextInputType.text,
                onChange: (p0) {
                  details.userName = p0;
                  print("AppRoundTextField: $p0");
                },
                label: RichText(
                  text: const TextSpan(
                      text: 'Full Name',
                      style:
                          TextStyle(color: kHintColor, fontFamily: Montserrat),
                      children: [
                        TextSpan(text: "*", style: TextStyle(color: Colors.red))
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
                      key: UniqueKey(),
                      initialValue: details.selectedCountry,
                      // controller: campCreationController.countryCodeController,
                      inputStyle: TextStyle(
                          fontSize: responsiveFont(14), color: kTextBlackColor),
                      inputType: TextInputType.number,
                      onChange: (p0) {},
                      onTap: () {
                        List<Map<String, dynamic>> list = [
                          {"title": "+91", "id": 1},
                          {"title": "+92", "id": 2}
                        ];
                        commonBottonSheet(
                            context,
                            (p0) => {
                                  details.selectedCountry = p0['title'],
                                  campCreationController.update()
                                  // campCreationController.selectedCountryCode =
                                  //     p0,
                                  // campCreationController
                                  //     .countryCodeController.text =
                                  // campCreationController
                                  //     .selectedCountryCode!['title']
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
                                color: kHintColor, fontFamily: Montserrat),
                            children: [
                              TextSpan(
                                  text: "*",
                                  style: TextStyle(color: Colors.red))
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
                      key: ValueKey('TF1${widget.index}'),
                      initialValue: details.userMobileNumber,
                      // controller: campCreationController.mobileController,
                      inputStyle: TextStyle(
                          fontSize: responsiveFont(14), color: kTextBlackColor),
                      inputType: TextInputType.number,
                      onChange: (p0) {
                        details.userMobileNumber = p0;
                      },
                      maxLength: 10,
                      label: RichText(
                        text: const TextSpan(
                            text: 'Mobile No',
                            style: TextStyle(
                                color: kHintColor, fontFamily: Montserrat),
                            children: [
                              TextSpan(
                                  text: "*",
                                  style: TextStyle(color: Colors.red))
                            ]),
                      ),
                      hint: "",
                    ),
                  )
                ],
              ),
              SizedBox(
                height: responsiveHeight(30),
              ),
              AppRoundTextField(
                initialValue: details.userLogin,
                key: UniqueKey(),
                inputStyle: TextStyle(
                    fontSize: responsiveFont(14), color: kTextBlackColor),
                inputType: TextInputType.text,
                onChange: (p0) {},
                onTap: () {
                  if (campCreationController.userList?.details != null) {
                    userBottomSheet(
                        context,
                        (p0) => {
                              details.userLogin = p0.fullName,
                              details.userId = p0.userId,
                              campCreationController.update()
                              // campCreationController.userController.text =
                              //     p0.fullName,
                              // campCreationController.selectedUser = p0
                            },
                        "User Id",
                        campCreationController.userList?.details ?? []);
                  }
                },
                readOnly: true,
                label: RichText(
                  text: const TextSpan(
                      text: 'User Id',
                      style:
                          TextStyle(color: kHintColor, fontFamily: Montserrat),
                      children: [
                        TextSpan(text: "*", style: TextStyle(color: Colors.red))
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
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 12, right: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      flex: 1,
                      child: AppButton(
                        title: "Create User",
                        onTap: () {
                          createUserBottomSheet(
                              context,
                              (p0) => {},
                              "User Creation",
                              campCreationController.stakeHolderModel?.details
                                      ?.first.lookupDetHierarchical ??
                                  [],
                              campCreationController.stakHolderUserCreation,
                              campCreationController.loginNameUserCreation);
                        },
                        iconData: Icon(
                          Icons.arrow_forward,
                          color: kWhiteColor,
                          size: responsiveHeight(20),
                        ),
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset("assets/icons/add.png"),
                      ),
                      onTap: () {
                        widget.addCard();
                      },
                    ),
                    SizedBox(
                      width: responsiveWidth(10),
                    ),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset("assets/icons/remove.png"),
                      ),
                      onTap: () {
                        widget.removeCard();
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
