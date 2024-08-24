import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/common_widgets/app_bar_v1.dart';
import '../../../core/constants/constants.dart';
import '../../../core/constants/images.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/utilities/size_config.dart';

class DoctorDeskPatientsScreen extends StatefulWidget {
  const DoctorDeskPatientsScreen({super.key});

  @override
  State<DoctorDeskPatientsScreen> createState() =>
      _DoctorDeskPatientsScreenState();
}

class _DoctorDeskPatientsScreenState extends State<DoctorDeskPatientsScreen> {
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
              title: "Patients List",
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
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
              child: IntrinsicHeight(
                child: Container(
                  width: MediaQuery.of(context).size.width,
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Spacer(),
                            const Text(
                              "Total Registered Patients",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              width: responsiveWidth(8),
                            ),
                            Container(
                              // width: 40,
                              // height: 40,
                              clipBehavior: Clip.hardEdge,
                              padding: const EdgeInsets.only(
                                  left: 12, right: 12, top: 8, bottom: 8),
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
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: responsiveHeight(10),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                color: Colors.transparent,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Camp ID : ",
                                      style: TextStyle(
                                        fontSize: responsiveFont(12),
                                        color: kBlackColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      "243305",
                                      style: TextStyle(
                                        fontSize: responsiveFont(12),
                                        color: dashboardSubTitle,
                                        fontWeight: FontWeight.w500,
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Camp Date : ",
                                      style: TextStyle(
                                        fontSize: responsiveFont(12),
                                        color: kBlackColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      "21 Aug 2024",
                                      style: TextStyle(
                                        fontSize: responsiveFont(12),
                                        color: dashboardSubTitle,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: responsiveHeight(10),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Camp Name : ",
                              style: TextStyle(
                                fontSize: responsiveFont(12),
                                color: kBlackColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "Health Camp",
                              style: TextStyle(
                                fontSize: responsiveFont(12),
                                color: dashboardSubTitle,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: responsiveHeight(10),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Camp Location : ",
                              style: TextStyle(
                                fontSize: responsiveFont(12),
                                color: kBlackColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "Panchsheel Hospital, 368 /, Nana Peth, Pune 411042",
                                style: TextStyle(
                                  fontSize: responsiveFont(12),
                                  color: dashboardSubTitle,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
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
                                    RichText(
                                      text: TextSpan(
                                        text: "Mobile No: ",
                                        style: TextStyle(
                                            color: kTextColor,
                                            fontSize: responsiveFont(12),
                                            fontWeight: FontWeight.bold),
                                        children: [
                                          TextSpan(
                                              text: "+91 6398740210",
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
                                                fontWeight: FontWeight.normal),
                                          )
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
                    Positioned(
                      top: 20,
                      right: 20,
                      child: Row(
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(5),
                              onTap: () {
                                Navigator.pushNamed(context,
                                    AppRoutes.addTreatmentDetailsScreen);
                              },
                              child: Ink(
                                child: Image.asset(
                                  icEdit,
                                  height: responsiveHeight(36),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
