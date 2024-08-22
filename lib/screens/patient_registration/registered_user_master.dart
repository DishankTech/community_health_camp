import 'package:community_health_app/core/common_widgets/app_bar_v1.dart';
import 'package:community_health_app/core/constants/constants.dart';
import 'package:community_health_app/core/constants/images.dart';
import 'package:community_health_app/core/routes/app_routes.dart';
import 'package:community_health_app/core/utilities/size_config.dart';
import 'package:community_health_app/screens/patient_registration/models/registered_patient_master_model.dart';
import 'package:flutter/material.dart';

class RegisteredUserMasterScreen extends StatefulWidget {
  const RegisteredUserMasterScreen({super.key});

  @override
  State<RegisteredUserMasterScreen> createState() =>
      _RegisteredUserMasterScreenState();
}

class _RegisteredUserMasterScreenState
    extends State<RegisteredUserMasterScreen> {
  List<RegisteredPatientMasterModel> _list = [];
  @override
  void initState() {
    super.initState();

    _list.addAll([
      RegisteredPatientMasterModel(
          designationType: "Type 1",
          stakeholderType: "NGO",
          stakeholderName: "Pragati Foundation",
          name: "Yashvi Kunal Bhandari",
          mobileNo: "+91 8520147630",
          email: "yashvi@gmail.com"),
      RegisteredPatientMasterModel(
          designationType: "Type 1",
          stakeholderType: "Hospital",
          stakeholderName: "Health Tarachand Ramnath Charitable Hospital Trust",
          name: "Radha Yash Subramanian",
          mobileNo: "+91 5241036987",
          email: "radha@gmail.com"),
      RegisteredPatientMasterModel(
          designationType: "Type 1",
          stakeholderType: "Hospital",
          stakeholderName: "Ca. Dinanath Mangeshkar Hospital",
          name: "Ayesha Madhav Mathur",
          mobileNo: "+91 8520147630",
          email: "ayesha@gmail.com"),
      RegisteredPatientMasterModel(
          designationType: "Type 1",
          stakeholderType: "STEM",
          stakeholderName: "Pragati Foundation",
          name: "Leena Amol Bhatia",
          mobileNo: "+91 8520147630",
          email: "leena@gmail.com"),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          image:
              DecorationImage(image: AssetImage(patRegBg), fit: BoxFit.fill)),
      child: Column(
        children: [
          mAppBarV1(
            title: "Registered User Master",
            context: context,
            suffix: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(5),
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.userMasterScreen);
                },
                child: Ink(
                  child: Image.asset(
                    icSquarePlus,
                    height: responsiveHeight(24),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: _list.length,
                padding: EdgeInsets.zero,
                itemBuilder: (c, i) {
                  return Stack(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: SizeConfig.screenWidth,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 0),
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 5)
                            ],
                            borderRadius:
                                BorderRadius.circular(responsiveHeight(20))),
                        child: Padding(
                          padding: EdgeInsets.all(responsiveHeight(20)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: "Stakeholder Type: ",
                                  style: TextStyle(
                                      color: kTextColor,
                                      fontSize: responsiveFont(12),
                                      fontWeight: FontWeight.bold),
                                  children: [
                                    TextSpan(
                                        text: _list[i].stakeholderType,
                                        style: TextStyle(
                                            fontSize: responsiveFont(12),
                                            color: kTextColor,
                                            fontWeight: FontWeight.normal))
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: responsiveHeight(10),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: "Stakeholder Name: ",
                                  style: TextStyle(
                                      color: kTextColor,
                                      fontSize: responsiveFont(12),
                                      fontWeight: FontWeight.bold),
                                  children: [
                                    TextSpan(
                                        text: _list[i].stakeholderName,
                                        style: TextStyle(
                                            fontSize: responsiveFont(12),
                                            color: kTextColor,
                                            fontWeight: FontWeight.normal))
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: responsiveHeight(10),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: "Full Name: ",
                                  style: TextStyle(
                                      color: kTextColor,
                                      fontSize: responsiveFont(12),
                                      fontWeight: FontWeight.bold),
                                  children: [
                                    TextSpan(
                                        text: _list[i].name,
                                        style: TextStyle(
                                            fontSize: responsiveFont(12),
                                            color: kTextColor,
                                            fontWeight: FontWeight.normal))
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: responsiveHeight(10),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: "Designation/Member Type : ",
                                  style: TextStyle(
                                      color: kTextColor,
                                      fontSize: responsiveFont(12),
                                      fontWeight: FontWeight.bold),
                                  children: [
                                    TextSpan(
                                        text: _list[i].designationType,
                                        style: TextStyle(
                                            fontSize: responsiveFont(12),
                                            color: kTextColor,
                                            fontWeight: FontWeight.normal))
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: responsiveHeight(10),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: "Mobile No : ",
                                  style: TextStyle(
                                      color: kTextColor,
                                      fontSize: responsiveFont(12),
                                      fontWeight: FontWeight.bold),
                                  children: [
                                    TextSpan(
                                        text: _list[i].mobileNo,
                                        style: TextStyle(
                                            fontSize: responsiveFont(12),
                                            color: kTextColor,
                                            fontWeight: FontWeight.normal))
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: responsiveHeight(10),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: "Email : ",
                                  style: TextStyle(
                                      color: kTextColor,
                                      fontSize: responsiveFont(12),
                                      fontWeight: FontWeight.bold),
                                  children: [
                                    TextSpan(
                                        text: _list[i].email,
                                        style: TextStyle(
                                            fontSize: responsiveFont(12),
                                            color: kTextColor,
                                            fontWeight: FontWeight.normal))
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: responsiveHeight(10),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      right: 20,
                      child: Row(
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(5),
                              onTap: () {},
                              child: Ink(
                                child: Image.asset(
                                  icEdit,
                                  height: responsiveHeight(24),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: responsiveHeight(10),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(5),
                              onTap: () {},
                              child: Ink(
                                child: Image.asset(
                                  icEye,
                                  height: responsiveHeight(24),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]);
                }),
          )
        ],
      ),
    ));
  }
}
