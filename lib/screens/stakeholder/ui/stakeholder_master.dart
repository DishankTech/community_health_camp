import 'package:community_health_app/core/common_bloc/bloc/master_data_bloc.dart';
import 'package:community_health_app/core/common_bloc/models/get_master_response_model_with_hier.dart';
import 'package:community_health_app/core/common_bloc/models/master_response_model.dart';
import 'package:community_health_app/core/common_widgets/app_bar_v1.dart';
import 'package:community_health_app/core/common_widgets/app_button.dart';
import 'package:community_health_app/core/common_widgets/app_round_textfield.dart';
import 'package:community_health_app/core/common_widgets/app_round_textfield_country_code.dart';
import 'package:community_health_app/core/common_widgets/drop_down.dart';
import 'package:community_health_app/core/constants/constants.dart';
import 'package:community_health_app/core/constants/fonts.dart';
import 'package:community_health_app/core/constants/images.dart';
import 'package:community_health_app/core/routes/app_routes.dart';
import 'package:community_health_app/core/utilities/size_config.dart';
import 'package:community_health_app/screens/user_master/bloc/user_master_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';

class StakeHolderMasterScreen extends StatefulWidget {
  const StakeHolderMasterScreen({super.key});

  @override
  State<StakeHolderMasterScreen> createState() =>
      _StakeHolderMasterScreenState();
}

class _StakeHolderMasterScreenState extends State<StakeHolderMasterScreen> {
  XFile? capturedFile;

  late TextEditingController _stakeholderTypeTextController;
  late TextEditingController _stakeholderSubTypeTextController;
  late TextEditingController _stakeholderNameTextController;
  late TextEditingController _mobileNoTextController;
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
  Map? _selectedStakeholderType;
  Map? _selectedStakeholderSubType;
  Map? _selectedStakeholderName;
  Map? _selectedMobile;
  Map? _selectedEmailId;
  Map? _selectedStatus;
  bool _isObscure = true;
  LookupDet? _selectedDivision = null;
  LookupDet? _selectedGender = null;
  LookupDetHierarchical? _selectedDistrict = null;
  LookupDetHierarchical? _selectedTaluka = null;
  LookupDetHierarchical? _selectedCity = null;

  Map? _selectedStakeholder;
  Map? _selectedDesignationType;

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

    _address1TextController = TextEditingController();
    _address2TextController = TextEditingController();
    _pincodeTextController = TextEditingController();
    _districtTextController = TextEditingController();
    _talukaTextController = TextEditingController();
    _cityTextController = TextEditingController();
    _divisionTextController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<MasterDataBloc>().add(GetMasters(payload: const {
            "lookup_det_code_list1": [
              {"lookup_det_code": "STY"}
            ]
          }));

      context
          .read<MasterDataBloc>()
          .add(GetMastersDesignationType(payload: const {
            "lookup_code_list1": [
              {"lookup_code": "MTY"}
            ]
          }));
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
    super.dispose();
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
            image:
                DecorationImage(image: AssetImage(patRegBg), fit: BoxFit.fill)),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                mAppBarV1(title: "Stakeholder Master", context: context),
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
                            onChange: (p0) {},
                            onTap: () {
                              stakeholderBottomSheet(context, (p0) {
                                setState(() {
                                  _selectedStakeholder = p0;
                                  _stakeholderTypeTextController.text =
                                      p0['title'];
                                });
                              });
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
                            height: responsiveHeight(20),
                          ),
                          AppRoundTextField(
                            controller: _stakeholderSubTypeTextController,
                            inputType: TextInputType.text,
                            onChange: (p0) {},
                            onTap: () {
                              stakeholderBottomSheet(context, (p0) => null);
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
                          SizedBox(
                            height: responsiveHeight(20),
                          ),
                          AppRoundTextField(
                            controller: _stakeholderNameTextController,
                            inputType: TextInputType.name,
                            onChange: (p0) {},
                            readOnly: true,
                            label: RichText(
                              text: const TextSpan(
                                  text: 'Stakeholder Name',
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
                            height: responsiveHeight(20),
                          ),
                          Row(
                            children: [
                              Flexible(
                                flex: 2,
                                child: AppRoundTextFieldCountryCode(
                                  controller:
                                      _mobileNoCountryCodeTextController,
                                  inputStyle: TextStyle(
                                      fontSize: responsiveFont(14),
                                      color: kTextBlackColor),
                                  inputType: TextInputType.phone,
                                  onChange: (p0) {},
                                  maxLength: 10,
                                  label: const Text(""),
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
                                  onChange: (p0) {},
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
                                              style:
                                                  TextStyle(color: Colors.red))
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
                          Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: AppRoundTextField(
                                  controller: _districtTextController,
                                  textCapitalization: TextCapitalization.none,
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
                                        .add(GetDistrictList(payload: payload));
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
                                                  height: responsiveHeight(20),
                                                  width: responsiveHeight(20),
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
                                    controller: _talukaTextController,
                                    textCapitalization: TextCapitalization.none,
                                    inputType: TextInputType.text,
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
                                    onTap: () {},
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
                                    )),
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
                                  controller: _cityTextController,
                                  readOnly: true,
                                  maxLength: 10,
                                  inputType: TextInputType.text,
                                  label: RichText(
                                    text: const TextSpan(
                                        text: 'City',
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
                                  onTap: () {},
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
                                flex: 1,
                                child: AppRoundTextField(
                                    controller: _divisionTextController,
                                    textCapitalization: TextCapitalization.none,
                                    inputType: TextInputType.text,
                                    readOnly: true,
                                    label: RichText(
                                      text: const TextSpan(
                                          text: 'Division',
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
                                    onTap: () {},
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
                                    )),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: responsiveHeight(20),
                          ),
                          AppRoundTextField(
                            controller: _pincodeTextController,
                            inputStyle: TextStyle(
                                fontSize: responsiveFont(14),
                                color: kTextBlackColor),
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
                          AppRoundTextField(
                            controller: _statusTextController,
                            label: RichText(
                              text: const TextSpan(
                                  text: 'Status',
                                  style: TextStyle(
                                      color: kHintColor,
                                      fontFamily: Montserrat),
                                  children: []),
                            ),
                            hint: "",
                            readOnly: true,
                            onTap: () {
                              stakeholderStatusBottomSheet(
                                  context, (p0) => null);
                            },
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
                                child: BlocBuilder<UserMasterBloc,
                                    UserMasterState>(
                                  builder: (context, state) {
                                    return state.createUserStatus.isInProgress
                                        ? const CircularProgressIndicator()
                                        : AppButton(
                                            onTap: () {
                                              var payload = {
                                                "user_id": null,
                                                "stakeholder_master_id":
                                                    _selectedStakeholder != null
                                                        ? _selectedStakeholder![
                                                            'id']
                                                        : 0,
                                                "full_name": "",
                                                "login_name": "",
                                                "passwords": "",
                                                "mobile_number":
                                                    _mobileNoTextController
                                                        .text,
                                                "email_id":
                                                    _emailIdTextController.text,
                                                "first_login_pass_reset": "Y",
                                                "status": 1,
                                                "org_id": 1,
                                                "lookup_det_hier_id_stakeholder_type1":
                                                    1
                                              };

                                              context
                                                  .read<UserMasterBloc>()
                                                  .add(CreateUserRequest(
                                                      payload: payload));
                                            },
                                            title: "Save",
                                            iconData: Icon(
                                              Icons.arrow_forward,
                                              color: kWhiteColor,
                                              size: responsiveHeight(24),
                                            ),
                                          );
                                  },
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
      )),
    );
  }
}
