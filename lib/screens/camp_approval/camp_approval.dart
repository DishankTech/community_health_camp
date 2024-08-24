import 'package:community_health_app/core/common_widgets/app_bar_v1.dart';
import 'package:community_health_app/core/constants/constants.dart';
import 'package:community_health_app/core/constants/images.dart';
import 'package:community_health_app/core/utilities/size_config.dart';
import 'package:community_health_app/screens/camp_approval/camp_approval_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CampApprovalScreen extends StatefulWidget {
  const CampApprovalScreen({super.key});

  @override
  State<CampApprovalScreen> createState() => _CampApprovalScreenState();
}

class _CampApprovalScreenState extends State<CampApprovalScreen> {
  List<CampApprovalModal> _list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _list.addAll([
      CampApprovalModal(
          campReqId: '865304',
          locationName: '32/2, Erandwane, Near Mehendale Garage, Pune 411004',
          district: 'Pune',
          stakeHodlerType: 'Hospital',
          campDateTime: '21 Aug 2024  |  8.00 am to 6.00 pm'),
      CampApprovalModal(
          campReqId: '521049',
          locationName: 'Opposite Kamala Nehru Park, 778, Shivajinagar, Pune 411004',
          district: 'Pune',
          stakeHodlerType: 'NGO',
          campDateTime: '14 Aug 2024  |  9.00 am to 4.00 pm'),
      CampApprovalModal(
          campReqId: '365410',
          locationName: '163, DP Road, Aundh, Pune 411007',
          district: 'Pune',
          stakeHodlerType: 'STEM',
          campDateTime: '14 Aug 2024  |  9.00 am to 4.00 pm'),
      CampApprovalModal(
          campReqId: '987413',
          locationName: 'D.A.V. In front of School, Aundh, Pune 411007',
          district: 'Pune',
          stakeHodlerType: 'User',
          campDateTime: '5 Aug 2024  |  8.30 am to 5.30 pm')
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
            title: "Camp Approval",
            context: context,
            onBackButtonPress: (){
              Navigator.pop(context);
            },
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
                                  offset: Offset(0, 0),
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

                              SizedBox(
                                width: responsiveWidth(16),
                              ),
                              Flexible(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    RichText(
                                      text: TextSpan(
                                        text: "Camp Request ID : ",
                                        style: TextStyle(
                                            color: kTextColor,
                                            fontSize: responsiveFont(12),
                                            fontWeight: FontWeight.bold),
                                        children: [
                                          TextSpan(
                                              text: _list[i].campReqId,
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
                                        text: "Location Name: ",
                                        style: TextStyle(
                                            color: kTextColor,
                                            fontSize: responsiveFont(12),
                                            fontWeight: FontWeight.bold),
                                        children: [
                                          TextSpan(
                                              text: _list[i].locationName,
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
                                        text: "District: ",
                                        style: TextStyle(
                                            color: kTextColor,
                                            fontSize: responsiveFont(12),
                                            fontWeight: FontWeight.bold),
                                        children: [
                                          TextSpan(
                                              text: _list[i].district,
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
                                        text: "Stakeholder Type: ",
                                        style: TextStyle(
                                            color: kTextColor,
                                            fontSize: responsiveFont(12),
                                            fontWeight: FontWeight.bold),
                                        children: [
                                          TextSpan(
                                              text: _list[i].stakeHodlerType,
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
                                        text: "Proposed Camp date-time: ",
                                        style: TextStyle(
                                            color: kTextColor,
                                            fontSize: responsiveFont(12),
                                            fontWeight: FontWeight.bold),
                                        children: [
                                          TextSpan(
                                              text: _list[i].campDateTime,
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
                      child:  Material(
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
                    ),
                  ]);
                }),
          )
        ],
      ),
    ));
  }
}
