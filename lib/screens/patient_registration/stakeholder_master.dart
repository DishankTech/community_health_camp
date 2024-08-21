import 'package:community_health_app/core/common_widgets/app_bar_v1.dart';
import 'package:community_health_app/core/common_widgets/app_button.dart';
import 'package:community_health_app/core/common_widgets/app_round_textfield.dart';
import 'package:community_health_app/core/common_widgets/drop_down.dart';
import 'package:community_health_app/core/constants/constants.dart';
import 'package:community_health_app/core/constants/images.dart';
import 'package:community_health_app/core/utilities/size_config.dart';
import 'package:flutter/material.dart';
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
  bool _isObscure = true;

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
    return Scaffold(
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
                          inputStyle: TextStyle(
                              fontSize: responsiveFont(14),
                              color: kTextBlackColor),
                          inputType: TextInputType.text,
                          onChange: (p0) {},
                          onTap: () {
                            stakeholderBottomSheet(context, (p0) => null);
                          },
                          maxLength: 12,
                          readOnly: true,
                          label: const Text(""),
                          hint: "Stakeholder Type *",
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
                          inputStyle: TextStyle(
                              fontSize: responsiveFont(14),
                              color: kTextBlackColor),
                          inputType: TextInputType.text,
                          onChange: (p0) {},
                          onTap: () {
                            stakeholderBottomSheet(context, (p0) => null);
                          },
                          maxLength: 12,
                          readOnly: true,
                          label: const Text(""),
                          hint: "Stakeholder Sub Type *",
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
                          inputStyle: TextStyle(
                              fontSize: responsiveFont(14),
                              color: kTextBlackColor),
                          inputType: TextInputType.name,
                          onChange: (p0) {},
                          maxLength: 12,
                          readOnly: true,
                          label: const Text(""),
                          hint: "Stakeholder Name*",
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
                                controller: _mobileNoCountryCodeTextController,
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
                              flex: 3,
                              child: AppRoundTextField(
                                controller: _mobileNoTextController,
                                inputStyle: TextStyle(
                                    fontSize: responsiveFont(14),
                                    color: kTextBlackColor),
                                inputType: TextInputType.phone,
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
                            label: const SizedBox.shrink(),
                            controller: _emailIdTextController,
                            inputType: TextInputType.emailAddress,
                            hint: "Email Id"),
                        SizedBox(
                          height: responsiveHeight(20),
                        ),
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: AppRoundTextField(
                                controller: _districtTextController,
                                readOnly: true,
                                inputStyle: TextStyle(
                                    fontSize: responsiveFont(14),
                                    color: kTextBlackColor),
                                inputType: TextInputType.text,
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
                                hint: "District*",
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
                                  controller: _talukaTextController,
                                  textCapitalization: TextCapitalization.none,
                                  inputType: TextInputType.text,
                                  inputStyle: TextStyle(
                                      fontSize: responsiveFont(14),
                                      color: kTextBlackColor),
                                  readOnly: true,
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
                                  hint: "Taluka*",
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
                                inputStyle: TextStyle(
                                    fontSize: responsiveFont(14),
                                    color: kTextBlackColor),
                                inputType: TextInputType.text,
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
                                  inputStyle: TextStyle(
                                      fontSize: responsiveFont(14),
                                      color: kTextBlackColor),
                                  readOnly: true,
                                  label: RichText(
                                    text: TextSpan(
                                      text: 'Division',
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
                                  hint: "Division",
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
                          label: const Text(""),
                          hint: "Pincode",
                        ),
                        SizedBox(
                          height: responsiveHeight(20),
                        ),
                        AppRoundTextField(
                            label: const SizedBox.shrink(),
                            controller: _address1TextController,
                            inputType: TextInputType.streetAddress,
                            hint: "Address 1"),
                        SizedBox(
                          height: responsiveHeight(20),
                        ),
                        AppRoundTextField(
                            label: const SizedBox.shrink(),
                            controller: _address2TextController,
                            inputType: TextInputType.streetAddress,
                            hint: "Address 2"),
                        SizedBox(
                          height: responsiveHeight(30),
                        ),
                        AppRoundTextField(
                          label: const SizedBox.shrink(),
                          controller: _statusTextController,
                          hint: "Status",
                          readOnly: true,
                          onTap: () {
                            stakeholderStatusBottomSheet(context, (p0) => null);
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
                              child: AppButton(
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
    ));
  }
}
