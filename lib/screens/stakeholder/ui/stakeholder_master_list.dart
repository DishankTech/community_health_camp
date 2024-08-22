import 'package:community_health_app/core/common_widgets/app_bar_v1.dart';
import 'package:community_health_app/core/constants/constants.dart';
import 'package:community_health_app/core/constants/images.dart';
import 'package:community_health_app/core/routes/app_routes.dart';
import 'package:community_health_app/core/utilities/size_config.dart';
import 'package:community_health_app/screens/patient_registration/models/registered_patient_master_model.dart';
import 'package:community_health_app/screens/stakeholder/models/stakeholder_master_list_model.dart';
import 'package:flutter/material.dart';

class StakeholderMasterList extends StatefulWidget {
  const StakeholderMasterList({super.key});

  @override
  State<StakeholderMasterList> createState() => _StakeholderMasterListState();
}

class _StakeholderMasterListState extends State<StakeholderMasterList> {
  List<StakeholderMasterListModel> _list = [];
  @override
  void initState() {
    super.initState();

    _list.addAll([
      StakeholderMasterListModel(
        stakeholderType: "NGO",
        stakeholderName: "Pragati Foundation",
        mobileNo: "+91 8520147630",
        address:
            "Plot No, 121, Lane Number 4, Dahanukar Colony,Kothrud, Pune, Maharashtra 411038",
        status: true,
      ),
      StakeholderMasterListModel(
        stakeholderType: "Hospital",
        stakeholderName: "Health Tarachand Ramnath Charitable Hospital Trust",
        mobileNo: "+91 5241036987",
        address:
            "Address : Level 1, Business Square, Lane 5, above Nature's Basket, Koregaon Park, Pune, Maharashtra 411001",
        status: true,
      ),
      StakeholderMasterListModel(
        stakeholderType: "Hospital",
        stakeholderName: "Ca. Dinanath Mangeshkar Hospital",
        mobileNo: "+91 8520147630",
        address:
            "Address : Millennium Star, Dhole Patil Rd, near Ruby Hall,Sangamvadi, Pune, Maharashtra 411025",
        status: true,
      ),
      StakeholderMasterListModel(
          stakeholderType: "STEM",
          stakeholderName: "Pragati Foundation",
          mobileNo: "+91 8520147630",
          address:
              "Address : Millennium Star, Dhole Patil Rd, near Ruby Hall,Sangamvadi, Pune, Maharashtra 411025",
          status: false),
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
            title: "Stakeholder Master",
            context: context,
            suffix: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(5),
                onTap: () {
                  Navigator.pushNamed(
                      context, AppRoutes.stakeholderMasterScreen);
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
                                  offset: const Offset(0, 0),
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
                                  text: "Address : ",
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
                              Row(
                                children: [
                                  Text(
                                    "Status: ",
                                    style: TextStyle(
                                        color: kTextColor,
                                        fontSize: responsiveFont(12),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: const Color(0xFF54BB44),
                                        borderRadius: BorderRadius.circular(
                                            responsiveHeight(10))),
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          responsiveHeight(6),
                                          responsiveHeight(3),
                                          responsiveHeight(6),
                                          responsiveHeight(3)),
                                      child: Text(
                                          _list[i].status
                                              ? "Active"
                                              : "InActive",
                                          style: TextStyle(
                                              fontSize: responsiveFont(11),
                                              color: kWhiteColor,
                                              fontWeight: FontWeight.w500)),
                                    ),
                                  )
                                ],
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
                              onTap: () {
                                Navigator.pushNamed(context,
                                    AppRoutes.stakeholderMasterEditScreen);
                              },
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