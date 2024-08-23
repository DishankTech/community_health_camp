import 'package:community_health_app/core/common_widgets/app_bar_v1.dart';
import 'package:community_health_app/core/constants/constants.dart';
import 'package:community_health_app/core/constants/fonts.dart';
import 'package:community_health_app/core/constants/images.dart';
import 'package:community_health_app/core/routes/app_routes.dart';
import 'package:community_health_app/core/utilities/size_config.dart';
import 'package:community_health_app/screens/patient_registration/models/registered_patient_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class CampWiseRegisteredPatientsScreen extends StatefulWidget {
  const CampWiseRegisteredPatientsScreen({super.key});

  @override
  State<CampWiseRegisteredPatientsScreen> createState() =>
      _CampWiseRegisteredPatientsScreenState();
}

class _CampWiseRegisteredPatientsScreenState
    extends State<CampWiseRegisteredPatientsScreen> {
  List<RegisteredPatientModel> _list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _list.addAll([
      RegisteredPatientModel(
          address:
              "Address : R-603, Midc, Thane Belapur Rd, Rabale,Navi Mumbai, 400701",
          campDate: "21 Aug 2024",
          campName: "Health Camp",
          mobile: "+91 5630178450",
          name: "Abhinandan Vohra",
          image: pat1),
      RegisteredPatientModel(
          address:
              "Address : R-603, Midc, Thane Belapur Rd, Rabale,Navi Mumbai, 400701",
          campDate: "19 Aug 2024",
          campName: "Health Camp",
          mobile: "+91 6398740210",
          name: "Anaya Mehra",
          image: pat2),
      RegisteredPatientModel(
          address:
              "Address : R-603, Midc, Thane Belapur Rd, Rabale,Navi Mumbai, 400701",
          campDate: "18 Aug 2024",
          campName: "Health Camp",
          mobile: "+91 3210456008",
          name: "Imran Siddiqui",
          image: pat3),
      RegisteredPatientModel(
          address:
              "Address : Shop 13, C, Shyam Kamal Bldg, Opp Parle Intl Hotel, Vile Parle (east), 400057",
          campDate: "10 Aug 2024",
          campName: "Health Camp",
          mobile: "+91 6541026874",
          name: "Sanjay Desai",
          image: pat1),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Change to your desired color
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness:
          Brightness.light, // For light text/icons on the status bar
    ));
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          image:
              DecorationImage(image: AssetImage(patRegBg), fit: BoxFit.fill)),
      child: Column(
        children: [
          mAppBarV1(
            title: "Camp Wise Registered Patients",
            context: context,
            onBackButtonPress: (){
              Navigator.pop(context);
            },
            /* suffix: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(5),
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.patientRegScreen);
                },
                child: Ink(
                  child: Image.asset(
                    icSquarePlus,
                    height: responsiveHeight(24),
                  ),
                ),
              ),
            ),*/
          ),
          Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 0),
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5)
                ],
                borderRadius: BorderRadius.circular(responsiveHeight(20))),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Total Registered Patients",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        clipBehavior: Clip.hardEdge,
                        padding: const EdgeInsets.only(
                            left: 4, right: 4, top: 4, bottom: 4),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                            color: kPrimaryColor),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "210",
                              style: TextStyle(
                                  color: kWhiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: Montserrat,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        "Total Camps ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      Container(
                        width: 35,
                        height: 35,
                        margin: const EdgeInsets.only(right: 5),
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(40),
                            ),
                            color: kPrimaryDarkColor),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "6",
                              style: TextStyle(
                                  color: kWhiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Montserrat",
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("District : ",
                          style: TextStyle(
                              fontSize: responsiveFont(14),
                              color: kBlackColor,
                              fontWeight: FontWeight.bold)),
                      const Text("Pune"),
                    ],
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Date : ",
                        style: TextStyle(
                            fontSize: responsiveFont(14),
                            color: kBlackColor,
                            fontWeight: FontWeight.bold),
                      ),
                      const Text("1 Aug 2024"),
                    ],
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Camp ID : ",
                        style: TextStyle(
                            fontSize: responsiveFont(14),
                            color: kBlackColor,
                            fontWeight: FontWeight.bold),
                      ),
                      const Text("243305"),
                    ],
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Camp Name : ",
                        style: TextStyle(
                            fontSize: responsiveFont(14),
                            color: kBlackColor,
                            fontWeight: FontWeight.bold),
                      ),
                      const Text("Health Camp"),
                    ],
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  RichText(
                    text: TextSpan(
                      text: "Camp Location : ",
                      style: TextStyle(
                          color: kBlackColor,
                          fontFamily: Montserrat,
                          fontSize: responsiveFont(14),
                          fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                            text:
                                "Panchsheel Hospital, 368 /, Nana Peth, Pune 411042",
                            style: TextStyle(
                                fontSize: responsiveFont(14),
                                color: kBlackColor,
                                fontWeight: FontWeight.normal))
                      ],
                    ),
                  ),
                ],
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
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(0, 0),
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 5)
                            ],
                            borderRadius:
                                BorderRadius.circular(responsiveHeight(20))),
                        child: Padding(
                          padding: EdgeInsets.all(responsiveHeight(20)),
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
                                    padding: const EdgeInsets.all(4.0),
                                    child: Image.asset(
                                      fit: BoxFit.cover,
                                      _list[i].image,
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
                                    Text(_list[i].name,
                                        style: TextStyle(
                                            fontSize: responsiveFont(14),
                                            color: kBlackColor,
                                            fontWeight: FontWeight.w500)),
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
                                              text: _list[i].mobile,
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
                                              text: _list[i].address,
                                              style: TextStyle(
                                                  fontSize: responsiveFont(12),
                                                  color: kTextColor,
                                                  fontWeight:
                                                      FontWeight.normal))
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: responsiveHeight(4),
                                    ),
                                  ],
                                ),
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
