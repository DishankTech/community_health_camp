import 'dart:io';

import 'package:community_health_app/core/common_widgets/address_text_form_field.dart';
import 'package:community_health_app/core/common_widgets/app_bar_v1.dart';
import 'package:community_health_app/core/common_widgets/app_button.dart';
import 'package:community_health_app/core/common_widgets/app_round_textfield.dart';
import 'package:community_health_app/core/common_widgets/drop_down.dart';
import 'package:community_health_app/core/constants/constants.dart';
import 'package:community_health_app/core/constants/images.dart';
import 'package:community_health_app/core/routes/app_routes.dart';
import 'package:community_health_app/core/utilities/size_config.dart';
import 'package:flutter/material.dart';

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

  late TextEditingController _campIDTextController;
  late TextEditingController _campDateTextController;
  late TextEditingController _genderTextController;
  late TextEditingController _mobileNoTextController;
  late TextEditingController _mobileNoCountryCodeTextController;

  late TextEditingController _aadhaarNoTextController;
  late TextEditingController _abhaIDTextController;
  late TextEditingController _addressTextController;
  late TextEditingController _pincodeTextController;
  late TextEditingController _districtTextController;
  late TextEditingController _talukaTextController;
  late TextEditingController _cityTextController;

  Map<String, dynamic>? _selectedGender = null;
  Map<String, dynamic>? _selectedDistrict = null;
  Map<String, dynamic>? _selectedTaluka = null;
  Map<String, dynamic>? _selectedCity = null;

  DateTime? _selectedCampDate;

  @override
  void initState() {
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
    _mobileNoCountryCodeTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
    _mobileNoCountryCodeTextController.dispose();
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
            mAppBarV1(title: "Patient Registration", context: context),
            Padding(
              padding: EdgeInsets.only(bottom: responsiveHeight(10)),
              child: Container(
                width: SizeConfig.screenWidth * 0.95,
                // height: SizeConfig.screenHeight * 0.85,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(responsiveHeight(25))),
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
                            onTap: () {},
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
                      SizedBox(height: responsiveHeight(12)),
                      Text(
                        "Patient Name",
                        style: TextStyle(
                            fontSize: responsiveFont(14),
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: responsiveHeight(20),
                      ),
                      Column(
                        children: [
                          AppRoundTextField(
                            controller: _campIDTextController,
                            inputStyle: TextStyle(
                                fontSize: responsiveFont(14),
                                color: kTextBlackColor),
                            inputType: TextInputType.number,
                            onChange: (p0) {},
                            maxLength: 12,
                            label: const Text(""),
                            hint: "Camp ID *",
                          ),
                          SizedBox(
                            height: responsiveHeight(20),
                          ),
                          AppRoundTextField(
                            controller: _campDateTextController,
                            inputStyle: TextStyle(
                                fontSize: responsiveFont(14),
                                color: kTextBlackColor),
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
                            label: const Text(""),
                            hint: "Camp Date *",
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
                            controller: _genderTextController,
                            inputStyle: TextStyle(
                                fontSize: responsiveFont(14),
                                color: kTextBlackColor),
                            inputType: TextInputType.text,
                            onTap: () {
                              genderBottomSheet(
                                  context,
                                  (p0) => {
                                        setState(() {
                                          _selectedGender = p0;
                                          _genderTextController.text =
                                              _selectedGender!['title'];
                                        })
                                      });
                            },
                            onChange: (p0) {},
                            readOnly: true,
                            maxLength: 12,
                            label: const Text(""),
                            hint: "Gender",
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
                                flex: 1,
                                child: AppRoundTextField(
                                  controller:
                                      _mobileNoCountryCodeTextController,
                                  inputStyle: TextStyle(
                                      fontSize: responsiveFont(14),
                                      color: kTextBlackColor),
                                  inputType: TextInputType.number,
                                  readOnly: true,
                                  onChange: (p0) {},
                                  maxLength: 4,
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
                                flex: 3,
                                child: AppRoundTextField(
                                  controller: _mobileNoTextController,
                                  inputStyle: TextStyle(
                                      fontSize: responsiveFont(14),
                                      color: kTextBlackColor),
                                  inputType: TextInputType.number,
                                  onChange: (p0) {},
                                  maxLength: 10,
                                  label: const Text(""),
                                  hint: "Mobile No",
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: responsiveHeight(20),
                          ),
                          AppRoundTextField(
                            controller: _aadhaarNoTextController,
                            inputStyle: TextStyle(
                                fontSize: responsiveFont(14),
                                color: kTextBlackColor),
                            inputType: TextInputType.number,
                            onChange: (p0) {},
                            maxLength: 12,
                            label: const Text(""),
                            hint: "Aadhar Card",
                          ),
                          SizedBox(
                            height: responsiveHeight(20),
                          ),
                          AppRoundTextField(
                            controller: _abhaIDTextController,
                            inputStyle: TextStyle(
                                fontSize: responsiveFont(14),
                                color: kTextBlackColor),
                            inputType: TextInputType.number,
                            onChange: (p0) {},
                            maxLength: 12,
                            label: const Text(""),
                            hint: "ABHA ID",
                          ),
                          SizedBox(
                            height: responsiveHeight(20),
                          ),
                          AppAddressRoundTextField(
                            controller: _addressTextController,
                            maxLines: 5,
                            errorText: null,
                            inputStyle: TextStyle(
                                fontSize: responsiveFont(14),
                                color: kTextBlackColor),
                            onChange: (p0) {},
                            label: const Text(""),
                            inputType: TextInputType.multiline,
                            hint: "Address",
                          ),
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
                                  inputStyle: TextStyle(
                                      fontSize: responsiveFont(14),
                                      color: kTextBlackColor),
                                  inputType: TextInputType.phone,
                                  label: RichText(
                                    text: TextSpan(
                                      text: 'Pincode',
                                      style: TextStyle(
                                          color: kLabelTextColor,
                                          fontSize: responsiveFont(14)),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: '',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: responsiveFont(14)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  hint: "Pincode",
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
                                    textCapitalization: TextCapitalization.none,
                                    inputType: TextInputType.datetime,
                                    inputStyle: TextStyle(
                                        fontSize: responsiveFont(14),
                                        color: kTextBlackColor),
                                    readOnly: true,
                                    label: RichText(
                                      text: TextSpan(
                                        text: 'District',
                                        style: TextStyle(
                                            color: kLabelTextColor,
                                            fontSize: responsiveFont(14)),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: '',
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: responsiveFont(14)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    hint: "District",
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
                                  controller: _talukaTextController,
                                  readOnly: true,
                                  maxLength: 10,
                                  inputStyle: TextStyle(
                                      fontSize: responsiveFont(14),
                                      color: kTextBlackColor),
                                  inputType: TextInputType.phone,
                                  label: RichText(
                                    text: TextSpan(
                                      text: 'Taluka',
                                      style: TextStyle(
                                          color: kLabelTextColor,
                                          fontSize: responsiveFont(14)),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: '',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: responsiveFont(14)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  hint: "Taluka",
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
                                    controller: _cityTextController,
                                    textCapitalization: TextCapitalization.none,
                                    inputType: TextInputType.datetime,
                                    inputStyle: TextStyle(
                                        fontSize: responsiveFont(14),
                                        color: kTextBlackColor),
                                    readOnly: true,
                                    label: RichText(
                                      text: TextSpan(
                                        text: 'City',
                                        style: TextStyle(
                                            color: kLabelTextColor,
                                            fontSize: responsiveFont(14)),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: '',
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: responsiveFont(14)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    hint: "City",
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
                            height: responsiveHeight(30),
                          ),
                          AppButton(
                            title: "Register",
                            iconData: Icon(
                              Icons.arrow_forward,
                              color: kWhiteColor,
                              size: responsiveHeight(24),
                            ),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.registeredUserMaster);
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
    ));
  }
}
