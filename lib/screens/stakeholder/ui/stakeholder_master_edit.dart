import 'package:community_health_app/core/common_bloc/bloc/master_data_bloc.dart';
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
import 'package:community_health_app/core/utilities/size_config.dart';
import 'package:community_health_app/core/utilities/validators.dart';
import 'package:community_health_app/screens/stakeholder/bloc/stakeholder_master_bloc.dart';
import 'package:community_health_app/screens/stakeholder/models/stakeholder_name_response_model.dart';
import 'package:community_health_app/screens/stakeholder/models/stakeholder_response_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';

class StakeHolderMasterEditScreen extends StatefulWidget {
  const StakeHolderMasterEditScreen({super.key});

  @override
  State<StakeHolderMasterEditScreen> createState() =>
      _StakeHolderMasterEditScreenState();
}

class _StakeHolderMasterEditScreenState
    extends State<StakeHolderMasterEditScreen> {
  XFile? capturedFile;

  GlobalKey<FormState> _formKey = GlobalKey();
  late TextEditingController _stakeholderTypeTextController;
  late TextEditingController _stakeholderSubTypeTextController;
  late TextEditingController _stakeholderNameTextController;
  late TextEditingController _mobileNoTextController;
  late TextEditingController _personNameTextController;
  late TextEditingController _statusTextController;
  late TextEditingController _designationTypeTextController;
  late TextEditingController _emailIdTextController;
  late TextEditingController _mobileNoCountryCodeTextController;

  late TextEditingController _address1TextController;
  late TextEditingController _address2TextController;
  late TextEditingController _pincodeTextController;
  late TextEditingController _districtTextController;
  late TextEditingController _talukaTextController;
  late TextEditingController _cityTextController;
  late TextEditingController _divisionTextController;
  LookupDetHierarchical? _selectedStakeholderType;
  LookupDetHierarchical? _selectedStakeholderSubType;
  late TextEditingController _sectorTypeTextController;
  late TextEditingController _stakeholderNameRegTextController;
  late TextEditingController _noOfBedTextController;
  late TextEditingController _stateTextController;
  late TextEditingController _countryTextController;

  Map? _selectedStatus;
  bool _isObscure = true;
  LookupDet? _selectedDivision;
  LookupDetHierarchical? _selectedDistrict;
  LookupDetHierDetails? _selectedTaluka;
  LookupDetHierDetails? _selectedCity;
  StakeholderNameDetails? stakeholderNameDetails;
  LookupDet? _selectedSectorType;

  StakeholderMasterData? stakeholderMasterData;

  void _toggleObscure() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  @override
  void initState() {
    super.initState();
    _stakeholderTypeTextController = TextEditingController();
    _stakeholderSubTypeTextController = TextEditingController();
    _stakeholderNameTextController = TextEditingController();
    _statusTextController = TextEditingController();
    _designationTypeTextController = TextEditingController();
    _emailIdTextController = TextEditingController();
    _mobileNoTextController = TextEditingController();
    _mobileNoCountryCodeTextController = TextEditingController();
    _personNameTextController = TextEditingController();
    _sectorTypeTextController = TextEditingController();
    _noOfBedTextController = TextEditingController();
    _mobileNoCountryCodeTextController.text = "+91";
    _stakeholderNameRegTextController = TextEditingController();

    _address1TextController = TextEditingController();
    _address2TextController = TextEditingController();
    _pincodeTextController = TextEditingController();
    _districtTextController = TextEditingController();
    _talukaTextController = TextEditingController();
    _cityTextController = TextEditingController();
    _divisionTextController = TextEditingController();
    _countryTextController = TextEditingController();
    _stateTextController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      stakeholderMasterData =
          ModalRoute.of(context)!.settings.arguments as StakeholderMasterData;

      _stakeholderTypeTextController.text =
          stakeholderMasterData!.stakeholderType1En ?? "";
      _stakeholderSubTypeTextController.text =
          stakeholderMasterData!.stakeholderSubType2En ?? "";
      _stakeholderNameTextController.text =
          stakeholderMasterData!.stakeholderNameEn ?? "";
      _statusTextController.text =
          stakeholderMasterData!.status == 0 ? 'In Active' : 'Active';
      // _designationTypeTextController .text =
      //     stakeholderMasterData!.desig ?? "";
      _emailIdTextController.text = stakeholderMasterData!.emailId ?? '';
      _mobileNoTextController.text = stakeholderMasterData!.contactNumber ?? '';
      _personNameTextController.text =
          stakeholderMasterData!.contactPersonName ?? '';

      _mobileNoCountryCodeTextController.text = "+91";

      _address1TextController.text = stakeholderMasterData!.address1 ?? '';
      _address2TextController.text = stakeholderMasterData!.address2 ?? '';
      _pincodeTextController.text = stakeholderMasterData!.pinCode ?? '';
      _noOfBedTextController.text =
          stakeholderMasterData!.numberOfBed?.toString() ?? '';
      _stateTextController.text = stakeholderMasterData!.stateDescEn ?? '';
      _countryTextController.text = stakeholderMasterData!.countryDescEn ?? '';
      _districtTextController.text =
          stakeholderMasterData!.districtDescEn ?? '';
      _talukaTextController.text = stakeholderMasterData!.talukaDescEn ?? '';
      _cityTextController.text = stakeholderMasterData!.cityDescEn ?? '';
      _stakeholderNameRegTextController.text =
          stakeholderMasterData?.stakeholderNameRg ?? '';
      // _divisionTextController .text=stakeholderMasterData.divi

      // context.read<MasterDataBloc>().add(GetMasters(payload: const {
      //       "lookup_det_code_list1": [
      //         {"lookup_det_code": "STY"}
      //       ]
      //     }));

      // context.read<MasterDataBloc>().add(GetStakeholderSubType(payload: const {
      //       "lookup_det_code_list1": [
      //         {"lookup_det_code": "SUY"}
      //       ]
      //     }));

      // context.read<MasterDataBloc>().add(GetDivisionList(payload: const {
      //       "lookup_code_list1": [
      //         {"lookup_code": "DIV"}
      //       ]
      //     }));
      // context.read<MasterDataBloc>().add(GetDistrictList(payload: const {
      //       "lookup_det_code_list1": const [
      //         {"lookup_det_code": "DIS"}
      //       ]
      //     }));

      // context.read<MasterDataBloc>().add(GetTalukaList(payload: const {
      //       "lookup_det_code_list1": const [
      //         {"lookup_det_code": "TLK"}
      //       ]
      //     }));

      // context.read<MasterDataBloc>().add(GetTownList(payload: const {
      //       "lookup_det_code_list1": const [
      //         {"lookup_det_code": "CTV"}
      //       ]
      //     }));

      setState(() {});
    });
  }

  @override
  void dispose() {
    _stakeholderTypeTextController.dispose();
    _stakeholderSubTypeTextController.dispose();
    _stakeholderNameTextController.dispose();
    _statusTextController.dispose();
    _designationTypeTextController.dispose();
    _emailIdTextController.dispose();
    _mobileNoTextController.dispose();
    _mobileNoCountryCodeTextController.dispose();
    _address1TextController.dispose();
    _address2TextController.dispose();
    _pincodeTextController.dispose();
    _districtTextController.dispose();
    _talukaTextController.dispose();
    _cityTextController.dispose();
    _divisionTextController.dispose();
    _personNameTextController.dispose();
    super.dispose();
  }

  void clearForm() {
    _stakeholderTypeTextController.clear();
    _stakeholderSubTypeTextController.clear();
    _stakeholderNameTextController.clear();
    _statusTextController.clear();
    _designationTypeTextController.clear();
    _emailIdTextController.clear();
    _mobileNoTextController.clear();
    _mobileNoCountryCodeTextController.clear();
    _address1TextController.clear();
    _address2TextController.clear();
    _pincodeTextController.clear();
    _districtTextController.clear();
    _talukaTextController.clear();
    _cityTextController.clear();
    _divisionTextController.clear();
    _personNameTextController.clear();

    _selectedStakeholderType = null;
    _selectedStakeholderSubType = null;
    _selectedStatus = null;
    _selectedDivision = null;
    _selectedDistrict = null;
    _selectedTaluka = null;
    _selectedCity = null;
    stakeholderNameDetails = null;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocListener<MasterDataBloc, MasterDataState>(
      listener: (context, state) {
        if (state.getMasterStatus.isFailure) {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(const SnackBar(
              content: Text("Unable to get Stakeholder Type"),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 2),
            ));
        }
        if (state.getMasterDesignationTypeStatus.isFailure) {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(const SnackBar(
              content: Text("Unable to get Designation Type"),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 2),
            ));
        }
        if (state.getMasterStatus.isSuccess) {
          stakeholderBottomSheet(context, (p0) {
            setState(() {
              _selectedStakeholderType = p0;
              _stakeholderTypeTextController.text = p0.lookupDetHierDescEn!;
            });

            context.read<MasterDataBloc>().add(ResetMasterState());
          });
        }
        if (state.getSectorTypeStatus.isSuccess) {
          sectorTypeBottomSheet(context, (p0) {
            setState(() {
              _selectedSectorType = p0;
              _sectorTypeTextController.text = p0.lookupDetDescEn!;
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

        if (state.getStakeholderSubTypeStatus.isSuccess) {
          stakeholderSubTypeBottomSheet(context, (p0) {
            setState(() {
              _selectedStakeholderSubType = p0;
              _stakeholderSubTypeTextController.text = p0.lookupDetHierDescEn!;
            });
            context.read<MasterDataBloc>().add(ResetMasterState());
          });
        }
      },
      child: BlocListener<StakeholderMasterBloc, StakeholderMasterState>(
        listener: (context, state) {
          if (state.getStakeholderNameStatus.isSuccess) {
            stakeholderNameBottomSheet(context, (v) {
              setState(() {
                stakeholderNameDetails = v;
                _stakeholderNameTextController.text = v.stakeholderNameEn!;
              });

              context
                  .read<StakeholderMasterBloc>()
                  .add(ResetStakeholderMasterState());
            });
          }
          if (state.registerStakeholderStatus.isSuccess) {
            ScaffoldMessenger.of(context)
              ..clearSnackBars()
              ..showSnackBar(const SnackBar(
                content: Text("Data saved successfully"),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
              ));

            context.read<StakeholderMasterBloc>().add(GetAllStakeholder(
                    payload: const {
                      "total_pages": 1,
                      "page": 1,
                      "total_count": 1,
                      "per_page": 10,
                      "data": ""
                    }));

            // clearForm();
            Navigator.pop(context);
          }
          if (state.registerStakeholderStatus.isFailure) {
            ScaffoldMessenger.of(context)
              ..clearSnackBars()
              ..showSnackBar(SnackBar(
                content: Text(state.registerStakeholderResponse),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 2),
              ));
            context
                .read<StakeholderMasterBloc>()
                .add(ResetStakeholderMasterState());
          }
        },
        child: Scaffold(
            body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(patRegBg), fit: BoxFit.fill)),
          child: SingleChildScrollView(
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    mAppBarV1(
                        title: "Stakeholder Master",
                        context: context,
                        onBackButtonPress: () {
                          Navigator.pop(context);
                        }),
                    Padding(
                      padding: EdgeInsets.only(bottom: responsiveHeight(30)),
                      child: Container(
                        width: SizeConfig.screenWidth * 0.95,
                        // height: SizeConfig.screenHeight * 0.7,
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
                              AppRoundTextField(
                                controller: _stakeholderTypeTextController,
                                inputType: TextInputType.text,
                                onChange: (p0) {
                                  setState(() {});
                                },
                                errorText: Validators.validateStakeholderType(
                                    _stakeholderTypeTextController.text),
                                validators: Validators.validateStakeholderType,
                                onTap: () {
                                  context
                                      .read<MasterDataBloc>()
                                      .add(GetMasters(payload: const {
                                        "lookup_det_code_list1": [
                                          {"lookup_det_code": "STY"}
                                        ]
                                      }));
                                },
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
                                            style: TextStyle(color: Colors.red))
                                      ]),
                                ),
                                hint: "",
                                suffix: BlocBuilder<MasterDataBloc,
                                    MasterDataState>(
                                  builder: (context, state) {
                                    return state.getMasterStatus.isInProgress
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
                                      // if (state.getStakeholderSubTypeResponse
                                      //     .isNotEmpty) {
                                      //   stakeholderSubTypeBottomSheet(context,
                                      //       (p0) {
                                      //     setState(() {
                                      //       _selectedStakeholderSubType = p0;
                                      //       _stakeholderSubTypeTextController
                                      //           .text = p0.lookupDetHierDescEn!;
                                      //     });
                                      //   });
                                      //   return;
                                      // }
                                      context.read<MasterDataBloc>().add(
                                              GetStakeholderSubType(
                                                  payload: const {
                                                "lookup_det_code_list1": [
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
                              BlocBuilder<MasterDataBloc, MasterDataState>(
                                builder: (context, state) {
                                  return AppRoundTextField(
                                    controller: _sectorTypeTextController,
                                    inputType: TextInputType.text,
                                    onChange: (p0) {
                                      setState(() {});
                                    },
                                    errorText: Validators.validateSectorType(
                                        _sectorTypeTextController.text),
                                    validators: Validators.validateSectorType,
                                    onTap: () {
                                      context
                                          .read<MasterDataBloc>()
                                          .add(GetSectorType(payload: const {
                                            "lookup_code_list1": [
                                              {"lookup_code": "SEC"}
                                            ]
                                          }));
                                    },
                                    readOnly: true,
                                    label: RichText(
                                      text: const TextSpan(
                                          text: 'Sector Type',
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
                                    suffix: state
                                            .getSectorTypeStatus.isInProgress
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
                              BlocBuilder<StakeholderMasterBloc,
                                  StakeholderMasterState>(
                                builder: (context, state) {
                                  return AppRoundTextField(
                                    controller: _stakeholderNameTextController,
                                    inputType: TextInputType.name,
                                    // errorText: Validators.validateStakeholderName(
                                    //     _stakeholderNameTextController.text),
                                    // validators:
                                    //     Validators.validateStakeholderName,
                                    // onChange: (p0) {
                                    //   setState(() {});
                                    // },
                                    label: RichText(
                                      text: const TextSpan(
                                          text: 'Stakeholder Name En',
                                          style: TextStyle(
                                              color: kHintColor,
                                              fontFamily: Montserrat),
                                          children: []),
                                    ),
                                    hint: "",
                                  );
                                },
                              ),
                              SizedBox(
                                height: responsiveHeight(20),
                              ),
                              AppRoundTextField(
                                controller: _stakeholderNameRegTextController,
                                inputType: TextInputType.name,
                                label: RichText(
                                  text: const TextSpan(
                                      text: 'Stakeholder Name Reg.',
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
                                controller: _personNameTextController,
                                inputType: TextInputType.name,
                                label: RichText(
                                  text: const TextSpan(
                                      text: 'Person Name',
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
                              Row(
                                children: [
                                  Flexible(
                                    flex: 2,
                                    child: AppRoundTextFieldCountryCode(
                                      controller:
                                          _mobileNoCountryCodeTextController,
                                      inputType: TextInputType.phone,
                                      onChange: (p0) {},
                                      maxLength: 4,
                                      label: const SizedBox.shrink(),
                                      readOnly: true,
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
                                      inputType: TextInputType.phone,
                                      errorText: Validators.validateMobile(
                                          _mobileNoTextController.text),
                                      validators: Validators.validateMobile,
                                      onChange: (p0) {
                                        setState(() {});
                                      },
                                      maxLength: 10,
                                      label: RichText(
                                        text: const TextSpan(
                                            text: 'Mobile No',
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
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: responsiveHeight(20),
                              ),
                              AppRoundTextField(
                                controller: _emailIdTextController,
                                inputType: TextInputType.emailAddress,
                                label: RichText(
                                  text: const TextSpan(
                                      text: 'Email Id',
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
                                controller: _noOfBedTextController,
                                inputType: TextInputType.number,
                                maxLength: 3,
                                label: RichText(
                                  text: const TextSpan(
                                      text: 'No. Of Bed',
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
                              Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: BlocBuilder<MasterDataBloc,
                                        MasterDataState>(
                                      builder: (context, state) {
                                        return AppRoundTextField(
                                            controller: _countryTextController,
                                            textCapitalization:
                                                TextCapitalization.words,
                                            inputType: TextInputType.name,
                                            inputStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: responsiveFont(14),
                                                fontWeight: FontWeight.w500),
                                            readOnly: true,
                                            label: RichText(
                                              text: const TextSpan(
                                                  text: 'Country',
                                                  style: TextStyle(
                                                      color: kHintColor,
                                                      fontFamily: Montserrat),
                                                  children: []),
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
                                            ));
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: responsiveHeight(10),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: AppRoundTextField(
                                      controller: _stateTextController,
                                      textCapitalization:
                                          TextCapitalization.none,
                                      inputType: TextInputType.name,
                                      inputStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: responsiveFont(14),
                                          fontWeight: FontWeight.w500),
                                      readOnly: true,
                                      label: RichText(
                                        text: const TextSpan(
                                            text: 'State',
                                            style: TextStyle(
                                                color: kHintColor,
                                                fontFamily: Montserrat),
                                            children: []),
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
                                height: responsiveHeight(20),
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: BlocBuilder<MasterDataBloc,
                                        MasterDataState>(
                                      builder: (context, state) {
                                        return AppRoundTextField(
                                          controller: _divisionTextController,
                                          textCapitalization:
                                              TextCapitalization.words,
                                          inputType: TextInputType.name,
                                          readOnly: true,
                                          label: RichText(
                                            text: const TextSpan(
                                                text: 'Division',
                                                style: TextStyle(
                                                    color: kHintColor,
                                                    fontFamily: Montserrat),
                                                children: []),
                                          ),
                                          hint: "",
                                          onTap: () {
                                            // if (state.getDivisionListResponse
                                            //     .isNotEmpty) {
                                            //   divisionBottomSheet(context, (p0) {
                                            //     setState(() {
                                            //       _selectedDivision = p0;
                                            //       _divisionTextController.text =
                                            //           p0.lookupDetDescEn!;
                                            //     });
                                            //   });

                                            //   return;
                                            // }

                                            context.read<MasterDataBloc>().add(
                                                    GetDivisionList(
                                                        payload: const {
                                                      "lookup_code_list1": [
                                                        {"lookup_code": "DIV"}
                                                      ]
                                                    }));
                                          },
                                          suffix: BlocBuilder<MasterDataBloc,
                                              MasterDataState>(
                                            builder: (context, state) {
                                              return state.getDivisionListStatus
                                                      .isInProgress
                                                  ? SizedBox(
                                                      height:
                                                          responsiveHeight(20),
                                                      width:
                                                          responsiveHeight(20),
                                                      child: const Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      ),
                                                    )
                                                  : SizedBox(
                                                      height:
                                                          responsiveHeight(20),
                                                      width:
                                                          responsiveHeight(20),
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
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: responsiveHeight(10),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: BlocBuilder<MasterDataBloc,
                                        MasterDataState>(
                                      builder: (context, state) {
                                        return AppRoundTextField(
                                          controller: _districtTextController,
                                          textCapitalization:
                                              TextCapitalization.words,
                                          inputType: TextInputType.name,
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
                                            // if (state.getDistrictListResponse
                                            //     .isNotEmpty) {
                                            //   districtBottomSheet(context, (p0) {
                                            //     setState(() {
                                            //       _selectedDistrict = p0;
                                            //       _districtTextController.text =
                                            //           p0.lookupDetHierDescEn!;
                                            //     });
                                            //   });
                                            //   return;
                                            // }

                                            var payload = {
                                              "lookup_det_code_list1": [
                                                {"lookup_det_code": "DIS"}
                                              ]
                                            };
                                            context.read<MasterDataBloc>().add(
                                                GetDistrictList(
                                                    payload: payload));
                                          },
                                          suffix: BlocBuilder<MasterDataBloc,
                                              MasterDataState>(
                                            builder: (context, state) {
                                              return state.getDistrictListStatus
                                                      .isInProgress
                                                  ? SizedBox(
                                                      height:
                                                          responsiveHeight(20),
                                                      width:
                                                          responsiveHeight(20),
                                                      child: const Center(
                                                          child:
                                                              CircularProgressIndicator()),
                                                    )
                                                  : SizedBox(
                                                      height:
                                                          responsiveHeight(20),
                                                      width:
                                                          responsiveHeight(20),
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
                                        );
                                      },
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
                                    child: BlocBuilder<MasterDataBloc,
                                        MasterDataState>(
                                      builder: (context, state) {
                                        return AppRoundTextField(
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
                                            // if (state.getTalukaListResponse
                                            //     .isNotEmpty) {
                                            //   talukaBottomSheet(context, (p0) {
                                            //     setState(() {
                                            //       _selectedTaluka = p0;
                                            //       _talukaTextController.text =
                                            //           p0.lookupDetHierDescEn!;
                                            //     });
                                            //   });

                                            //   return;
                                            // }

                                            var payload = {
                                              "lookup_det_code_list1": [
                                                {"lookup_det_code": "TLK"}
                                              ]
                                            };
                                            if (_selectedDistrict == null) {
                                              return;
                                            }
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
                                                      width:
                                                          responsiveHeight(20),
                                                      child: const Center(
                                                          child:
                                                              CircularProgressIndicator()),
                                                    )
                                                  : SizedBox(
                                                      height:
                                                          responsiveHeight(20),
                                                      width:
                                                          responsiveHeight(20),
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
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: responsiveHeight(10),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: BlocBuilder<MasterDataBloc,
                                        MasterDataState>(
                                      builder: (context, state) {
                                        return AppRoundTextField(
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
                                            // if (state
                                            //     .getTownListResponse.isNotEmpty) {
                                            //   townBottomSheet(context, (p0) {
                                            //     setState(() {
                                            //       _selectedCity = p0;
                                            //       _cityTextController.text =
                                            //           p0.lookupDetHierDescEn!;
                                            //     });
                                            //   });

                                            //   return;
                                            // }
                                            var payload = {
                                              "lookup_det_code_list1": [
                                                {"lookup_det_code": "CTV"}
                                              ]
                                            };
                                            if (_selectedTaluka == null) {
                                              return;
                                            }
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
                                                      width:
                                                          responsiveHeight(20),
                                                      child: const Center(
                                                          child:
                                                              CircularProgressIndicator()),
                                                    )
                                                  : SizedBox(
                                                      height:
                                                          responsiveHeight(20),
                                                      width:
                                                          responsiveHeight(20),
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
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: responsiveHeight(20),
                              ),
                              AppRoundTextField(
                                controller: _pincodeTextController,
                                inputType: TextInputType.number,
                                onChange: (p0) {},
                                maxLength: 6,
                                label: RichText(
                                  text: const TextSpan(
                                      text: 'Pin code',
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
                                controller: _address1TextController,
                                inputType: TextInputType.streetAddress,
                                label: RichText(
                                  text: const TextSpan(
                                      text: 'Address 1',
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
                                controller: _address2TextController,
                                inputType: TextInputType.streetAddress,
                                label: RichText(
                                  text: const TextSpan(
                                      text: 'Address 2',
                                      style: TextStyle(
                                          color: kHintColor,
                                          fontFamily: Montserrat),
                                      children: []),
                                ),
                                hint: "",
                              ),
                              SizedBox(
                                height: responsiveHeight(30),
                              ),
                              // AppRoundTextField(
                              //   controller: _statusTextController,
                              //   label: RichText(
                              //     text: const TextSpan(
                              //         text: 'Status',
                              //         style: TextStyle(
                              //             color: kHintColor,
                              //             fontFamily: Montserrat),
                              //         children: []),
                              //   ),
                              //   hint: "",
                              //   readOnly: true,
                              //   onTap: () {
                              //     stakeholderStatusBottomSheet(context, (p0) {
                              //       _selectedStatus = p0;
                              //       _statusTextController.text = p0['title'];
                              //     });
                              //   },
                              //   suffix: SizedBox(
                              //     height: responsiveHeight(20),
                              //     width: responsiveHeight(20),
                              //     child: Center(
                              //       child: Image.asset(
                              //         icArrowDownOrange,
                              //         height: responsiveHeight(20),
                              //         width: responsiveHeight(20),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              SizedBox(
                                height: responsiveHeight(30),
                              ),
                              BlocBuilder<StakeholderMasterBloc,
                                  StakeholderMasterState>(
                                builder: (context, state) {
                                  return state.registerStakeholderStatus
                                          .isInProgress
                                      ? const CircularProgressIndicator()
                                      : Row(
                                          children: [
                                            Flexible(
                                              flex: 1,
                                              child: AppButton(
                                                onTap: () {
                                                  if (_formKey.currentState!
                                                          .validate() ==
                                                      false) {
                                                    return;
                                                  }
                                                  var payload = {
                                                    "stakeholder_master_id":
                                                        stakeholderMasterData
                                                            ?.stakeholderMasterId,
                                                    "lookup_det_hier_id_stakeholder_type1":
                                                        _selectedStakeholderType !=
                                                                null
                                                            ? _selectedStakeholderType!
                                                                .lookupDetHierId
                                                            : stakeholderMasterData
                                                                ?.lookupDetHierIdStakeholderType1,
                                                    "stakeholder_name_en":
                                                        _stakeholderNameTextController
                                                            .text,
                                                    "contact_number":
                                                        _mobileNoTextController
                                                            .text,
                                                    "contact_person_name":
                                                        _personNameTextController
                                                            .text,
                                                    "email_id":
                                                        _emailIdTextController
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
                                                            : stakeholderMasterData
                                                                ?.lookupDetHierIdDistrict,
                                                    "lookup_det_hier_id_taluka":
                                                        _selectedTaluka != null
                                                            ? _selectedTaluka
                                                                ?.lookupDetHierId
                                                            : stakeholderMasterData
                                                                ?.lookupDetHierIdTaluka,
                                                    "lookup_det_hier_id_city":
                                                        _selectedCity != null
                                                            ? _selectedCity
                                                                ?.lookupDetHierId
                                                            : stakeholderMasterData
                                                                ?.lookupDetHierIdCity,
                                                    "lookup_det_id_division":
                                                        _selectedDivision !=
                                                                null
                                                            ? _selectedDivision!
                                                                .lookupDetId
                                                            : stakeholderMasterData
                                                                ?.lookupDetIdDivision,
                                                    "pin_code":
                                                        _pincodeTextController
                                                            .text,
                                                    "address1":
                                                        _address1TextController
                                                            .text,
                                                    "address2":
                                                        _address2TextController
                                                            .text,
                                                    "number_of_bed":
                                                        _noOfBedTextController
                                                                .text.isEmpty
                                                            ? 0
                                                            : _noOfBedTextController
                                                                .text,
                                                    "lookup_det_hier_id_stakeholder_sub_type2":
                                                        _selectedStakeholderSubType !=
                                                                null
                                                            ? _selectedStakeholderSubType
                                                                ?.lookupDetHierId
                                                            : stakeholderMasterData
                                                                ?.lookupDetHierIdStakeholderSubType2,
                                                    "stakeholder_name_rg":
                                                        _stakeholderNameRegTextController
                                                            .text,
                                                    "org_id": 0,
                                                    "lookup_det_id_sec_type_gov_pvt":
                                                        _selectedSectorType
                                                            ?.lookupDetId!,
                                                    "status": 1
                                                  };

                                                  if (kDebugMode) {
                                                    print(payload);
                                                  }
                                                  context
                                                      .read<
                                                          StakeholderMasterBloc>()
                                                      .add(RegisterStakeholder(
                                                          payload: payload));
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
                                                onTap: () {
                                                  clearForm();
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
                                        );
                                },
                              ),
                              SizedBox(
                                height: responsiveHeight(30),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )),
      ),
    );
  }
}
