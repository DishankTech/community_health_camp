import 'dart:convert';
import 'dart:io';

import 'package:community_health_app/core/common_bloc/bloc/master_data_bloc.dart';
import 'package:community_health_app/core/common_bloc/models/camp_dropdown_list_response_model.dart';
import 'package:community_health_app/core/common_bloc/models/get_master_response_model_with_hier.dart';
import 'package:community_health_app/core/common_bloc/models/master_lookup_det_hier_response_model.dart';
import 'package:community_health_app/core/common_bloc/models/master_response_model.dart';
import 'package:community_health_app/core/common_widgets/app_bar_v1.dart';
import 'package:community_health_app/core/common_widgets/app_button.dart';
import 'package:community_health_app/core/common_widgets/app_round_textfield.dart';
import 'package:community_health_app/core/common_widgets/app_round_textfield_country_code.dart';
import 'package:community_health_app/core/common_widgets/drop_down.dart';
import 'package:community_health_app/core/constants/constants.dart';
import 'package:community_health_app/core/constants/fonts.dart';
import 'package:community_health_app/core/constants/images.dart';
import 'package:community_health_app/core/utilities/data_provider.dart';
import 'package:community_health_app/core/utilities/size_config.dart';
import 'package:community_health_app/core/utilities/validators.dart';
import 'package:community_health_app/screens/camp_creation/camp_creation_controller.dart';
import 'package:community_health_app/screens/camp_creation/model/location/location_name_details.dart';
import 'package:community_health_app/screens/doctor_desk/add_treatment_details_screen/add_treatment_details_screen.dart';
import 'package:community_health_app/screens/doctor_desk/doctor_desk_controller.dart';
import 'package:community_health_app/screens/doctor_desk/model/refred_to/refer_to_details.dart';
import 'package:community_health_app/screens/patient_registration/bloc/patient_registration_bloc.dart';
import 'package:community_health_app/screens/patient_registration/models/refer_to_req_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class PatientRegistrationScreen extends StatefulWidget {
  const PatientRegistrationScreen({super.key});

  @override
  State<PatientRegistrationScreen> createState() =>
      _PatientRegistrationScreenState();
}

class _PatientRegistrationScreenState extends State<PatientRegistrationScreen> {
  XFile? capturedFile;
  GlobalKey<FormState> _formKey = GlobalKey();
  ScrollController scrollController = ScrollController();
  List<Widget> multiSelectionWidgets = [];
  List<Map> multiSelectedItem = [];
  final CampCreationController campCreationController =
      Get.put(CampCreationController());
  late TextEditingController _campIDTextController;
  late TextEditingController _campDateTextController;
  late TextEditingController _genderTextController;
  late TextEditingController _diseaseTypeTextController;
  late TextEditingController _mobileNoTextController;
  late TextEditingController _mobileNoCountryCodeTextController;
  late TextEditingController _patientNameTextController;
  late TextEditingController _investigationTextController;
  late TextEditingController _provisionTextController;
  late TextEditingController _ageTextController;
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

  LookupDet? _selectedDivision = null;
  LookupDet? _selectedGender = null;
  LookupDet? _selectedDiseaseType = null;
  LookupDet? _selectedReferToDepartmentType = null;
  LookupDetHierarchical? _selectedDistrict = null;
  LookupDetHierDetails? _selectedTaluka = null;
  LookupDetHierDetails? _selectedCity = null;
  LocationNameDetails? selectedLocation;
  CampDetails? _selectedCamp;
  LookupDetHierarchical? _selectedStakeholderSubType;

  // DateTime? _selectedCampDate;

  late TextEditingController _locationNameController;

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

  Future<XFile?> pickImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? photo = await picker.pickImage(source: ImageSource.gallery);

    if (kDebugMode) {
      print(photo?.path);
    }
    setState(() {
      capturedFile = photo;
    });

    return photo;
  }

  final DoctorDeskController doctorDeskController =
      Get.put(DoctorDeskController());

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
    _stakeholderSubTypeTextController = TextEditingController();
    _diseaseTypeTextController = TextEditingController();
    _referToTextController = TextEditingController();
    _referToDepartmentTextController = TextEditingController();
    _locationNameController = TextEditingController();
    _investigationTextController = TextEditingController();
    _provisionTextController = TextEditingController();
    _mobileNoCountryCodeTextController.text = "+91";
  }

  @override
  void dispose() {
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
    _stakeholderSubTypeTextController.dispose();
    _diseaseTypeTextController.dispose();
    _referToTextController.dispose();
    _referToDepartmentTextController.dispose();
    _locationNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
            // context.read<PatientRegistrationBloc>().add(GetPatientListRequest(
            //         payload: const {
            //           "total_pages": 1,
            //           "page": 1,
            //           "total_count": 1,
            //           "per_page": 100,
            //           "data": ""
            //         }));

            Navigator.pop(context, "refresh");
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

                DateTime dateTime = DateTime.parse(p0.propCampDate ?? "");

                // Format the DateTime object to the desired format
                // String formattedDate =
                //     DateFormat('dd-MM-yyyy').format(dateTime);

                String formattedDate =
                DateFormat('yyyy-MM-dd').format(dateTime);
                _campDateTextController.text = formattedDate;
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
            controller: scrollController,
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
                  child: Column(
                    children: [
                      Container(
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
                                                    _locationNameController
                                                        .text),
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
                                                locationId:
                                                    campCreationController
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
                                                  style: TextStyle(
                                                      color: Colors.red))
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
                                    SizedBox(
                                      height: responsiveHeight(20),
                                    ),
                                    AppRoundTextField(
                                      controller: _campDateTextController,
                                      inputType: TextInputType.number,
                                      onChange: (p0) {},
                                      readOnly: false,
                                      // onTap: () {
                                      //   showDatePicker(
                                      //           helpText: "Select Camp Date",
                                      //           context: context,
                                      //           initialEntryMode:
                                      //               DatePickerEntryMode
                                      //                   .calendarOnly,
                                      //           initialDate: DateTime.now(),
                                      //           firstDate: DateTime.now(),
                                      //           lastDate: DateTime.now().add(
                                      //               const Duration(days: 15)))
                                      //       .then((pickedDate) {
                                      //     if (pickedDate == null) {
                                      //       return;
                                      //     }
                                      //     setState(() {
                                      //       _selectedCampDate = pickedDate;
                                      //       _campDateTextController.text =
                                      //           DateFormat("dd-MM-yyyy")
                                      //               .format(pickedDate);
                                      //     });
                                      //   });
                                      // },
                                      // maxLength: 12,
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
                                      textCapitalization:
                                          TextCapitalization.words,
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
                                        context.read<MasterDataBloc>().add(
                                                GetGenderRequest(
                                                    payload: const {
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
                                          return state
                                                  .getGenderStatus.isInProgress
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
                                    SizedBox(
                                      height: responsiveHeight(20),
                                    ),
                                    // BlocBuilder<MasterDataBloc,
                                    //     MasterDataState>(
                                    //   builder: (context, state) {
                                    //     return AppRoundTextField(
                                    //       controller:
                                    //           _referToDepartmentTextController,
                                    //       onChange: (p0) {
                                    //         setState(() {});
                                    //       },
                                    //       errorText: Validators
                                    //           .validateStakeholderSubType(
                                    //               _referToDepartmentTextController
                                    //                   .text),
                                    //       validators: Validators
                                    //           .validateStakeholderSubType,
                                    //       inputType: TextInputType.text,
                                    //       onTap: () {
                                    //         context.read<MasterDataBloc>().add(
                                    //                 GetReferToDepartment(
                                    //                     payload: const {
                                    //                   "lookup_code_list1": [
                                    //                     {"lookup_code": "DRF"}
                                    //                   ]
                                    //                 }));
                                    //       },
                                    //       readOnly: true,
                                    //       label: RichText(
                                    //         text: const TextSpan(
                                    //             text: 'Refer To Department',
                                    //             style: TextStyle(
                                    //                 color: kHintColor,
                                    //                 fontFamily: Montserrat),
                                    //             children: [
                                    //               TextSpan(
                                    //                   text: "*",
                                    //                   style: TextStyle(
                                    //                       color: Colors.red))
                                    //             ]),
                                    //       ),
                                    //       hint: "",
                                    //       suffix: state
                                    //               .getStakeholderSubTypeStatus
                                    //               .isInProgress
                                    //           ? SizedBox(
                                    //               height: responsiveHeight(20),
                                    //               width: responsiveHeight(20),
                                    //               child: const Center(
                                    //                 child:
                                    //                     CircularProgressIndicator(),
                                    //               ),
                                    //             )
                                    //           : SizedBox(
                                    //               height: responsiveHeight(20),
                                    //               width: responsiveHeight(20),
                                    //               child: Center(
                                    //                 child: Image.asset(
                                    //                   icArrowDownOrange,
                                    //                   height:
                                    //                       responsiveHeight(20),
                                    //                   width:
                                    //                       responsiveHeight(20),
                                    //                 ),
                                    //               ),
                                    //             ),
                                    //     );
                                    //   },
                                    // ),
                                    // SizedBox(
                                    //   height: responsiveHeight(20),
                                    // ),
                                    AppRoundTextField(
                                      controller: _investigationTextController,
                                      inputType: TextInputType.name,
                                      textCapitalization:
                                          TextCapitalization.words,
                                      onChange: (p0) {},
                                      label: RichText(
                                        text: const TextSpan(
                                            text: 'Investigation',
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
                                      controller: _provisionTextController,
                                      inputType: TextInputType.name,
                                      maxLines: 4,
                                      borderRadius: responsiveHeight(20),
                                      textCapitalization:
                                          TextCapitalization.words,
                                      onChange: (p0) {},
                                      label: RichText(
                                        text: const TextSpan(
                                            text: 'Provision Diagnosis',
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
                                      controller: _diseaseTypeTextController,
                                      inputType: TextInputType.text,
                                      onTap: () {
                                        context.read<MasterDataBloc>().add(
                                                GetDiseaseTypes(payload: const {
                                              "lookup_code_list1": [
                                                {"lookup_code": "DIS"}
                                              ]
                                            }));
                                      },
                                      onChange: (p0) {},
                                      readOnly: true,
                                      // maxLength: 12,
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
                                          return state.getDiseaseTypeStatus
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
                                    SizedBox(
                                      height: responsiveHeight(20),
                                    ),
                                    // BlocBuilder<MasterDataBloc,
                                    //     MasterDataState>(
                                    //   builder: (context, state) {
                                    //     return AppRoundTextField(
                                    //       controller:
                                    //           _stakeholderSubTypeTextController,
                                    //       onChange: (p0) {
                                    //         setState(() {});
                                    //       },
                                    //       errorText: Validators
                                    //           .validateStakeholderSubType(
                                    //               _stakeholderSubTypeTextController
                                    //                   .text),
                                    //       validators: Validators
                                    //           .validateStakeholderSubType,
                                    //       inputType: TextInputType.text,
                                    //       onTap: () {
                                    //         context.read<MasterDataBloc>().add(
                                    //                 GetStakeholderSubTypeWithLookupCode(
                                    //                     payload: const {
                                    //                   "lookup_det_code_list1":
                                    //                       const [
                                    //                     {
                                    //                       "lookup_det_code":
                                    //                           "SUY"
                                    //                     }
                                    //                   ]
                                    //                 }));
                                    //       },
                                    //       readOnly: true,
                                    //       label: RichText(
                                    //         text: const TextSpan(
                                    //             text: 'Stakeholder Sub Type',
                                    //             style: TextStyle(
                                    //                 color: kHintColor,
                                    //                 fontFamily: Montserrat),
                                    //             children: [
                                    //               TextSpan(
                                    //                   text: "*",
                                    //                   style: TextStyle(
                                    //                       color: Colors.red))
                                    //             ]),
                                    //       ),
                                    //       hint: "",
                                    //       suffix: state
                                    //               .getStakeholderSubTypeStatus
                                    //               .isInProgress
                                    //           ? SizedBox(
                                    //               height: responsiveHeight(20),
                                    //               width: responsiveHeight(20),
                                    //               child: const Center(
                                    //                 child:
                                    //                     CircularProgressIndicator(),
                                    //               ),
                                    //             )
                                    //           : SizedBox(
                                    //               height: responsiveHeight(20),
                                    //               width: responsiveHeight(20),
                                    //               child: Center(
                                    //                 child: Image.asset(
                                    //                   icArrowDownOrange,
                                    //                   height:
                                    //                       responsiveHeight(20),
                                    //                   width:
                                    //                       responsiveHeight(20),
                                    //                 ),
                                    //               ),
                                    //             ),
                                    //     );
                                    //   },
                                    // ),
                                    //
                                    // SizedBox(
                                    //   height: responsiveHeight(20),
                                    // ),
                                    //
                                    // GetBuilder(
                                    //     init: DoctorDeskController(),
                                    //     builder: (controller) =>
                                    //         AppRoundTextField(
                                    //           controller:
                                    //               _referToTextController,
                                    //           inputType: TextInputType.text,
                                    //           onChange: (p0) {},
                                    //           onTap: () async {
                                    //             if (_stakeholderSubTypeTextController
                                    //                 .text.isNotEmpty) {
                                    //               await stakeHolderNameBottomSheet(
                                    //                   context,
                                    //                   (p0) => {
                                    //                         controller
                                    //                                 .selectedStakeHVal =
                                    //                             p0.lookupDetHierDescEn,
                                    //                         controller
                                    //                             .selectedStakeH
                                    //                             .addIfNotExist(
                                    //                                 p0),
                                    //                         _referToTextController
                                    //                                 .text =
                                    //                             controller
                                    //                                 .selectedStakeH
                                    //                                 .displayText(),
                                    //                         controller.update()
                                    //                       },
                                    //                   "Refer To",
                                    //                   controller.referToModel
                                    //                           ?.details ??
                                    //                       [],
                                    //                   true);
                                    //             }
                                    //           },
                                    //           // maxLength: 12,
                                    //           readOnly: true,
                                    //           label: RichText(
                                    //             text: const TextSpan(
                                    //                 text: 'Refer To',
                                    //                 style: TextStyle(
                                    //                     color: kHintColor,
                                    //                     fontFamily: Montserrat),
                                    //                 children: [
                                    //                   TextSpan(
                                    //                       text: "*",
                                    //                       style: TextStyle(
                                    //                           color:
                                    //                               Colors.red))
                                    //                 ]),
                                    //           ),
                                    //           hint: "",
                                    //           suffix: SizedBox(
                                    //             height:
                                    //                 getProportionateScreenHeight(
                                    //                     20),
                                    //             width:
                                    //                 getProportionateScreenHeight(
                                    //                     20),
                                    //             child: Center(
                                    //               child: Image.asset(
                                    //                 icArrowDownOrange,
                                    //                 height:
                                    //                     getProportionateScreenHeight(
                                    //                         20),
                                    //                 width:
                                    //                     getProportionateScreenHeight(
                                    //                         20),
                                    //               ),
                                    //             ),
                                    //           ),
                                    //         )),

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
                                      borderRadius: responsiveHeight(20),
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
                                              context
                                                  .read<MasterDataBloc>()
                                                  .add(GetDistrictList(
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
                                                return state
                                                        .getDistrictListStatus
                                                        .isInProgress
                                                    ? SizedBox(
                                                        height:
                                                            responsiveHeight(
                                                                20),
                                                        width: responsiveHeight(
                                                            20),
                                                        child: const Center(
                                                            child:
                                                                CircularProgressIndicator()),
                                                      )
                                                    : SizedBox(
                                                        height:
                                                            responsiveHeight(
                                                                20),
                                                        width: responsiveHeight(
                                                            20),
                                                        child: Center(
                                                          child: Image.asset(
                                                            icArrowDownOrange,
                                                            height:
                                                                responsiveHeight(
                                                                    20),
                                                            width:
                                                                responsiveHeight(
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
                                              context
                                                  .read<MasterDataBloc>()
                                                  .add(GetTalukaList(
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
                                                            responsiveHeight(
                                                                20),
                                                        width: responsiveHeight(
                                                            20),
                                                        child: const Center(
                                                            child:
                                                                CircularProgressIndicator()),
                                                      )
                                                    : SizedBox(
                                                        height:
                                                            responsiveHeight(
                                                                20),
                                                        width: responsiveHeight(
                                                            20),
                                                        child: Center(
                                                          child: Image.asset(
                                                            icArrowDownOrange,
                                                            height:
                                                                responsiveHeight(
                                                                    20),
                                                            width:
                                                                responsiveHeight(
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
                                              context
                                                  .read<MasterDataBloc>()
                                                  .add(GetTownList(
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
                                                            responsiveHeight(
                                                                20),
                                                        width: responsiveHeight(
                                                            20),
                                                        child: const Center(
                                                            child:
                                                                CircularProgressIndicator()),
                                                      )
                                                    : SizedBox(
                                                        height:
                                                            responsiveHeight(
                                                                20),
                                                        width: responsiveHeight(
                                                            20),
                                                        child: Center(
                                                          child: Image.asset(
                                                            icArrowDownOrange,
                                                            height:
                                                                responsiveHeight(
                                                                    20),
                                                            width:
                                                                responsiveHeight(
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
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: responsiveHeight(10),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: multiSelectedItem.length,
                          itemBuilder: (c, i) => selectedList(context, i)),
                      multiSelection(context),
                      SizedBox(
                        height: responsiveHeight(30),
                      ),
                      BlocBuilder<PatientRegistrationBloc,
                          PatientRegistrationState>(
                        builder: (context, state) {
                          return state.patientRegistrationStatus.isInProgress
                              ? const CircularProgressIndicator()
                              : AppButton(
                                  title: "Register",
                                  iconData: Icon(
                                    Icons.arrow_forward,
                                    color: kWhiteColor,
                                    size: responsiveHeight(24),
                                  ),
                                  onTap: () {
                                    if (_formKey.currentState!.validate() ==
                                        false) {
                                      return;
                                    }

                                    List<ReferToReqModel> referTo = [];
                                    for (int i = 0;
                                        i < selectedStakeH.length;
                                        i++) {
                                      referTo.add(ReferToReqModel(
                                          patientId: null,
                                          patientReferId: null,
                                          stakeholderMasterId: selectedStakeH[i]
                                              .stakeholderMasterId,
                                          // stakeholderMasterId: 1,
                                          lookupDetHierIdStakeholderSubType2:
                                              null,
                                          lookupDetIdRefDepartment: null,
                                          orgId: 1,
                                          status: 1));
                                    }
                                    var payload = {
                                      "tt_patient_details": {
                                        "patient_id": null,
                                        "camp_create_request_id":
                                            _campIDTextController.text.isEmpty
                                                ? 1
                                                : _selectedCamp
                                                    ?.campCreateRequestId,
                                        // "camp_date": DateFormat('yyyy-MM-dd')
                                        //     .format(_selectedCampDate!),
                                        "camp_date":
                                            _campDateTextController.text,
                                        "user_id_register_by": DataProvider()
                                            .getParsedUserData()!
                                            .details!
                                            .last
                                            .user!
                                            .userId,
                                        "patient_name":
                                            _patientNameTextController.text,
                                        "age":
                                            int.parse(_ageTextController.text),
                                        "lookup_det_id_gender":
                                            _selectedGender?.lookupDetId,
                                        "contact_number":
                                            _mobileNoTextController.text,
                                        "addhar_card":
                                            _aadhaarNoTextController.text,
                                        "abha_card": _abhaIDTextController.text,
                                        "lookup_det_hier_id_country": 1,
                                        "lookup_det_hier_id_state": 2,
                                        "lookup_det_hier_id_district":
                                            _selectedDistrict?.lookupDetHierId,
                                        "lookup_det_hier_id_taluka":
                                            _selectedTaluka?.lookupDetHierId,
                                        "lookup_det_hier_id_city":
                                            _selectedCity?.lookupDetHierId,
                                        "lookup_det_id_division": null,
                                        "pin_code": _pincodeTextController.text,
                                        "org_id": 1,
                                        "status": 1,
                                        "lookup_det_id_ref_department":
                                            _selectedReferToDepartmentType
                                                ?.lookupDetId,
                                        "address1": _addressTextController.text,
                                        "address2": _addressTextController.text,
                                        "investigation":
                                            _investigationTextController.text,
                                        "provisional_diagnosis":
                                            _provisionTextController.text,
                                      },
                                      "tt_patient_ref_list": referTo,
                                      // "tt_patient_ref_list": [
                                      //   {
                                      //     "patient_refer_id": null,
                                      //     "patient_id": null,
                                      //     "stakeholder_master_id":
                                      //         selectedStakeH[0]
                                      //             .stakeholderMasterId,
                                      //     "lookup_det_id_ref_department": null,
                                      //     "lookup_det_hier_id_stakeholder_sub_type2":
                                      //         null,
                                      //     "org_id": 1,
                                      //     "status": 1,
                                      //     "is_inactive": null
                                      //   }
                                      // ],
                                      "tt_patient_disease_list": [
                                        {
                                          "patient_disease_types_id": null,
                                          "patient_id": null,
                                          "lookup_det_id_disease_types":
                                              _selectedDiseaseType?.lookupDetId,
                                          "org_id": 1,
                                          "status": 1,
                                          "is_inactive": null
                                        }
                                      ]
                                    };
                                    print(jsonEncode(payload));
                                    context.read<PatientRegistrationBloc>().add(
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
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }

  List<ReferToDetails> selectedStakeH = [];

  Padding multiSelection(BuildContext context) {
    GlobalKey<FormState> _key = GlobalKey();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey, width: 0.5),
            borderRadius: BorderRadius.circular(responsiveHeight(25))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _key,
            child: Column(
              children: [
                BlocBuilder<MasterDataBloc, MasterDataState>(
                  builder: (context, state) {
                    return AppRoundTextField(
                      controller: _stakeholderSubTypeTextController,
                      onChange: (p0) {
                        setState(() {});
                      },
                      errorText: Validators.validateStakeholderSubType(
                          _stakeholderSubTypeTextController.text),
                      validators: Validators.validateStakeholderSubType,
                      inputType: TextInputType.text,
                      onTap: () {
                        context.read<MasterDataBloc>().add(
                                GetStakeholderSubTypeWithLookupCode(
                                    payload: const {
                                  "lookup_det_code_list1": const [
                                    {"lookup_det_code": "SUY"}
                                  ]
                                }));
                      },
                      readOnly: true,
                      label: RichText(
                        text: const TextSpan(
                            text: 'Stakeholder Sub Type',
                            style: TextStyle(
                                color: kHintColor, fontFamily: Montserrat),
                            children: [
                              TextSpan(
                                  text: "*",
                                  style: TextStyle(color: Colors.red))
                            ]),
                      ),
                      hint: "",
                      suffix: state.getStakeholderSubTypeStatus.isInProgress
                          ? SizedBox(
                              height: responsiveHeight(20),
                              width: responsiveHeight(20),
                              child: const Center(
                                child: CircularProgressIndicator(),
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
                          onChange: (p0) {
                            setState(() {});
                          },
                          errorText: Validators.validateStakeholderSubType(
                              _referToTextController.text),
                          validators: Validators.validateStakeholderSubType,
                          onTap: () async {
                            if (_stakeholderSubTypeTextController
                                .text.isNotEmpty) {
                              await stakeHolderNameBottomSheet(
                                  context,
                                  (p0) => {
                                        controller.selectedStakeHVal =
                                            p0.lookupDetHierDescEn,
                                        selectedStakeH.addIfNotExist(p0),
                                        _referToTextController.text =
                                            selectedStakeH.displayText(),
                                        controller.update()
                                      },
                                  "Refer To",
                                  controller.referToModel?.details ?? [],
                                  true);
                            }
                          },
                          // maxLength: 12,
                          readOnly: true,
                          label: RichText(
                            text: const TextSpan(
                                text: 'Refer To',
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
                            height: getProportionateScreenHeight(20),
                            width: getProportionateScreenHeight(20),
                            child: Center(
                              child: Image.asset(
                                icArrowDownOrange,
                                height: getProportionateScreenHeight(20),
                                width: getProportionateScreenHeight(20),
                              ),
                            ),
                          ),
                        )),
                SizedBox(
                  height: responsiveHeight(20),
                ),
                BlocBuilder<MasterDataBloc, MasterDataState>(
                  builder: (context, state) {
                    return AppRoundTextField(
                      controller: _referToDepartmentTextController,
                      onChange: (p0) {
                        setState(() {});
                      },
                      errorText: Validators.validateStakeholderSubType(
                          _referToDepartmentTextController.text),
                      validators: Validators.validateStakeholderSubType,
                      inputType: TextInputType.text,
                      onTap: () {
                        context
                            .read<MasterDataBloc>()
                            .add(GetReferToDepartment(payload: const {
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
                                color: kHintColor, fontFamily: Montserrat),
                            children: [
                              TextSpan(
                                  text: "*",
                                  style: TextStyle(color: Colors.red))
                            ]),
                      ),
                      hint: "",
                      suffix: state.getStakeholderSubTypeStatus.isInProgress
                          ? SizedBox(
                              height: responsiveHeight(20),
                              width: responsiveHeight(20),
                              child: const Center(
                                child: CircularProgressIndicator(),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          if (_key.currentState!.validate() == false) {
                            return;
                          }
                          multiSelectedItem.add({
                            "patient_refer_id": null,
                            "patient_id": null,
                            "stakeholder_master_id":
                                _selectedStakeholderSubType?.lookupDetHierId,
                            "lookup_det_id_ref_department":
                                _selectedReferToDepartmentType?.lookupDetId,
                            "lookup_det_hier_id_stakeholder_sub_type2":
                                _selectedStakeholderSubType?.lookupDetHierId,
                            "stakeholderSubTypeTitle":
                                _selectedStakeholderSubType
                                    ?.lookupDetHierDescEn,
                            "referToTitle": _referToTextController.text,
                            "referToDeptTitle":
                                _selectedReferToDepartmentType?.lookupDetDescEn,
                            "org_id": 1,
                            "status": 1,
                            "is_inactive": null
                          });
                          _selectedReferToDepartmentType = null;
                          _selectedStakeholderSubType = null;
                          selectedStakeH.clear();
                          _referToDepartmentTextController.clear();
                          _referToTextController.clear();
                          _stakeholderSubTypeTextController.clear();
                          scrollController.animateTo(
                              scrollController.position.maxScrollExtent,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeOut);
                          setState(() {});
                        },
                        icon: Image.asset(
                          icSquarePlus,
                          fit: BoxFit.cover,
                          color: kPrimaryColor,
                          height: responsiveHeight(30),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding selectedList(BuildContext context, int index) {
    TextEditingController subStakeholderController = TextEditingController();
    TextEditingController referToController = TextEditingController();
    TextEditingController referToDeptController = TextEditingController();
    subStakeholderController.text =
        multiSelectedItem[index]['stakeholderSubTypeTitle'];
    referToController.text = multiSelectedItem[index]['referToTitle'];
    referToDeptController.text = multiSelectedItem[index]['referToDeptTitle'];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey, width: 0.5),
            borderRadius: BorderRadius.circular(responsiveHeight(25))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              BlocBuilder<MasterDataBloc, MasterDataState>(
                builder: (context, state) {
                  return AppRoundTextField(
                    controller: subStakeholderController,
                    inputType: TextInputType.text,
                    onTap: () {},
                    readOnly: true,
                    label: RichText(
                      text: const TextSpan(
                          text: 'Stakeholder Sub Type',
                          style: TextStyle(
                              color: kHintColor, fontFamily: Montserrat),
                          children: [
                            TextSpan(
                                text: "*", style: TextStyle(color: Colors.red))
                          ]),
                    ),
                    hint: "",
                  );
                },
              ),
              SizedBox(
                height: responsiveHeight(20),
              ),
              GetBuilder(
                  init: DoctorDeskController(),
                  builder: (controller) => AppRoundTextField(
                        controller: referToController,
                        inputType: TextInputType.text,
                        readOnly: true,
                        label: RichText(
                          text: const TextSpan(
                              text: 'Refer To',
                              style: TextStyle(
                                  color: kHintColor, fontFamily: Montserrat),
                              children: [
                                TextSpan(
                                    text: "*",
                                    style: TextStyle(color: Colors.red))
                              ]),
                        ),
                        hint: "",
                      )),
              SizedBox(
                height: responsiveHeight(20),
              ),
              BlocBuilder<MasterDataBloc, MasterDataState>(
                builder: (context, state) {
                  return AppRoundTextField(
                    controller: referToDeptController,
                    inputType: TextInputType.text,
                    readOnly: true,
                    label: RichText(
                      text: const TextSpan(
                          text: 'Refer To Department',
                          style: TextStyle(
                              color: kHintColor, fontFamily: Montserrat),
                          children: [
                            TextSpan(
                                text: "*", style: TextStyle(color: Colors.red))
                          ]),
                    ),
                    hint: "",
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        multiSelectedItem.removeAt(index);
                        setState(() {});
                      },
                      icon: Image.asset(
                        "assets/icons/remove.png",
                        fit: BoxFit.cover,
                        color: kPrimaryColor,
                        height: responsiveHeight(30),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
