import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:community_health_app/core/common_bloc/bloc/master_data_bloc.dart';
import 'package:community_health_app/core/common_bloc/models/master_response_model.dart';
import 'package:community_health_app/core/common_widgets/address_text_form_field.dart';
import 'package:community_health_app/core/common_widgets/app_bar.dart';
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
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';

class UserMasterScreen extends StatefulWidget {
  const UserMasterScreen({super.key});

  @override
  State<UserMasterScreen> createState() => _UserMasterScreenState();
}

class _UserMasterScreenState extends State<UserMasterScreen> {
  XFile? capturedFile;

  GlobalKey<FormState> _formKey = GlobalKey();
  late TextEditingController _stakeholderTypeTextController;
  late TextEditingController _stakeholderNameTextController;
  late TextEditingController _fullnameTextController;
  late TextEditingController _loginNameTextController;
  late TextEditingController _designationTypeTextController;
  late TextEditingController _emailIdTextController;
  late TextEditingController _passwordTextController;
  late TextEditingController _confirmPsswordTextController;
  late TextEditingController _mobileNoTextController;
  late TextEditingController _mobileNoCountryCodeTextController;

  bool _isObscure = true;
  Map? _selectedStakeholder;
  Map? _selectedStakeholderName;
  Map? _selectedDesignationType;
  void _toggleObscure() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _stakeholderTypeTextController = TextEditingController();
    _stakeholderNameTextController = TextEditingController();
    _fullnameTextController = TextEditingController();
    _loginNameTextController = TextEditingController();
    _designationTypeTextController = TextEditingController();
    _emailIdTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _confirmPsswordTextController = TextEditingController();
    _mobileNoTextController = TextEditingController();
    _mobileNoCountryCodeTextController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<MasterDataBloc>().add(GetMasters(payload: const {
            "lookup_code_list1": [
              {"lookup_code": "STO"}
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
    _stakeholderNameTextController.dispose();
    _fullnameTextController.dispose();
    _loginNameTextController.dispose();
    _designationTypeTextController.dispose();
    _emailIdTextController.dispose();
    _passwordTextController.dispose();
    _confirmPsswordTextController.dispose();
    _mobileNoTextController.dispose();
    _mobileNoCountryCodeTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocListener<MasterDataBloc, MasterDataState>(
      listener: (context, state) {
        // if (state.getMasterStatus.isSuccess) {
        //   stakeholderBottomSheet(context, (p0) {
        //     setState(() {
        //       _selectedStakeholder = p0;
        //       _stakeholderTypeTextController.text = p0['title'];
        //     });
        //   });
        // }
        if (state.getMasterStatus.isFailure) {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(const SnackBar(
              content: Text("Unable to get Stakeholder Type"),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 2),
            ));
        }
        // if (state.getMasterDesignationTypeStatus.isSuccess) {
        //   designationTypeBottomSheet(context, (p0) {
        //     setState(() {
        //       _selectedDesignationType = p0;
        //       _designationTypeTextController.text = p0['title'];
        //     });
        //   });
        // }

        if (state.getMasterDesignationTypeStatus.isFailure) {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(const SnackBar(
              content: Text("Unable to get Designation Type"),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 2),
            ));
        }
      },
      child: Scaffold(
          body: Stack(children: [
        Image.asset(
          patRegBg,
          width: SizeConfig.screenWidth,
          fit: BoxFit.fill,
        ),
        SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                mAppBarV1(title: "User Master", context: context),
                SizedBox(
                  height: responsiveHeight(10),
                ),
                Container(
                  width: SizeConfig.screenWidth * 0.95,
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
                              // context
                              //     .read<MasterDataBloc>()
                              //     .add(GetMasters(payload: const {
                              //       "lookup_code_list1": [
                              //         {"lookup_code": "STO"}
                              //       ]
                              //     }));
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
                            suffix:
                                BlocBuilder<MasterDataBloc, MasterDataState>(
                              builder: (context, state) {
                                return state.getMasterStatus.isInProgress
                                    ? const Center(
                                        child: CircularProgressIndicator())
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
                            controller: _stakeholderNameTextController,
                            inputType: TextInputType.text,
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
                          AppRoundTextField(
                            controller: _fullnameTextController,
                            inputType: TextInputType.name,
                            onChange: (p0) {},
                            label: RichText(
                              text: const TextSpan(
                                  text: 'Full Name',
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
                            controller: _loginNameTextController,
                            inputType: TextInputType.name,
                            onChange: (p0) {},
                            label: RichText(
                              text: const TextSpan(
                                  text: 'Login Name',
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
                            controller: _designationTypeTextController,
                            inputType: TextInputType.text,
                            onTap: () {
                              designationTypeBottomSheet(context, (p0) {
                                setState(() {
                                  _selectedDesignationType = p0;
                                  _designationTypeTextController.text =
                                      p0['title'];
                                });
                              });
                            },
                            onChange: (p0) {},
                            readOnly: true,
                            label: RichText(
                              text: const TextSpan(
                                  text: 'Designation/Member Type',
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
                                  text: 'Email ID',
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
                            controller: _passwordTextController,
                            textCapitalization: TextCapitalization.none,
                            obscureText: _isObscure,
                            label: RichText(
                              text: const TextSpan(
                                  text: 'Passowrd',
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
                            suffix: GestureDetector(
                              onTap: () {
                                _toggleObscure();
                              },
                              child: SizedBox(
                                height: responsiveHeight(20),
                                width: responsiveHeight(20),
                                child: Center(
                                    child: _isObscure
                                        ? const Icon(
                                            Icons.visibility_outlined,
                                            color: kPrimaryColor,
                                          )
                                        : const Icon(
                                            Icons.visibility_off_outlined,
                                            color: kPrimaryColor,
                                          )),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: responsiveHeight(20),
                          ),
                          AppRoundTextField(
                            controller: _confirmPsswordTextController,
                            textCapitalization: TextCapitalization.none,
                            obscureText: _isObscure,
                            label: RichText(
                              text: const TextSpan(
                                  text: 'Confirm Password',
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
                            suffix: GestureDetector(
                              onTap: () {
                                _toggleObscure();
                              },
                              child: SizedBox(
                                height: responsiveHeight(20),
                                width: responsiveHeight(20),
                                child: Center(
                                    child: _isObscure
                                        ? const Icon(
                                            Icons.visibility_outlined,
                                            color: kPrimaryColor,
                                          )
                                        : const Icon(
                                            Icons.visibility_off_outlined,
                                            color: kPrimaryColor,
                                          )),
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
                                                "full_name":
                                                    _fullnameTextController
                                                        .text,
                                                "login_name":
                                                    _loginNameTextController
                                                        .text,
                                                "passwords":
                                                    _confirmPsswordTextController
                                                        .text,
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
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ])),
    );
  }
}
