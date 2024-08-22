import 'package:community_health_app/core/constants/fonts.dart';
import 'package:community_health_app/core/constants/images.dart';
import 'package:community_health_app/core/routes/app_routes.dart';
import 'package:community_health_app/core/utilities/size_config.dart';
import 'package:community_health_app/screens/camp_calendar/model/date_wise_camps_model.dart';
import 'package:community_health_app/screens/camp_calendar/model/district_wise_camps_model.dart';
import 'package:community_health_app/screens/dashboard/model/dashboard_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../../core/common_widgets/app_bar_v1.dart';
import '../../../core/constants/constants.dart';

class DistrictWiseCampsScreen extends StatefulWidget {
  const DistrictWiseCampsScreen({super.key});

  @override
  State<DistrictWiseCampsScreen> createState() => _DistrictWiseCampsScreen();
}

class _DistrictWiseCampsScreen extends State<DistrictWiseCampsScreen> {
  List<DistrictWiseCampsModel> _districtWiseCampList = [];

  @override
  void initState() {
    super.initState();

    _districtWiseCampList.addAll([
      DistrictWiseCampsModel(campId: "243305", campName: "Health Camp", campLocation: "Panchsheel Hospital, 368 /, Nana Peth,Pune 411042", noOfPatientRegisteredforCamp: "210"),
      DistrictWiseCampsModel(campId: "243306", campName: "Health Camp", campLocation: "K.E.M. Hospital, 580/2, Rasta Peth, Vaidya Nanal Shastri Path, Pune 411011", noOfPatientRegisteredforCamp: "45"),
      DistrictWiseCampsModel(campId: "243381", campName: "Health Camp", campLocation: "Joshi Hospital, Opposite Kamala Nehru Park,778, Shivajinagar, Pune 411004", noOfPatientRegisteredforCamp: "24"),
      DistrictWiseCampsModel(campId: "243345", campName: "Health Camp", campLocation: "S. Hospital, 32/2, Erandwane, Near Mehendale Garage, Pune 411004", noOfPatientRegisteredforCamp: "31"),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Change to your desired color
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light, // For light text/icons on the status bar
    ));

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(patRegBg), fit: BoxFit.fill)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            mAppBarV1(
                title: "District wise Camps",
                context: context,
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
                )*/),
            Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(offset: Offset(0, 0), color: Colors.grey.withOpacity(0.5), spreadRadius: 1, blurRadius: 5)],
                  borderRadius: BorderRadius.circular(responsiveHeight(20))),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("District : ",style: TextStyle(
                                fontSize: responsiveFont(14),
                                color: kBlackColor,
                                fontWeight: FontWeight.bold)),
                            Text("Pune"),
                          ],
                        ),
                        SizedBox(height: 2,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Date : ",style: TextStyle(fontSize: responsiveFont(14),
                                color: kBlackColor,fontWeight: FontWeight.bold),),
                            Text("1 Aug 2024"),
                          ],
                        ),


                      ],
                    ),
                    Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Total Camps",style: TextStyle(fontWeight: FontWeight.bold),),
                        SizedBox(height: 4,),
                        Container(
                          width: 35,
                          height: 35,
                          margin: EdgeInsets.only(right: 5),
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(40),
                              ),
                              color: kPrimaryDarkColor),
                          child: Column(
                            children: [
                              Container(
                                  child: Text(
                                    "6",
                                    style: TextStyle(color: kWhiteColor, fontWeight: FontWeight.bold, fontFamily: "Montserrat"),
                                  )),
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: _districtWiseCampList.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.campWiseRegisteredPatients);
                        },
                        child: Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [BoxShadow(offset: Offset(0, 0), color: Colors.grey.withOpacity(0.5), spreadRadius: 1, blurRadius: 5)],
                              borderRadius: BorderRadius.circular(responsiveHeight(20))),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Total Registered Patients : ",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 4, right: 4),
                                      padding: EdgeInsets.only(left: 10,right: 10,top: 4,bottom: 4),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          color: kPrimaryColor),
                                      child: Text(
                                        _districtWiseCampList[index].noOfPatientRegisteredforCamp,
                                        style: TextStyle(color: kWhiteColor, fontWeight: FontWeight.bold, fontFamily: "Montserrat"),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 4,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Camp ID : ",
                                          style: TextStyle(fontSize: responsiveFont(14), color: kBlackColor, fontWeight: FontWeight.bold),
                                        ),
                                        Text(_districtWiseCampList[index].campId),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Camp Name : ",
                                          style: TextStyle(fontSize: responsiveFont(14), color: kBlackColor, fontWeight: FontWeight.bold),
                                        ),
                                        Text(_districtWiseCampList[index].campName, style: TextStyle(fontSize: responsiveFont(14), color: kBlackColor, fontWeight: FontWeight.normal)),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: "Camp Location : ",
                                        style: TextStyle(fontFamily: Lato, color: kBlackColor, fontSize: responsiveFont(14), fontWeight: FontWeight.bold),
                                        children: [
                                          TextSpan(
                                              text: _districtWiseCampList[index].campLocation,
                                              style: TextStyle(fontFamily: Lato, fontSize: responsiveFont(14), color: kBlackColor, fontWeight: FontWeight.normal))
                                        ],
                                      ),
                                    ),
                                    /* Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Camp Location : ",
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        Text(_districtWiseCampList[index].campLocation,textAlign: TextAlign.justify,softWrap: true,),
                                      ],
                                    ),*/
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
