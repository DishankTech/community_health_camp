import 'package:community_health_app/core/common_widgets/drop_down.dart';
import 'package:community_health_app/core/utilities/no_internet_connectivity.dart';
import 'package:community_health_app/screens/doctor_desk/doctor_desk_controller.dart';
import 'package:community_health_app/screens/doctor_desk/doctor_desk_patients_screen/doctor_desk_patients_screen.dart';
import 'package:community_health_app/screens/doctor_desk/model/add_treatment_details/tt_patient_doctor_desk.dart';
import 'package:community_health_app/screens/doctor_desk/model/add_treatment_details/tt_patient_doctor_deskRef.dart';
import 'package:community_health_app/screens/doctor_desk/model/doctor_desk_data.dart';
import 'package:community_health_app/screens/doctor_desk/model/refred_to/refer_to_details.dart';
import 'package:community_health_app/screens/doctor_desk/model/search/search_doc_desk_details.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/common_widgets/app_bar_v1.dart';
import '../../../core/common_widgets/app_button.dart';
import '../../../core/common_widgets/app_round_textfield.dart';
import '../../../core/constants/constants.dart';
import '../../../core/constants/fonts.dart';
import '../../../core/constants/images.dart';
import '../../../core/utilities/size_config.dart';

class AddTreatmentDetailsScreen extends StatefulWidget {
  final DoctorDeskData? doctorDeskData;
  final SearchDocDeskDetails? searchedDat;

  const AddTreatmentDetailsScreen(
      {super.key, this.doctorDeskData, this.searchedDat});

  @override
  State<AddTreatmentDetailsScreen> createState() =>
      _AddTreatmentDetailsScreenState();
}

class _AddTreatmentDetailsScreenState extends State<AddTreatmentDetailsScreen> {
  final DoctorDeskController doctorDeskController =
      Get.put(DoctorDeskController());

  TextEditingController txtContro = TextEditingController();

  checkInternetAndLoadData() async {
    List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();

    doctorDeskController.hasInternet =
        (connectivityResult.contains(ConnectivityResult.mobile) ||
            connectivityResult.contains(ConnectivityResult.wifi));

    if (doctorDeskController.hasInternet) {
      doctorDeskController.getStakHolder();
      doctorDeskController.getUserList();
    }

    doctorDeskController.update();
  }

  @override
  void initState() {
    doctorDeskController.stakeHolderTypeController.text = '';
    doctorDeskController.symptomController.text = '';
    doctorDeskController.provisionalDiaController.text = '';
    doctorDeskController.stakeHolderController.text = '';
    doctorDeskController.selectedStakeH.clear();
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
                              title: "Add Treatment Details",
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
                              title: "Add Treatment Details",
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
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 10, 20, 4),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              offset: const Offset(0, 0),
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 5,
                                            )
                                          ],
                                          borderRadius: BorderRadius.circular(
                                            responsiveHeight(20),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                            responsiveHeight(20),
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Flexible(
                                                flex: 1,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.blue),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              responsiveHeight(
                                                                  10))),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            1.0),
                                                    child: Icon(
                                                      Icons.person,
                                                      size:
                                                          responsiveHeight(54),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: responsiveWidth(16),
                                              ),
                                              Flexible(
                                                flex: 3,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    widget.searchedDat == null
                                                        ? Text(
                                                            widget.doctorDeskData
                                                                    ?.patientName ??
                                                                "",
                                                            style: TextStyle(
                                                                fontSize:
                                                                    responsiveFont(
                                                                        14),
                                                                color:
                                                                    kBlackColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))
                                                        : Text(
                                                            widget.searchedDat
                                                                    ?.patientName ??
                                                                "",
                                                            style: TextStyle(
                                                                fontSize:
                                                                    responsiveFont(
                                                                        14),
                                                                color:
                                                                    kBlackColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                    SizedBox(
                                                      height:
                                                          responsiveHeight(10),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                            color: Colors
                                                                .transparent,
                                                            child: Row(
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
                                                                            responsiveFont(
                                                                                12),
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                    children: [
                                                                      TextSpan(
                                                                          text: widget.searchedDat == null
                                                                              ? widget.doctorDeskData?.age
                                                                                  .toString()
                                                                              : widget.searchedDat?.age.toString() ??
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
                                                        Expanded(
                                                          child: Container(
                                                            color: Colors
                                                                .transparent,
                                                            child: Row(
                                                              children: [
                                                                RichText(
                                                                  text:
                                                                      TextSpan(
                                                                    text:
                                                                        "Gender: ",
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
                                                                          text: widget.searchedDat == null
                                                                              ? widget
                                                                                  .doctorDeskData?.gender
                                                                              : widget.searchedDat?.genderDescEn ??
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
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          responsiveHeight(10),
                                                    ),
                                                    RichText(
                                                      text: TextSpan(
                                                        text: "Mobile No: ",
                                                        style: TextStyle(
                                                            color: kTextColor,
                                                            fontSize:
                                                                responsiveFont(
                                                                    12),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        children: [
                                                          TextSpan(
                                                              text: widget.searchedDat ==
                                                                      null
                                                                  ? widget
                                                                      .doctorDeskData
                                                                      ?.contactNumber
                                                                  : widget.searchedDat
                                                                          ?.contactNumber ??
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
                                                                FontWeight
                                                                    .bold),
                                                        children: [
                                                          TextSpan(
                                                            text: widget.searchedDat ==
                                                                    null
                                                                ? "${widget.doctorDeskData?.locationName ?? ""} "
                                                                    "${widget.doctorDeskData?.city ?? ""} "
                                                                    "${widget.doctorDeskData?.destrict ?? ""} "
                                                                    "${widget.doctorDeskData?.taluka ?? ""} "
                                                                    "${widget.doctorDeskData?.state ?? ""}"
                                                                : "${widget.searchedDat?.locationName ?? ""} "
                                                                    "${widget.searchedDat?.cityDescEn ?? ""} "
                                                                    "${widget.searchedDat?.districtDescEn ?? ""} "
                                                                    "${widget.searchedDat?.talukaDescEn ?? ""} "
                                                                    "${widget.searchedDat?.stateDescEn ?? ""}",
                                                            style: TextStyle(
                                                              fontSize:
                                                                  responsiveFont(
                                                                      12),
                                                              color: kTextColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            ),
                                                          ),
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
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 30, 20, 4),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: responsiveHeight(500),
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
                                            responsiveHeight(25),
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 20, 20, 0),
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        12, 0, 12, 0),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  border: Border.all(
                                                    color: kTextFieldBorder,
                                                    width: 1,
                                                  ),
                                                ),
                                                height: 110,
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height:
                                                          responsiveHeight(4),
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      padding: const EdgeInsets
                                                          .fromLTRB(0, 2, 0, 2),
                                                      color: Colors.transparent,
                                                      child: Text(
                                                        "Symptoms",
                                                        style: TextStyle(
                                                          fontSize:
                                                              responsiveFont(
                                                                  12),
                                                          // color: dashboardSubTitle,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                    TextField(
                                                      controller: controller
                                                          .symptomController,
                                                      style: TextStyle(
                                                        fontSize:
                                                            responsiveFont(12),
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                      maxLength: 500,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText: "",
                                                        counterText: "",
                                                        hintStyle: TextStyle(
                                                          fontSize:
                                                              responsiveFont(
                                                                  12),
                                                          // color: dashboardSubTitle,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      keyboardType:
                                                          TextInputType
                                                              .multiline,
                                                      maxLines: null,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 15, 20, 0),
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        12, 0, 12, 0),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  border: Border.all(
                                                    color: kTextFieldBorder,
                                                    width: 1,
                                                  ),
                                                ),
                                                height: 110,
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height:
                                                          responsiveHeight(4),
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      padding: const EdgeInsets
                                                          .fromLTRB(0, 2, 0, 2),
                                                      color: Colors.transparent,
                                                      child: Text(
                                                        "Provisional Diagnosis",
                                                        style: TextStyle(
                                                          fontSize:
                                                              responsiveFont(
                                                                  12),
                                                          // color: dashboardSubTitle,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                    TextField(
                                                      controller: controller
                                                          .provisionalDiaController,
                                                      style: TextStyle(
                                                        fontSize:
                                                            responsiveFont(12),
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                      maxLength: 500,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText: "",
                                                        counterText: "",
                                                        hintStyle: TextStyle(
                                                          fontSize:
                                                              responsiveFont(
                                                                  14),
                                                          // color: dashboardSubTitle,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      keyboardType:
                                                          TextInputType
                                                              .multiline,
                                                      maxLines: null,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 15, 20, 0),
                                              child: AppRoundTextField(
                                                controller: controller
                                                    .stakeHolderTypeController,
                                                inputType: TextInputType.text,
                                                onChange: (p0) {},
                                                onTap: () async {
                                                  await commonBottomSheet(
                                                      context,
                                                      (p0) async => {
                                                            controller
                                                                    .selectedStakeHTypeVal =
                                                                p0.lookupDetHierDescEn,
                                                            controller
                                                                .stakeHolderTypeController
                                                                .text = p0
                                                                    .lookupDetHierDescEn ??
                                                                "",
                                                            await controller
                                                                .getReferTo(p0
                                                                    .lookupDetHierId),
                                                            controller
                                                                .selectedStakeHType = p0,
                                                            controller.update()
                                                          },
                                                      "Stakeholder Subtype",
                                                      controller
                                                              .stakeHolderTypeModel
                                                              ?.details
                                                              ?.first
                                                              .lookupDetHierarchical ??
                                                          [],
                                                      true);
                                                },
                                                // maxLength: 12,
                                                readOnly: true,
                                                label: RichText(
                                                  text: const TextSpan(
                                                      text:
                                                          'Stakeholder Subtype',
                                                      style: TextStyle(
                                                          color: kHintColor,
                                                          fontFamily:
                                                              Montserrat),
                                                      children: [
                                                        TextSpan(
                                                            text: "*",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red))
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
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 15, 20, 0),
                                              child: AppRoundTextField(
                                                controller: controller
                                                    .stakeHolderController,
                                                inputType: TextInputType.text,
                                                onChange: (p0) {},
                                                onTap: () async {
                                                  if (controller
                                                      .stakeHolderTypeController
                                                      .text
                                                      .isNotEmpty) {
                                                    await stakeHolderNameBottomSheet(
                                                        context,
                                                        (p0) => {
                                                              controller
                                                                      .selectedStakeHVal =
                                                                  p0.stakeholderNameEn,
                                                              controller
                                                                  .selectedStakeH
                                                                  .addIfNotExist(
                                                                      p0),
                                                              controller
                                                                      .stakeHolderController
                                                                      .text =
                                                                  controller
                                                                      .selectedStakeH
                                                                      .displayText(),
                                                              controller
                                                                  .update()
                                                            },
                                                        "Refer To",
                                                        controller.referToModel
                                                                ?.details ??
                                                            [],
                                                        true);
                                                  }
                                                },
                                                // maxLength: 12,
                                                readOnly: true,
                                                label: RichText(
                                                  text: const TextSpan(
                                                      text: 'Refer To',
                                                      style: TextStyle(
                                                          color: kHintColor,
                                                          fontFamily:
                                                              Montserrat),
                                                      children: [
                                                        TextSpan(
                                                            text: "*",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red))
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
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 15, 20, 0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: responsiveHeight(80),
                                        color: Colors.transparent,
                                        child: Row(
                                          children: [
                                            Flexible(
                                              flex: 1,
                                              child: AppButton(
                                                onTap: () {
                                                  controller
                                                          .addTreatmentDetailsModel
                                                          .ttPatientDoctorDesk =
                                                      TtPatientDoctorDesk();

                                                  controller
                                                      .addTreatmentDetailsModel
                                                      .ttPatientDoctorDesk
                                                      ?.orgId = 1;
                                                  controller
                                                      .addTreatmentDetailsModel
                                                      .ttPatientDoctorDesk
                                                      ?.status = 1;
                                                  controller
                                                      .addTreatmentDetailsModel
                                                      .ttPatientDoctorDesk
                                                      ?.campCreateRequestId = widget
                                                              .searchedDat ==
                                                          null
                                                      ? widget.doctorDeskData
                                                          ?.campCreateRequestId
                                                      : widget.searchedDat
                                                          ?.campCreateRequestId;
                                                  controller
                                                      .addTreatmentDetailsModel
                                                      .ttPatientDoctorDesk
                                                      ?.patientId = widget
                                                              .searchedDat ==
                                                          null
                                                      ? widget.doctorDeskData
                                                          ?.patientId
                                                      : widget.searchedDat
                                                          ?.patientId;
                                                  controller
                                                      .addTreatmentDetailsModel
                                                      .ttPatientDoctorDesk
                                                      ?.campDate = widget
                                                              .searchedDat ==
                                                          null
                                                      ? widget.doctorDeskData
                                                          ?.campDate
                                                      : widget.searchedDat
                                                              ?.campDate ??
                                                          "";
                                                  controller
                                                      .addTreatmentDetailsModel
                                                      .ttPatientDoctorDesk
                                                      ?.patientDoctorDeskId = null;

                                                  controller
                                                      .addTreatmentDetailsModel
                                                      .ttPatientDoctorDesk
                                                      ?.userId = 1;

                                                  controller
                                                          .addTreatmentDetailsModel
                                                          .ttPatientDoctorDesk
                                                          ?.lookupDetHierIdStakeholderSubType2 =
                                                      controller
                                                          .selectedStakeHType
                                                          ?.lookupDetHierId;

                                                  controller
                                                          .addTreatmentDetailsModel
                                                          .ttPatientDoctorDesk
                                                          ?.symptons =
                                                      controller
                                                          .symptomController
                                                          .text;
                                                  controller
                                                          .addTreatmentDetailsModel
                                                          .ttPatientDoctorDesk
                                                          ?.provisionalDiagnosis =
                                                      controller
                                                          .provisionalDiaController
                                                          .text;

                                                  controller
                                                      .addTreatmentDetailsModel
                                                      .ttPatientDoctorDeskRef = [];
                                                  for (ReferToDetails item
                                                      in controller
                                                          .selectedStakeH) {
                                                    controller
                                                        .addTreatmentDetailsModel
                                                        .ttPatientDoctorDeskRef
                                                        ?.add(TtPatientDoctorDeskRef(
                                                            patientDoctorDeskId:
                                                                null,
                                                            patientDoctorDeskReferId:
                                                                null,
                                                            stakeholderMasterId:
                                                                item.stakeholderMasterId,
                                                            orgId: 1,
                                                            status: 1,
                                                            isInactive: null));
                                                  }

                                                  controller
                                                      .addTreatmentDetails();
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
                                                onTap: () {
                                                  doctorDeskController.stakeHolderTypeController.text = '';
                                                  doctorDeskController.symptomController.text = '';
                                                  doctorDeskController.provisionalDiaController.text = '';
                                                  doctorDeskController.stakeHolderController.text = '';
                                                  doctorDeskController.selectedStakeH.clear();
                                                },
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
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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

extension ListExtensions on List {
  void addIfNotExist(ReferToDetails element,
      {bool Function(ReferToDetails item)? condition}) {
    bool exists;

    if (condition != null) {
      exists = any((item) => condition(item));
    } else {
      exists = contains(element);
    }

    if (!exists) {
      add(element);
    }
  }

  String displayText() {
    return where((item) =>
            item.lookupDetHierDescEn != null) // Filter out null values
        .map((item) => item.stakeholderNameEn!)
        .join(', '); // Joins with a comma and space separator
  }
}
