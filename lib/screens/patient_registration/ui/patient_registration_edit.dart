import 'dart:convert';
import 'dart:io';

import 'package:community_health_app/core/common_bloc/bloc/master_data_bloc.dart';
import 'package:community_health_app/core/common_bloc/models/get_master_response_model_with_hier.dart';
import 'package:community_health_app/core/common_bloc/models/master_response_model.dart';
import 'package:community_health_app/core/common_widgets/address_text_form_field.dart';
import 'package:community_health_app/core/common_widgets/app_bar_v1.dart';
import 'package:community_health_app/core/common_widgets/app_button.dart';
import 'package:community_health_app/core/common_widgets/app_round_textfield.dart';
import 'package:community_health_app/core/common_widgets/app_round_textfield_country_code.dart';
import 'package:community_health_app/core/common_widgets/drop_down.dart';
import 'package:community_health_app/core/constants/constants.dart';
import 'package:community_health_app/core/constants/fonts.dart';
import 'package:community_health_app/core/constants/images.dart';
import 'package:community_health_app/core/routes/app_routes.dart';
import 'package:community_health_app/core/utilities/data_provider.dart';
import 'package:community_health_app/core/utilities/size_config.dart';
import 'package:community_health_app/screens/patient_registration/bloc/patient_registration_bloc.dart';
import 'package:community_health_app/screens/patient_registration/models/registered_patient_response_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class PatientRegistrationEditScreen extends StatefulWidget {
  const PatientRegistrationEditScreen({super.key});

  @override
  State<PatientRegistrationEditScreen> createState() =>
      _PatientRegistrationEditScreenState();
}

class _PatientRegistrationEditScreenState
    extends State<PatientRegistrationEditScreen> {
  XFile? capturedFile;

  late TextEditingController _campIDTextController;
  late TextEditingController _campDateTextController;
  late TextEditingController _genderTextController;
  late TextEditingController _mobileNoTextController;
  late TextEditingController _mobileNoCountryCodeTextController;
  late TextEditingController _patientNameTextController;
  late TextEditingController _ageTextController;

  late TextEditingController _aadhaarNoTextController;
  late TextEditingController _abhaIDTextController;
  late TextEditingController _addressTextController;
  late TextEditingController _pincodeTextController;
  late TextEditingController _divisionTextController;
  late TextEditingController _districtTextController;
  late TextEditingController _talukaTextController;
  late TextEditingController _cityTextController;

  LookupDet? _selectedDivision = null;
  LookupDet? _selectedGender = null;
  LookupDetHierarchical? _selectedDistrict = null;
  LookupDetHierarchical? _selectedTaluka = null;
  LookupDetHierarchical? _selectedCity = null;
  DateTime? _selectedCampDate;
  PatientData? patientDetails;

  Future<XFile?> captureImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? photo = await picker.pickImage(source: ImageSource.camera);

    if (kDebugMode) {
      print(photo?.path);
    }
    setState(() {
      capturedFile = photo;
    });

    return photo;
  }

  @override
  void initState() {
    super.initState();
    _campIDTextController = TextEditingController();
    _campIDTextController = TextEditingController();
    _campDateTextController = TextEditingController();
    _genderTextController = TextEditingController();
    _mobileNoTextController = TextEditingController();
    _aadhaarNoTextController = TextEditingController();
    _abhaIDTextController = TextEditingController();
    _addressTextController = TextEditingController();
    _pincodeTextController = TextEditingController();
    _districtTextController = TextEditingController();
    _talukaTextController = TextEditingController();
    _cityTextController = TextEditingController();
    _patientNameTextController = TextEditingController();
    _ageTextController = TextEditingController();
    _divisionTextController = TextEditingController();
    _mobileNoCountryCodeTextController = TextEditingController();

    _mobileNoCountryCodeTextController.text = "+91";
    _campIDTextController.text = "341324";
    _campDateTextController.text = "12/09/2024";
    _mobileNoTextController.text = "9832838389";

    WidgetsBinding.instance.addPostFrameCallback((_) {
      patientDetails =
          ModalRoute.of(context)!.settings.arguments as PatientData;

      _campIDTextController.text = patientDetails!.campCreateRequestId != null
          ? patientDetails!.campCreateRequestId.toString()
          : '';
      _patientNameTextController.text = patientDetails!.patientName ?? '';
      _ageTextController.text =
          patientDetails!.age != null ? patientDetails!.age.toString() : '';
      _campDateTextController.text = patientDetails!.campDate ?? '';
      _genderTextController.text = patientDetails!.lookupDetIdGender != null
          ? genderResponse!.details![0].lookupDet!
              .firstWhere(
                  (e) => e.lookupDetId == patientDetails!.lookupDetIdGender)
              .lookupDetDescEn!
          : '';
      _mobileNoTextController.text = patientDetails!.contactNumber ?? '';
      _aadhaarNoTextController.text = patientDetails!.addharCard ?? '';
      _abhaIDTextController.text = patientDetails!.abhaCard ?? '';
      _addressTextController.text = '';
      _pincodeTextController.text = patientDetails!.pinCode ?? '';
      _districtTextController.text =
          patientDetails!.lookupDetHierIdDistrict != null
              ? districtResponse!.details![0].lookupDet!
                  .firstWhere((e) =>
                      e.lookupDetId == patientDetails!.lookupDetHierIdDistrict)
                  .lookupDetDescEn!
              : '';
      _talukaTextController.text = patientDetails!.lookupDetHierIdTaluka != null
          ? talukaResponse!.details![0].lookupDet!
              .firstWhere(
                  (e) => e.lookupDetId == patientDetails!.lookupDetHierIdTaluka)
              .lookupDetDescEn!
          : '';
      _cityTextController.text = patientDetails!.lookupDetHierIdCity != null
          ? cityResponse!.details![0].lookupDet!
              .firstWhere(
                  (e) => e.lookupDetId == patientDetails!.lookupDetHierIdCity)
              .lookupDetDescEn!
          : '';
      _patientNameTextController.text = patientDetails!.pinCode ?? '';
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _divisionTextController.dispose();
    _campIDTextController.dispose();
    _campDateTextController.dispose();
    _genderTextController.dispose();
    _mobileNoTextController.dispose();
    _aadhaarNoTextController.dispose();
    _abhaIDTextController.dispose();
    _addressTextController.dispose();
    _pincodeTextController.dispose();
    _districtTextController.dispose();
    _talukaTextController.dispose();
    _cityTextController.dispose();
    _patientNameTextController.dispose();
    _ageTextController.dispose();
    _mobileNoCountryCodeTextController.dispose();
  }

  MasterResponseModel? genderResponse;
  MasterResponseModel? districtResponse;
  MasterResponseModel? talukaResponse;
  MasterResponseModel? cityResponse;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var genderRes =
        context.select((MasterDataBloc bloc) => bloc.state.getGenderResponse);
    var districtSelect = context
        .select((MasterDataBloc bloc) => bloc.state.getDistrictListResponse);
    var talukaSelect = context
        .select((MasterDataBloc bloc) => bloc.state.getTalukaListResponse);
    var citySelect =
        context.select((MasterDataBloc bloc) => bloc.state.getTownListResponse);
    if (genderRes.isNotEmpty) {
      genderResponse = MasterResponseModel.fromJson(jsonDecode(context
          .select((MasterDataBloc bloc) => bloc.state.getGenderResponse)));
    }
    if (districtSelect.isNotEmpty) {
      districtResponse = MasterResponseModel.fromJson(jsonDecode(context.select(
          (MasterDataBloc bloc) => bloc.state.getDistrictListResponse)));
    }

    if (talukaSelect.isNotEmpty) {
      talukaResponse = MasterResponseModel.fromJson(jsonDecode(context
          .select((MasterDataBloc bloc) => bloc.state.getTalukaListResponse)));
    }
    if (citySelect.isNotEmpty) {
      cityResponse = MasterResponseModel.fromJson(jsonDecode(context
          .select((MasterDataBloc bloc) => bloc.state.getTownListResponse)));
    }

    return BlocListener<PatientRegistrationBloc, PatientRegistrationState>(
      listener: (context, state) {
        if (state.patientRegistrationStatus.isSuccess) {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(SnackBar(
              content: Text(state.patientRegistrationResponse),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ));
        }

        if (state.patientRegistrationStatus.isFailure) {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(SnackBar(
              content: Text(state.patientRegistrationResponse),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 2),
            ));
        }
      },
      child: BlocListener<MasterDataBloc, MasterDataState>(
        listener: (context, state) {
          if (state.getGenderStatus.isSuccess) {
            genderBottomSheet(context, (p0) {
              setState(() {
                _selectedGender = p0;
                _genderTextController.text = p0.lookupDetDescEn!;
              });
            });
          }
          if (state.getDivisionListStatus.isSuccess) {
            divisionBottomSheet(context, (p0) {
              setState(() {
                _selectedDivision = p0;
                _divisionTextController.text = p0.lookupDetDescEn!;
              });
            });
          }
          if (state.getDivisionListStatus.isSuccess) {
            divisionBottomSheet(context, (p0) {
              setState(() {
                _selectedDivision = p0;
                _divisionTextController.text = p0.lookupDetDescEn!;
              });
            });
          }

          if (state.getDistrictListStatus.isSuccess) {
            districtBottomSheet(context, (p0) {
              setState(() {
                _selectedDistrict = p0;
                _districtTextController.text = p0.lookupDetHierDescEn!;
              });
            });
          }
          if (state.getTalukaListStatus.isSuccess) {
            talukaBottomSheet(context, (p0) {
              setState(() {
                _selectedTaluka = p0;
                _talukaTextController.text = p0.lookupDetHierDescEn!;
              });
            });
          }
          if (state.getTownListStatus.isSuccess) {
            townBottomSheet(context, (p0) {
              setState(() {
                _selectedCity = p0;
                _cityTextController.text = p0.lookupDetHierDescEn!;
              });
            });
          }
        },
        child: Scaffold(
            body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(patRegBg), fit: BoxFit.fill)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                mAppBarV1(title: "Patient Registration", context: context),
                Padding(
                  padding: EdgeInsets.only(bottom: responsiveHeight(10)),
                  child: Container(
                    width: SizeConfig.screenWidth * 0.95,
                    // height: SizeConfig.screenHeight * 0.85,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(responsiveHeight(25))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: responsiveHeight(30),
                          ),
                          Stack(children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: kRegistrationBgColor,
                                  borderRadius: BorderRadius.circular(
                                      responsiveHeight(135) / 2)),
                              child: capturedFile == null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          responsiveHeight(135) / 2),
                                      child: Icon(
                                        Icons.person,
                                        size: responsiveHeight(135),
                                      ))
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          responsiveHeight(135) / 2),
                                      child: Image.file(
                                        File(capturedFile!.path),
                                        height: responsiveHeight(135),
                                        width: responsiveHeight(135),
                                      ),
                                    ),
                            ),
                            Positioned(
                              right: 0,
                              child: InkWell(
                                splashFactory: InkRipple.splashFactory,
                                borderRadius:
                                    BorderRadius.circular(responsiveHeight(17)),
                                onTap: () async {
                                  captureImage();
                                },
                                child: Ink(
                                  child: Image.asset(
                                    icCameraGreen,
                                    height: responsiveHeight(34),
                                    width: responsiveHeight(34),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                          // SizedBox(height: responsiveHeight(12)),
                          // Text(
                          //   "Patient Name",
                          //   style: TextStyle(
                          //       fontSize: responsiveFont(14),
                          //       fontWeight: FontWeight.w500),
                          // ),
                          SizedBox(
                            height: responsiveHeight(20),
                          ),
                          Column(
                            children: [
                              AppRoundTextField(
                                controller: _campIDTextController,
                                inputType: TextInputType.number,
                                onChange: (p0) {},
                                maxLength: 12,
                                label: RichText(
                                  text: const TextSpan(
                                      text: 'Camp Id',
                                      style: TextStyle(
                                          color: kHintColor,
                                          fontFamily: Montserrat),
                                      children: [
                                        TextSpan(
                                            text: "*",
                                            style: TextStyle(color: Colors.red))
                                      ]),
                                ),
                                hint: "",
                              ),
                              SizedBox(
                                height: responsiveHeight(20),
                              ),
                              AppRoundTextField(
                                controller: _campDateTextController,
                                inputType: TextInputType.number,
                                onChange: (p0) {},
                                readOnly: true,
                                onTap: () {
                                  showDatePicker(
                                          helpText: "Select Camp Date",
                                          context: context,
                                          initialEntryMode:
                                              DatePickerEntryMode.calendarOnly,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime.now()
                                              .add(const Duration(days: 15)))
                                      .then((pickedDate) {
                                    if (pickedDate == null) {
                                      return;
                                    }
                                    setState(() {
                                      _selectedCampDate = pickedDate;
                                      _campDateTextController.text =
                                          DateFormat("dd-MM-yyyy")
                                              .format(pickedDate);
                                    });
                                  });
                                },
                                maxLength: 12,
                                hint: "",
                                label: RichText(
                                  text: const TextSpan(
                                      text: 'Camp Date',
                                      style: TextStyle(
                                          color: kHintColor,
                                          fontFamily: Montserrat),
                                      children: []),
                                ),
                                suffix: SizedBox(
                                  height: responsiveHeight(20),
                                  width: responsiveHeight(20),
                                  child: Center(
                                    child: Image.asset(
                                      icCalendar,
                                      height: responsiveHeight(20),
                                      width: responsiveHeight(20),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: responsiveHeight(20),
                              ),
                              AppRoundTextField(
                                controller: _patientNameTextController,
                                inputType: TextInputType.name,
                                textCapitalization: TextCapitalization.words,
                                onChange: (p0) {},
                                label: RichText(
                                  text: const TextSpan(
                                      text: 'Patient Name',
                                      style: TextStyle(
                                          color: kHintColor,
                                          fontFamily: Montserrat),
                                      children: [
                                        TextSpan(
                                            text: "*",
                                            style: TextStyle(color: Colors.red))
                                      ]),
                                ),
                                hint: "",
                              ),
                              SizedBox(
                                height: responsiveHeight(20),
                              ),
                              AppRoundTextField(
                                controller: _ageTextController,
                                inputType: TextInputType.number,
                                onChange: (p0) {},
                                maxLength: 2,
                                label: RichText(
                                  text: const TextSpan(
                                      text: 'Age',
                                      style: TextStyle(
                                          color: kHintColor,
                                          fontFamily: Montserrat),
                                      children: []),
                                ),
                                hint: "",
                              ),
                              SizedBox(
                                height: responsiveHeight(20),
                              ),
                              AppRoundTextField(
                                controller: _genderTextController,
                                inputType: TextInputType.text,
                                onTap: () {
                                  context
                                      .read<MasterDataBloc>()
                                      .add(GetGenderRequest(payload: const {
                                        "lookup_code_list1": [
                                          {"lookup_code": "GEN"}
                                        ]
                                      }));
                                },
                                onChange: (p0) {},
                                readOnly: true,
                                maxLength: 12,
                                label: RichText(
                                  text: const TextSpan(
                                      text: 'Gender',
                                      style: TextStyle(
                                          color: kHintColor,
                                          fontFamily: Montserrat),
                                      children: []),
                                ),
                                hint: "",
                                suffix: BlocBuilder<MasterDataBloc,
                                    MasterDataState>(
                                  builder: (context, state) {
                                    return state.getGenderStatus.isInProgress
                                        ? SizedBox(
                                            height: responsiveHeight(20),
                                            width: responsiveHeight(20),
                                            child: const Center(
                                                child:
                                                    CircularProgressIndicator()),
                                          )
                                        : SizedBox(
                                            height: responsiveHeight(20),
                                            width: responsiveHeight(20),
                                            child: Center(
                                              child: Image.asset(
                                                icArrowDownOrange,
                                                height: responsiveHeight(20),
                                                width: responsiveHeight(20),
                                              ),
                                            ),
                                          );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: responsiveHeight(20),
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    flex: 2,
                                    child: AppRoundTextFieldCountryCode(
                                      controller:
                                          _mobileNoCountryCodeTextController,
                                      inputType: TextInputType.number,
                                      readOnly: true,
                                      onChange: (p0) {},
                                      maxLength: 4,
                                      label: const SizedBox.shrink(),
                                      hint: "+91",
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
                                    width: responsiveHeight(10),
                                  ),
                                  Flexible(
                                    flex: 5,
                                    child: AppRoundTextField(
                                      controller: _mobileNoTextController,
                                      inputType: TextInputType.number,
                                      onChange: (p0) {},
                                      maxLength: 10,
                                      label: RichText(
                                        text: const TextSpan(
                                            text: 'Mobile',
                                            style: TextStyle(
                                                color: kHintColor,
                                                fontFamily: Montserrat),
                                            children: []),
                                      ),
                                      hint: "",
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: responsiveHeight(20),
                              ),
                              AppRoundTextField(
                                controller: _aadhaarNoTextController,
                                inputType: TextInputType.number,
                                onChange: (p0) {},
                                maxLength: 12,
                                label: RichText(
                                  text: const TextSpan(
                                      text: 'Aadhaar Number',
                                      style: TextStyle(
                                          color: kHintColor,
                                          fontFamily: Montserrat),
                                      children: []),
                                ),
                                hint: "",
                              ),
                              SizedBox(
                                height: responsiveHeight(20),
                              ),
                              AppRoundTextField(
                                controller: _abhaIDTextController,
                                inputType: TextInputType.number,
                                onChange: (p0) {},
                                maxLength: 12,
                                label: RichText(
                                  text: const TextSpan(
                                      text: 'ABHA ID',
                                      style: TextStyle(
                                          color: kHintColor,
                                          fontFamily: Montserrat),
                                      children: []),
                                ),
                                hint: "",
                              ),
                              SizedBox(
                                height: responsiveHeight(20),
                              ),
                              AppRoundTextField(
                                controller: _addressTextController,
                                maxLines: 5,
                                borderRaius: responsiveHeight(20),
                                errorText: null,
                                onChange: (p0) {},
                                inputType: TextInputType.multiline,
                                label: Align(
                                  alignment: Alignment.topLeft,
                                  child: RichText(
                                    text: const TextSpan(
                                        text: 'Address',
                                        style: TextStyle(
                                            color: kHintColor,
                                            fontFamily: Montserrat),
                                        children: []),
                                  ),
                                ),
                                hint: "",
                              ),
                              // SizedBox(
                              //   height: responsiveHeight(20),
                              // ),
                              // AppRoundTextField(
                              //     controller: _divisionTextController,
                              //     textCapitalization: TextCapitalization.none,
                              //     inputType: TextInputType.datetime,
                              //     readOnly: true,
                              //     label: RichText(
                              //       text: const TextSpan(
                              //           text: 'Division',
                              //           style: TextStyle(
                              //               color: kHintColor,
                              //               fontFamily: Montserrat),
                              //           children: []),
                              //     ),
                              //     hint: "",
                              //     onTap: () {
                              //       Map<String, dynamic> payload = {};
                              //       context
                              //           .read<MasterDataBloc>()
                              //           .add(GetDivisionList(payload: const {
                              //             "lookup_code_list1": [
                              //               {"lookup_code": "DIV"}
                              //             ]
                              //           }));
                              //     },
                              //     suffix: BlocBuilder<MasterDataBloc,
                              //         MasterDataState>(
                              //       builder: (context, state) {
                              //         return state
                              //                 .getDivisionListStatus.isInProgress
                              //             ? const Center(
                              //                 child: CircularProgressIndicator())
                              //             : SizedBox(
                              //                 height: responsiveHeight(20),
                              //                 width: responsiveHeight(20),
                              //                 child: Center(
                              //                   child: Image.asset(
                              //                     icArrowDownOrange,
                              //                     height: responsiveHeight(20),
                              //                     width: responsiveHeight(20),
                              //                   ),
                              //                 ),
                              //               );
                              //       },
                              //     )),
                              SizedBox(
                                height: responsiveHeight(20),
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: AppRoundTextField(
                                      controller: _pincodeTextController,
                                      maxLength: 6,
                                      inputType: TextInputType.phone,
                                      label: RichText(
                                        text: const TextSpan(
                                            text: 'Pin code',
                                            style: TextStyle(
                                                color: kHintColor,
                                                fontFamily: Montserrat),
                                            children: []),
                                      ),
                                      hint: "",
                                      onTap: () {},
                                    ),
                                  ),
                                  SizedBox(
                                    width: responsiveHeight(10),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: AppRoundTextField(
                                      controller: _districtTextController,
                                      textCapitalization:
                                          TextCapitalization.none,
                                      inputType: TextInputType.datetime,
                                      readOnly: true,
                                      label: RichText(
                                        text: const TextSpan(
                                            text: 'District',
                                            style: TextStyle(
                                                color: kHintColor,
                                                fontFamily: Montserrat),
                                            children: []),
                                      ),
                                      hint: "",
                                      onTap: () {
                                        // if (_selectedDivision != null) {
                                        var payload = {
                                          "lookup_det_code_list1": [
                                            {"lookup_det_code": "DIS"}
                                          ]
                                        };
                                        context.read<MasterDataBloc>().add(
                                            GetDistrictList(payload: payload));
                                        // } else {
                                        //   ScaffoldMessenger.of(context)
                                        //     ..clearSnackBars()
                                        //     ..showSnackBar(const SnackBar(
                                        //       content: Text(
                                        //           "Please select division first!"),
                                        //       backgroundColor: Colors.amber,
                                        //       duration: Duration(seconds: 2),
                                        //     ));
                                        // }
                                      },
                                      suffix: BlocBuilder<MasterDataBloc,
                                          MasterDataState>(
                                        builder: (context, state) {
                                          return state.getDistrictListStatus
                                                  .isInProgress
                                              ? SizedBox(
                                                  height: responsiveHeight(20),
                                                  width: responsiveHeight(20),
                                                  child: const Center(
                                                      child:
                                                          CircularProgressIndicator()),
                                                )
                                              : SizedBox(
                                                  height: responsiveHeight(20),
                                                  width: responsiveHeight(20),
                                                  child: Center(
                                                    child: Image.asset(
                                                      icArrowDownOrange,
                                                      height:
                                                          responsiveHeight(20),
                                                      width:
                                                          responsiveHeight(20),
                                                    ),
                                                  ),
                                                );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: responsiveHeight(20),
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: AppRoundTextField(
                                      controller: _talukaTextController,
                                      readOnly: true,
                                      maxLength: 10,
                                      inputType: TextInputType.phone,
                                      label: RichText(
                                        text: const TextSpan(
                                            text: 'Taluka',
                                            style: TextStyle(
                                                color: kHintColor,
                                                fontFamily: Montserrat),
                                            children: []),
                                      ),
                                      hint: "",
                                      onTap: () {
                                        var payload = {
                                          "lookup_det_code_list1": [
                                            {"lookup_det_code": "TLK"}
                                          ]
                                        };
                                        context.read<MasterDataBloc>().add(
                                            GetTalukaList(payload: payload));
                                      },
                                      suffix: BlocBuilder<MasterDataBloc,
                                          MasterDataState>(
                                        builder: (context, state) {
                                          return state.getTalukaListStatus
                                                  .isInProgress
                                              ? SizedBox(
                                                  height: responsiveHeight(20),
                                                  width: responsiveHeight(20),
                                                  child: const Center(
                                                      child:
                                                          CircularProgressIndicator()),
                                                )
                                              : SizedBox(
                                                  height: responsiveHeight(20),
                                                  width: responsiveHeight(20),
                                                  child: Center(
                                                    child: Image.asset(
                                                      icArrowDownOrange,
                                                      height:
                                                          responsiveHeight(20),
                                                      width:
                                                          responsiveHeight(20),
                                                    ),
                                                  ),
                                                );
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: responsiveHeight(10),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: AppRoundTextField(
                                      controller: _cityTextController,
                                      textCapitalization:
                                          TextCapitalization.none,
                                      inputType: TextInputType.datetime,
                                      readOnly: true,
                                      label: RichText(
                                        text: const TextSpan(
                                            text: 'City',
                                            style: TextStyle(
                                                color: kHintColor,
                                                fontFamily: Montserrat),
                                            children: []),
                                      ),
                                      hint: "",
                                      onTap: () {
                                        var payload = {
                                          "lookup_det_code_list1": [
                                            {"lookup_det_code": "CTV"}
                                          ]
                                        };
                                        context
                                            .read<MasterDataBloc>()
                                            .add(GetTownList(payload: payload));
                                      },
                                      suffix: BlocBuilder<MasterDataBloc,
                                          MasterDataState>(
                                        builder: (context, state) {
                                          return state.getTownListStatus
                                                  .isInProgress
                                              ? SizedBox(
                                                  height: responsiveHeight(20),
                                                  width: responsiveHeight(20),
                                                  child: const Center(
                                                      child:
                                                          CircularProgressIndicator()),
                                                )
                                              : SizedBox(
                                                  height: responsiveHeight(20),
                                                  width: responsiveHeight(20),
                                                  child: Center(
                                                    child: Image.asset(
                                                      icArrowDownOrange,
                                                      height:
                                                          responsiveHeight(20),
                                                      width:
                                                          responsiveHeight(20),
                                                    ),
                                                  ),
                                                );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: responsiveHeight(30),
                              ),
                              BlocBuilder<PatientRegistrationBloc,
                                  PatientRegistrationState>(
                                builder: (context, state) {
                                  return state.patientRegistrationStatus
                                          .isInProgress
                                      ? const CircularProgressIndicator()
                                      : AppButton(
                                          title: "Register",
                                          iconData: Icon(
                                            Icons.arrow_forward,
                                            color: kWhiteColor,
                                            size: responsiveHeight(24),
                                          ),
                                          onTap: () {
                                            var payload = {
                                              "patient_id":
                                                  patientDetails!.patientId,
                                              "camp_create_request_id":
                                                  _campIDTextController.text,
                                              "camp_date": DateFormat(
                                                      'dd-MM-yyyy')
                                                  .format(_selectedCampDate!),
                                              "user_id_register_by":
                                                  DataProvider()
                                                      .getParsedUserData()!
                                                      .details!
                                                      .last
                                                      .user!
                                                      .userId,
                                              "patient_name":
                                                  _patientNameTextController
                                                      .text,
                                              "age": int.parse(
                                                  _ageTextController.text),
                                              "lookup_det_id_gender":
                                                  _selectedGender!.lookupDetId,
                                              "contact_number":
                                                  _mobileNoTextController.text,
                                              "addhar_card":
                                                  _aadhaarNoTextController.text,
                                              "abha_card": "",
                                              "lookup_det_hier_id_country": 0,
                                              "lookup_det_hier_id_state": 4,
                                              "lookup_det_hier_id_district":
                                                  _selectedDistrict!
                                                      .lookupDetHierId,
                                              "lookup_det_hier_id_taluka":
                                                  _selectedTaluka!
                                                      .lookupDetHierId,
                                              "lookup_det_hier_id_city":
                                                  _selectedCity!
                                                      .lookupDetHierId,
                                              "lookup_det_id_division": 1,
                                              "pin_code":
                                                  _pincodeTextController.text,
                                              "org_id": null,
                                              "status": 1
                                            };
                                            context
                                                .read<PatientRegistrationBloc>()
                                                .add(PatientRegistrationRequest(
                                                    payload: payload));
                                          },
                                        );
                                },
                              ),
                              SizedBox(
                                height: responsiveHeight(30),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
