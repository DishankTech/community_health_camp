import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/common_widgets/app_bar_v1.dart';
import '../../../core/common_widgets/app_button.dart';
import '../../../core/common_widgets/app_round_textfield.dart';
import '../../../core/constants/constants.dart';
import '../../../core/constants/fonts.dart';
import '../../../core/constants/images.dart';
import '../../../core/utilities/size_config.dart';

class AddTreatmentDetailsScreen extends StatefulWidget {
  const AddTreatmentDetailsScreen({super.key});

  @override
  State<AddTreatmentDetailsScreen> createState() =>
      _AddTreatmentDetailsScreenState();
}

class _AddTreatmentDetailsScreenState extends State<AddTreatmentDetailsScreen> {
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
        child: Column(
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
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 4),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 0),
                              color: Colors.grey.withOpacity(0.5),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                flex: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.blue),
                                      borderRadius: BorderRadius.circular(
                                          responsiveHeight(10))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Image.asset(
                                      "assets/images/img_female.png",
                                      fit: BoxFit.contain,
                                      // _list[i].image,
                                      height: responsiveHeight(54),
                                      width: responsiveWidth(54),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Anaya Mehra",
                                        style: TextStyle(
                                            fontSize: responsiveFont(14),
                                            color: kBlackColor,
                                            fontWeight: FontWeight.w500)),
                                    SizedBox(
                                      height: responsiveHeight(10),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            color: Colors.transparent,
                                            child: Row(
                                              children: [
                                                RichText(
                                                  text: TextSpan(
                                                    text: "Age: ",
                                                    style: TextStyle(
                                                        color: kTextColor,
                                                        fontSize:
                                                            responsiveFont(12),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    children: [
                                                      TextSpan(
                                                          text: "28 Yrs",
                                                          style: TextStyle(
                                                              fontSize:
                                                                  responsiveFont(
                                                                      12),
                                                              color: kTextColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal))
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            color: Colors.transparent,
                                            child: Row(
                                              children: [
                                                RichText(
                                                  text: TextSpan(
                                                    text: "Gender: ",
                                                    style: TextStyle(
                                                        color: kTextColor,
                                                        fontSize:
                                                            responsiveFont(12),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    children: [
                                                      TextSpan(
                                                          text: "Male",
                                                          style: TextStyle(
                                                              fontSize:
                                                                  responsiveFont(
                                                                      12),
                                                              color: kTextColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal))
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
                                      height: responsiveHeight(10),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: "Mobile No: ",
                                        style: TextStyle(
                                            color: kTextColor,
                                            fontSize: responsiveFont(12),
                                            fontWeight: FontWeight.bold),
                                        children: [
                                          TextSpan(
                                              text: "+91 5630178450",
                                              style: TextStyle(
                                                  fontSize: responsiveFont(12),
                                                  color: kTextColor,
                                                  fontWeight:
                                                      FontWeight.normal))
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: responsiveHeight(10),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: "Address: ",
                                        style: TextStyle(
                                            color: kTextColor,
                                            fontSize: responsiveFont(12),
                                            fontWeight: FontWeight.bold),
                                        children: [
                                          TextSpan(
                                            text:
                                                "26, Khanderao Bhavan, C.g. Road, Chakala, Andheri(e), 400099",
                                            style: TextStyle(
                                              fontSize: responsiveFont(12),
                                              color: kTextColor,
                                              fontWeight: FontWeight.normal,
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
                      padding: const EdgeInsets.fromLTRB(20, 30, 20, 4),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: responsiveHeight(400),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(0, 0),
                                color: Colors.grey.withOpacity(0.5),
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
                              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding:
                                    const EdgeInsets.fromLTRB(12, 0, 12, 0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: kTextFieldBorder,
                                    width: 1,
                                  ),
                                ),
                                height: 110,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: responsiveHeight(4),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 2, 0, 2),
                                      color: Colors.transparent,
                                      child: Text(
                                        "Symptoms",
                                        style: TextStyle(
                                          fontSize: responsiveFont(12),
                                          color: dashboardSubTitle,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    TextField(
                                      style: TextStyle(
                                        fontSize: responsiveFont(12),
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      maxLength: 500,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "",
                                        counterText: "",
                                        hintStyle: TextStyle(
                                          fontSize: responsiveFont(12),
                                          color: dashboardSubTitle,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding:
                                    const EdgeInsets.fromLTRB(12, 0, 12, 0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: kTextFieldBorder,
                                    width: 1,
                                  ),
                                ),
                                height: 110,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: responsiveHeight(4),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 2, 0, 2),
                                      color: Colors.transparent,
                                      child: Text(
                                        "Provisional Diagnosis",
                                        style: TextStyle(
                                          fontSize: responsiveFont(12),
                                          color: dashboardSubTitle,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    TextField(
                                      style: TextStyle(
                                        fontSize: responsiveFont(12),
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      maxLength: 500,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "",
                                        counterText: "",
                                        hintStyle: TextStyle(
                                          fontSize: responsiveFont(14),
                                          color: dashboardSubTitle,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                              child: AppRoundTextField(
                                controller: TextEditingController(),
                                inputStyle: TextStyle(
                                    fontSize: responsiveFont(14),
                                    color: kTextBlackColor),
                                onChange: (p0) {},
                                onTap: () {
                                  // List<Map<String, dynamic>> list = [
                                  //   {"title": "Hospital", "id": 1},
                                  //   {"title": "NGO", "id": 2},
                                  //   {"title": "STEM", "id": 3},
                                  //   {"title": "USER", "id": 4}
                                  // ];
                                  // commonBottonSheet(
                                  //     context,
                                  //     (p0) => {
                                  //           setState(() {
                                  //             selectedDesignationType = p0;
                                  //             referredTo.text = selectedDesignationType!['title'];
                                  //           })
                                  //         },
                                  //     "Referred To",
                                  //     list);
                                },
                                readOnly: true,
                                label: RichText(
                                  text: const TextSpan(
                                      text: 'Referred To',
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
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: responsiveHeight(80),
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: AppButton(
                                onTap: () {
                                  Navigator.pop(context);
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
                                  Navigator.pop(context);
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
        ),
      ),
    );
  }
}
