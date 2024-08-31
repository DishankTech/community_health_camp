import 'dart:convert';
import 'dart:io';

import 'package:community_health_app/core/common_bloc/bloc/master_data_bloc.dart';
import 'package:community_health_app/core/common_bloc/models/camp_dropdown_list_response_model.dart';
import 'package:community_health_app/core/common_bloc/models/get_master_response_model_with_hier.dart';
import 'package:community_health_app/core/common_bloc/models/master_lookup_det_hier_response_model.dart';
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
import 'package:community_health_app/core/utilities/utilities.dart';
import 'package:community_health_app/core/utilities/validators.dart';
import 'package:community_health_app/screens/camp_creation/camp_creation_controller.dart';
import 'package:community_health_app/screens/doctor_desk/add_treatment_details_screen/add_treatment_details_screen.dart';
import 'package:community_health_app/screens/doctor_desk/doctor_desk_controller.dart';
import 'package:community_health_app/screens/patient_registration/bloc/patient_registration_bloc.dart';
import 'package:community_health_app/screens/patient_registration/models/patient_search_response_model.dart';
import 'package:community_health_app/screens/patient_registration/models/registered_patient_response_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

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
  GlobalKey<FormState> _formKey = GlobalKey();

  final CampCreationController campCreationController =
      Get.put(CampCreationController());
  late TextEditingController _campIDTextController;
  late TextEditingController _campDateTextController;
  late TextEditingController _genderTextController;
  late TextEditingController _mobileNoTextController;
  late TextEditingController _mobileNoCountryCodeTextController;
  late TextEditingController _patientNameTextController;
  late TextEditingController _ageTextController;
  late TextEditingController _diseaseTypeTextController;

  late TextEditingController _aadhaarNoTextController;
  late TextEditingController _abhaIDTextController;
  late TextEditingController _addressTextController;
  late TextEditingController _pincodeTextController;
  late TextEditingController _divisionTextController;
  late TextEditingController _districtTextController;
  late TextEditingController _talukaTextController;
  late TextEditingController _cityTextController;
  late TextEditingController _stakeholderSubTypeTextController;
  late TextEditingController _referToTextController;
  late TextEditingController _referToDepartmentTextController;
  late TextEditingController _locationNameController;

  LookupDet? _selectedDivision = null;
  LookupDet? _selectedGender = null;
  LookupDetHierarchical? _selectedDistrict = null;
  LookupDetHierDetails? _selectedTaluka = null;
  LookupDetHierDetails? _selectedCity = null;
  DateTime? _selectedCampDate;
  PatientData? patientDetails;
  PatientSearchData? patientSearchDetails;
  LookupDet? _selectedDiseaseType = null;
  LookupDet? _selectedReferToDepartmentType = null;
  LookupDetHierarchical? _selectedStakeholderSubType;
  CampDetails? _selectedCamp;

  final DoctorDeskController doctorDeskController =
      Get.put(DoctorDeskController());

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
    if (doctorDeskController.hasInternet) {
      doctorDeskController.getStakHolder();
      doctorDeskController.getUserList();
    }

    doctorDeskController.update();
  }

  @override
  void initState() {
    checkInternetAndLoadData();

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
    _diseaseTypeTextController = TextEditingController();
    _stakeholderSubTypeTextController = TextEditingController();
    _diseaseTypeTextController = TextEditingController();
    _referToTextController = TextEditingController();
    _referToDepartmentTextController = TextEditingController();
    _locationNameController = TextEditingController();
    _ageTextController = TextEditingController();
    _divisionTextController = TextEditingController();
    _mobileNoCountryCodeTextController = TextEditingController();

    _mobileNoCountryCodeTextController.text = "+91";

    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        patientDetails =
            ModalRoute.of(context)!.settings.arguments as PatientData;
        if (patientDetails != null) {
          _campIDTextController.text =
              patientDetails!.campCreateRequestId != null
                  ? patientDetails!.campCreateRequestId.toString()
                  : '';
          _patientNameTextController.text = patientDetails!.patientName ?? '';
          _ageTextController.text =
              patientDetails!.age != null ? patientDetails!.age.toString() : '';
          _campDateTextController.text = patientDetails!.campDate ?? '';
          if (patientDetails!.campDate != null) {
            DateFormat(Utilities.dateFormatYYYYMMDD())
                .format(DateTime.parse(patientDetails!.campDate!));
          }
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
          // _pincodeTextController.text = patientDetails!.pinCode ?? '';
          _districtTextController.text = patientDetails!
                      .lookupDetHierIdDistrict !=
                  null
              ? districtResponse!.details![0].lookupDet!
                  .firstWhere((e) =>
                      e.lookupDetId == patientDetails!.lookupDetHierIdDistrict)
                  .lookupDetDescEn!
              : '';
          _talukaTextController.text = patientDetails!.lookupDetHierIdTaluka !=
                  null
              ? talukaResponse!.details![0].lookupDet!
                  .firstWhere((e) =>
                      e.lookupDetId == patientDetails!.lookupDetHierIdTaluka)
                  .lookupDetDescEn!
              : '';
          _cityTextController.text = patientDetails!.lookupDetHierIdCity != null
              ? cityResponse!.details![0].lookupDet!
                  .firstWhere((e) =>
                      e.lookupDetId == patientDetails!.lookupDetHierIdCity)
                  .lookupDetDescEn!
              : '';
        }
        setState(() {});
      } catch (e) {
        print(e);

        patientSearchDetails =
            ModalRoute.of(context)!.settings.arguments as PatientSearchData;
        _campIDTextController.text =
            patientSearchDetails!.campCreateRequestId != null
                ? patientSearchDetails!.campCreateRequestId.toString()
                : '';
        _patientNameTextController.text =
            patientSearchDetails!.patientName ?? '';
        _ageTextController.text = patientSearchDetails!.age != null
            ? patientSearchDetails!.age.toString()
            : '';
        _campDateTextController.text = patientSearchDetails!.campDate ?? '';
        if (patientSearchDetails!.campDate != null) {
          DateFormat(Utilities.dateFormatYYYYMMDD())
              .format(DateTime.parse(patientSearchDetails!.campDate!));
        }
        _genderTextController.text =
            patientSearchDetails!.lookupDetIdGender != null
                ? genderResponse != null
                    ? genderResponse!.details![0].lookupDet!
                        .firstWhere((e) =>
                            e.lookupDetId ==
                            patientSearchDetails!.lookupDetIdGender)
                        .lookupDetDescEn!
                    : ''
                : '';
        _mobileNoTextController.text =
            patientSearchDetails!.contactNumber ?? '';
        _aadhaarNoTextController.text = patientSearchDetails!.addharCard ?? '';
        _abhaIDTextController.text = patientSearchDetails!.abhaCard ?? '';
        _addressTextController.text = '';
        // _pincodeTextController.text = patientSearchDetails!.pinCode ?? '';
        _districtTextController.text =
            patientSearchDetails!.lookupDetHierIdDistrict != null
                ? districtResponse != null
                    ? districtResponse!.details![0].lookupDet!
                        .firstWhere((e) =>
                            e.lookupDetId ==
                            patientSearchDetails!.lookupDetHierIdDistrict)
                        .lookupDetDescEn!
                    : ''
                : '';
        _talukaTextController.text =
            patientSearchDetails!.lookupDetHierIdTaluka != null
                ? talukaResponse != null
                    ? talukaResponse!.details![0].lookupDet!
                        .firstWhere((e) =>
                            e.lookupDetId ==
                            patientSearchDetails!.lookupDetHierIdTaluka)
                        .lookupDetDescEn!
                    : ''
                : '';
        _cityTextController.text =
            patientSearchDetails!.lookupDetHierIdCity != null
                ? cityResponse != null
                    ? cityResponse!.details![0].lookupDet!
                        .firstWhere((e) =>
                            e.lookupDetId ==
                            patientSearchDetails!.lookupDetHierIdCity)
                        .lookupDetDescEn!
                    : ''
                : '';
        setState(() {});
      }
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
    _diseaseTypeTextController.dispose();
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
          var res = jsonDecode(state.patientRegistrationResponse);
          if (res['status_code'] == 200) {
            ScaffoldMessenger.of(context)
              ..clearSnackBars()
              ..showSnackBar(SnackBar(
                content: Text(res['message']),
                backgroundColor: Colors.green,
                duration: const Duration(seconds: 2),
              ));
            context.read<PatientRegistrationBloc>().add(GetPatientListRequest(
                    payload: const {
                      "total_pages": 1,
                      "page": 1,
                      "total_count": 1,
                      "per_page": 100,
                      "data": ""
                    }));

            Navigator.pop(context);
          } else {
            ScaffoldMessenger.of(context)
              ..clearSnackBars()
              ..showSnackBar(SnackBar(
                content: Text(res['exception']),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 2),
              ));
          }
        }

        if (state.patientRegistrationStatus.isFailure) {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(SnackBar(
              content: Text(state.patientRegistrationResponse),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 2),
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
              context.read<MasterDataBloc>().add(ResetMasterState());
            });
          }
          if (state.getDiseaseTypeStatus.isSuccess) {
            diseaseTypeBottomSheet(context, (p0) {
              setState(() {
                _selectedDiseaseType = p0;
                _diseaseTypeTextController.text = p0.lookupDetDescEn!;
              });
              context.read<MasterDataBloc>().add(ResetMasterState());
            });
          }
          if (state.getReferToDepartmentStatus.isSuccess) {
            referToDepartmentBottomSheet(context, (p0) {
              setState(() {
                _selectedReferToDepartmentType = p0;
                _referToDepartmentTextController.text = p0.lookupDetDescEn!;
              });
              context.read<MasterDataBloc>().add(ResetMasterState());
            });
          }
          if (state.getStakeholderSubTypeWithLookupCodeStatus.isSuccess) {
            stakeholderSubTypeBottomSheet(context, (p0) {
              setState(() {
                _selectedStakeholderSubType = p0;
                _stakeholderSubTypeTextController.text =
                    p0.lookupDetHierDescEn!;
              });
              doctorDeskController.getReferTo(p0.lookupDetHierId);
              context.read<MasterDataBloc>().add(ResetMasterState());
            });
          }
          if (state.getDivisionListStatus.isSuccess) {
            divisionBottomSheet(context, (p0) {
              setState(() {
                _selectedDivision = p0;
                _divisionTextController.text = p0.lookupDetDescEn!;
              });
              context.read<MasterDataBloc>().add(ResetMasterState());
            });
          }
          if (state.getCampDropdownListStatus.isSuccess) {
            campListDropdownBottomSheet(context, (p0) {
              setState(() {
                _selectedCamp = p0;
                _campIDTextController.text = p0.campCreateRequestId.toString()!;
              });
              context.read<MasterDataBloc>().add(ResetMasterState());
            });
          }
          if (state.getDivisionListStatus.isSuccess) {
            divisionBottomSheet(context, (p0) {
              setState(() {
                _selectedDivision = p0;
                _divisionTextController.text = p0.lookupDetDescEn!;
              });
              context.read<MasterDataBloc>().add(ResetMasterState());
            });
          }

          if (state.getDistrictListStatus.isSuccess) {
            districtBottomSheet(context, (p0) {
              setState(() {
                _selectedDistrict = p0;
                _districtTextController.text = p0.lookupDetHierDescEn!;
              });
              context.read<MasterDataBloc>().add(ResetMasterState());
            });
          }
          if (state.getTalukaListStatus.isSuccess) {
            talukaBottomSheetV1(context, (p0) {
              setState(() {
                _selectedTaluka = p0;
                _talukaTextController.text = p0.lookupDetHierDescEn!;
              });
              context.read<MasterDataBloc>().add(ResetMasterState());
            });
          }
          if (state.getTownListStatus.isSuccess) {
            townBottomSheetV1(context, (p0) {
              setState(() {
                _selectedCity = p0;
                _cityTextController.text = p0.lookupDetHierDescEn!;
              });
              context.read<MasterDataBloc>().add(ResetMasterState());
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
                mAppBarV1(
                    title: "Patient Registration",
                    context: context,
                    onBackButtonPress: () {
                      Navigator.pop(context);
                    }),
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
                      child: Form(
                        key: _formKey,
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
                                  borderRadius: BorderRadius.circular(
                                      responsiveHeight(17)),
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
                                GetBuilder(
                                    init: CampCreationController(),
                                    builder: (controller) {
                                      return AppRoundTextField(
                                        controller: _locationNameController,
                                        inputType: TextInputType.text,
                                        validators:
                                            Validators.validateLocationName,
                                        errorText:
                                            Validators.validateLocationName(
                                                _locationNameController.text),
                                        onChange: (p0) {
                                          setState(() {});
                                        },
                                        onTap: () async {
                                          await locationNameBottomSheet(
                                              context,
                                              (p0) async => {
                                                    controller
                                                            .selectedLocationVal =
                                                        p0.locationName,
                                                    controller
                                                        .selectedLocation = p0,
                                                    _locationNameController
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
                                                  [],
                                              true);
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
                                              getProportionateScreenHeight(20),
                                          width:
                                              getProportionateScreenHeight(20),
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
                                      );
                                    }),
                                SizedBox(
                                  height: responsiveHeight(10),
                                ),
                                AppRoundTextField(
                                  controller: _campIDTextController,
                                  inputType: TextInputType.number,
                                  validators: Validators.validateCampId,
                                  errorText: Validators.validateCampId(
                                      _campIDTextController.text),
                                  onChange: (p0) {
                                    setState(() {});
                                  },
                                  readOnly: true,
                                  onTap: () {
                                    context.read<MasterDataBloc>().add(
                                        GetCampListDropdown(
                                            locationId: campCreationController
                                                .selectedLocation!
                                                .locationMasterId!));
                                  },
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
                                              style:
                                                  TextStyle(color: Colors.red))
                                        ]),
                                  ),
                                  hint: "",
                                  suffix: BlocBuilder<MasterDataBloc,
                                      MasterDataState>(
                                    builder: (context, state) {
                                      return state.getCampDropdownListStatus
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
                                                DatePickerEntryMode
                                                    .calendarOnly,
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
                                              style:
                                                  TextStyle(color: Colors.red))
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
                                BlocBuilder<MasterDataBloc, MasterDataState>(
                                  builder: (context, state) {
                                    return AppRoundTextField(
                                      controller:
                                          _referToDepartmentTextController,
                                      onChange: (p0) {
                                        setState(() {});
                                      },
                                      errorText:
                                          Validators.validateStakeholderSubType(
                                              _referToDepartmentTextController
                                                  .text),
                                      validators:
                                          Validators.validateStakeholderSubType,
                                      inputType: TextInputType.text,
                                      onTap: () {
                                        context.read<MasterDataBloc>().add(
                                                GetReferToDepartment(
                                                    payload: const {
                                                  "lookup_code_list1": [
                                                    {"lookup_code": "DRF"}
                                                  ]
                                                }));
                                      },
                                      readOnly: true,
                                      label: RichText(
                                        text: const TextSpan(
                                            text: 'Refer To Department',
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
                                      suffix: state.getStakeholderSubTypeStatus
                                              .isInProgress
                                          ? SizedBox(
                                              height: responsiveHeight(20),
                                              width: responsiveHeight(20),
                                              child: const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
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
                                            ),
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: responsiveHeight(20),
                                ),

                                AppRoundTextField(
                                  controller: _diseaseTypeTextController,
                                  inputType: TextInputType.text,
                                  onTap: () {
                                    context
                                        .read<MasterDataBloc>()
                                        .add(GetDiseaseTypes(payload: const {
                                          "lookup_code_list1": [
                                            {"lookup_code": "DIS"}
                                          ]
                                        }));
                                  },
                                  onChange: (p0) {},
                                  readOnly: true,
                                  maxLength: 12,
                                  label: RichText(
                                    text: const TextSpan(
                                        text: 'Disease Type',
                                        style: TextStyle(
                                            color: kHintColor,
                                            fontFamily: Montserrat),
                                        children: []),
                                  ),
                                  hint: "",
                                  suffix: BlocBuilder<MasterDataBloc,
                                      MasterDataState>(
                                    builder: (context, state) {
                                      return state
                                              .getDiseaseTypeStatus.isInProgress
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
                                BlocBuilder<MasterDataBloc, MasterDataState>(
                                  builder: (context, state) {
                                    return AppRoundTextField(
                                      controller:
                                          _stakeholderSubTypeTextController,
                                      onChange: (p0) {
                                        setState(() {});
                                      },
                                      errorText:
                                          Validators.validateStakeholderSubType(
                                              _stakeholderSubTypeTextController
                                                  .text),
                                      validators:
                                          Validators.validateStakeholderSubType,
                                      inputType: TextInputType.text,
                                      onTap: () {
                                        context.read<MasterDataBloc>().add(
                                                GetStakeholderSubTypeWithLookupCode(
                                                    payload: const {
                                                  "lookup_det_code_list1":
                                                      const [
                                                    {"lookup_det_code": "SUY"}
                                                  ]
                                                }));
                                      },
                                      readOnly: true,
                                      label: RichText(
                                        text: const TextSpan(
                                            text: 'Stakeholder Sub Type',
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
                                      suffix: state.getStakeholderSubTypeStatus
                                              .isInProgress
                                          ? SizedBox(
                                              height: responsiveHeight(20),
                                              width: responsiveHeight(20),
                                              child: const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
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
                                            ),
                                    );
                                  },
                                ),

                                SizedBox(
                                  height: responsiveHeight(20),
                                ),
                                GetBuilder(
                                    init: DoctorDeskController(),
                                    builder: (controller) => AppRoundTextField(
                                          controller: _referToTextController,
                                          inputType: TextInputType.text,
                                          onChange: (p0) {},
                                          onTap: () async {
                                            if (_stakeholderSubTypeTextController
                                                .text.isNotEmpty) {
                                              await stakeHolderNameBottomSheet(
                                                  context,
                                                  (p0) => {
                                                        controller
                                                                .selectedStakeHVal =
                                                            p0.lookupDetHierDescEn,
                                                        controller
                                                            .selectedStakeH
                                                            .addIfNotExist(p0),
                                                        _referToTextController
                                                                .text =
                                                            controller
                                                                .selectedStakeH
                                                                .displayText(),
                                                        controller.update()
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
                                        )),

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
                                              GetDistrictList(
                                                  payload: payload));
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
                                                    height:
                                                        responsiveHeight(20),
                                                    width: responsiveHeight(20),
                                                    child: const Center(
                                                        child:
                                                            CircularProgressIndicator()),
                                                  )
                                                : SizedBox(
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
                                              GetTalukaList(
                                                  payload: _selectedDistrict!
                                                      .lookupDetHierId!));
                                        },
                                        suffix: BlocBuilder<MasterDataBloc,
                                            MasterDataState>(
                                          builder: (context, state) {
                                            return state.getTalukaListStatus
                                                    .isInProgress
                                                ? SizedBox(
                                                    height:
                                                        responsiveHeight(20),
                                                    width: responsiveHeight(20),
                                                    child: const Center(
                                                        child:
                                                            CircularProgressIndicator()),
                                                  )
                                                : SizedBox(
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
                                              text: 'Village',
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
                                          context.read<MasterDataBloc>().add(
                                              GetTownList(
                                                  payload: _selectedTaluka!
                                                      .lookupDetHierId!));
                                        },
                                        suffix: BlocBuilder<MasterDataBloc,
                                            MasterDataState>(
                                          builder: (context, state) {
                                            return state.getTownListStatus
                                                    .isInProgress
                                                ? SizedBox(
                                                    height:
                                                        responsiveHeight(20),
                                                    width: responsiveHeight(20),
                                                    child: const Center(
                                                        child:
                                                            CircularProgressIndicator()),
                                                  )
                                                : SizedBox(
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
                                            title: "Update",
                                            iconData: Icon(
                                              Icons.arrow_forward,
                                              color: kWhiteColor,
                                              size: responsiveHeight(24),
                                            ),
                                            onTap: () {
                                              if (_formKey.currentState!
                                                      .validate() ==
                                                  false) {
                                                return;
                                              }
                                              var payload;
                                              if (patientDetails != null) {
                                                payload = {
                                                  "tt_patient_details": {
                                                    "patient_id": patientDetails
                                                        ?.patientId,
                                                    "camp_create_request_id":
                                                        _selectedCamp != null
                                                            ? _selectedCamp
                                                                ?.campCreateRequestId
                                                            : patientDetails
                                                                ?.campCreateRequestId,
                                                    "camp_date": _selectedCampDate !=
                                                            null
                                                        ? DateFormat(Utilities
                                                                .dateFormatYYYYMMDD())
                                                            .format(
                                                                _selectedCampDate!)
                                                        : '',
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
                                                        _ageTextController
                                                            .text),
                                                    "lookup_det_id_gender":
                                                        _selectedGender
                                                            ?.lookupDetId,
                                                    "contact_number":
                                                        _mobileNoTextController
                                                            .text,
                                                    "addhar_card":
                                                        _aadhaarNoTextController
                                                            .text,
                                                    "abha_card": "",
                                                    "lookup_det_hier_id_country":
                                                        1,
                                                    "lookup_det_hier_id_state":
                                                        2,
                                                    "lookup_det_hier_id_district":
                                                        _selectedDistrict !=
                                                                null
                                                            ? _selectedDistrict
                                                                ?.lookupDetHierId
                                                            : patientDetails
                                                                ?.lookupDetHierIdDistrict,
                                                    "lookup_det_hier_id_taluka":
                                                        _selectedTaluka != null
                                                            ? _selectedTaluka
                                                                ?.lookupDetHierId
                                                            : patientDetails
                                                                ?.lookupDetHierIdTaluka,
                                                    "lookup_det_hier_id_city":
                                                        _selectedCity != null
                                                            ? _selectedCity
                                                                ?.lookupDetHierId
                                                            : patientDetails
                                                                ?.lookupDetHierIdCity,
                                                    "lookup_det_id_division":
                                                        null,
                                                    "pin_code":
                                                        _pincodeTextController
                                                            .text,
                                                    "org_id": null,
                                                    "status": 1,
                                                    "lookup_det_id_ref_department":
                                                        _selectedReferToDepartmentType
                                                            ?.lookupDetId,
                                                    "address1":
                                                        _addressTextController
                                                            .text,
                                                    "address2":
                                                        _addressTextController
                                                            .text,
                                                  },
                                                  "tt_patient_ref_list": [
                                                    {
                                                      "patient_refer_id": null,
                                                      "patient_id": null,
                                                      "stakeholder_master_id":
                                                          1,
                                                      "lookup_det_id_ref_department":
                                                          null,
                                                      "lookup_det_hier_id_stakeholder_sub_type2":
                                                          null,
                                                      "org_id": 1,
                                                      "status": 1,
                                                      "is_inactive": null
                                                    }
                                                  ],
                                                  "tt_patient_disease_list": [
                                                    {
                                                      "patient_disease_types_id":
                                                          null,
                                                      "patient_id": null,
                                                      "lookup_det_id_disease_types":
                                                          null,
                                                      "org_id": 1,
                                                      "status": 1,
                                                      "is_inactive": null
                                                    }
                                                  ]
                                                };
                                              } else {
                                                payload = {
                                                  "tt_patient_details": {
                                                    "patient_id": patientDetails
                                                        ?.patientId,
                                                    "camp_create_request_id":
                                                        _selectedCamp != null
                                                            ? _selectedCamp
                                                                ?.campCreateRequestId
                                                            : patientDetails
                                                                ?.campCreateRequestId,
                                                    "camp_date": _selectedCampDate !=
                                                            null
                                                        ? DateFormat(Utilities
                                                                .dateFormatYYYYMMDD())
                                                            .format(
                                                                _selectedCampDate!)
                                                        : '',
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
                                                        _ageTextController
                                                            .text),
                                                    "lookup_det_id_gender":
                                                        _selectedGender
                                                            ?.lookupDetId,
                                                    "contact_number":
                                                        _mobileNoTextController
                                                            .text,
                                                    "addhar_card":
                                                        _aadhaarNoTextController
                                                            .text,
                                                    "abha_card":
                                                        _abhaIDTextController
                                                            .text,
                                                    "lookup_det_hier_id_country":
                                                        1,
                                                    "lookup_det_hier_id_state":
                                                        2,
                                                    "lookup_det_hier_id_district":
                                                        _selectedDistrict !=
                                                                null
                                                            ? _selectedDistrict
                                                                ?.lookupDetHierId
                                                            : patientSearchDetails
                                                                ?.lookupDetHierIdDistrict,
                                                    "lookup_det_hier_id_taluka":
                                                        _selectedTaluka != null
                                                            ? _selectedTaluka
                                                                ?.lookupDetHierId
                                                            : patientSearchDetails
                                                                ?.lookupDetHierIdTaluka,
                                                    "lookup_det_hier_id_city":
                                                        _selectedCity != null
                                                            ? _selectedCity
                                                                ?.lookupDetHierId
                                                            : patientSearchDetails
                                                                ?.lookupDetHierIdCity,
                                                    "lookup_det_id_division":
                                                        null,
                                                    "pin_code":
                                                        _pincodeTextController
                                                            .text,
                                                    "org_id": null,
                                                    "status": 1,
                                                    "lookup_det_id_ref_department":
                                                        _selectedReferToDepartmentType
                                                            ?.lookupDetId,
                                                    "address1":
                                                        _addressTextController
                                                            .text,
                                                    "address2":
                                                        _addressTextController
                                                            .text,
                                                  },
                                                  "tt_patient_ref_list": [
                                                    {
                                                      "patient_refer_id": null,
                                                      "patient_id": null,
                                                      "stakeholder_master_id":
                                                          1,
                                                      "lookup_det_id_ref_department":
                                                          null,
                                                      "lookup_det_hier_id_stakeholder_sub_type2":
                                                          null,
                                                      "org_id": 1,
                                                      "status": 1,
                                                      "is_inactive": null
                                                    }
                                                  ],
                                                  "tt_patient_disease_list": [
                                                    {
                                                      "patient_disease_types_id":
                                                          null,
                                                      "patient_id": null,
                                                      "lookup_det_id_disease_types":
                                                          null,
                                                      "org_id": 1,
                                                      "status": 1,
                                                      "is_inactive": null
                                                    }
                                                  ]
                                                };
                                              }
                                              print(jsonEncode(payload));
                                              context
                                                  .read<
                                                      PatientRegistrationBloc>()
                                                  .add(
                                                      PatientRegistrationRequest(
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
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
