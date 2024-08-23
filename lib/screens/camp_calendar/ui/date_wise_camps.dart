import 'package:community_health_app/core/constants/images.dart';
import 'package:community_health_app/core/routes/app_routes.dart';
import 'package:community_health_app/core/utilities/size_config.dart';
import 'package:community_health_app/screens/camp_calendar/model/date_wise_camps_model.dart';
import 'package:community_health_app/screens/dashboard/model/dashboard_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../../core/common_widgets/app_bar_v1.dart';
import '../../../core/constants/constants.dart';

class DateWiseCampsScreen extends StatefulWidget {
  const DateWiseCampsScreen({super.key});

  @override
  State<DateWiseCampsScreen> createState() => _DateWiseCampsScreenState();
}

class _DateWiseCampsScreenState extends State<DateWiseCampsScreen> {
  List<DateWiseCampsModel> _dateWiseCampList = [];

  @override
  void initState() {
    super.initState();

    _dateWiseCampList.addAll([
      DateWiseCampsModel(district: "Pune", date: "1 Aug 2024", noOfCamps: "6"),
      DateWiseCampsModel(
          district: "Kolhapur", date: "1 Aug 2024", noOfCamps: "3"),
      DateWiseCampsModel(
          district: "Sangli", date: "1 Aug 2024", noOfCamps: "3"),
      DateWiseCampsModel(
          district: "Mumbai", date: "1 Aug 2024", noOfCamps: "1"),
      DateWiseCampsModel(
          district: "Nashik", date: "1 Aug 2024", noOfCamps: "3"),
      DateWiseCampsModel(
          district: "Nagpur", date: "1 Aug 2024", noOfCamps: "4"),
      DateWiseCampsModel(district: "Akola", date: "1 Aug 2024", noOfCamps: "1"),
    ]);
  }

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
            image:
                DecorationImage(image: AssetImage(patRegBg), fit: BoxFit.fill)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            mAppBarV1(
                title: "Date wise Camps",
                context: context,
                suffix: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(5),
                    onTap: () {},
                    child: Ink(
                      child: Image.asset(
                        icSquarePlus,
                        height: responsiveHeight(24),
                      ),
                    ),
                  ),
                )),
            Expanded(
                child: ListView.builder(
                    itemCount: _dateWiseCampList.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, AppRoutes.districtWiseCamps);
                        },
                        child: Container(
                          margin: EdgeInsets.all(5),
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
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("District : ",
                                            style: TextStyle(
                                                fontSize: responsiveFont(14),
                                                color: kBlackColor,
                                                fontWeight: FontWeight.bold)),
                                        Text(_dateWiseCampList[index].district),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Date : ",
                                          style: TextStyle(
                                              fontSize: responsiveFont(14),
                                              color: kBlackColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(_dateWiseCampList[index].date),
                                      ],
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Total Camps",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
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
                                            _dateWiseCampList[index].noOfCamps,
                                            style: TextStyle(
                                                color: kWhiteColor,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "Montserrat"),
                                          )),
                                        ],
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                      ),
                                    ),
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
