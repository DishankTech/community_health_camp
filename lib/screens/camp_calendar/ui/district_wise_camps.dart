import 'dart:convert';

import 'package:community_health_app/core/constants/fonts.dart';
import 'package:community_health_app/core/constants/images.dart';
import 'package:community_health_app/core/routes/app_routes.dart';
import 'package:community_health_app/core/utilities/date_not_found.dart';
import 'package:community_health_app/core/utilities/size_config.dart';
import 'package:community_health_app/screens/camp_calendar/model/camp_list_response_model.dart';
import 'package:community_health_app/screens/camp_calendar/model/date_wise_camps_model.dart';
import 'package:community_health_app/screens/camp_calendar/model/district_wise_camps_model.dart';
import 'package:community_health_app/screens/dashboard/model/dashboard_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:pinput/pinput.dart';

import '../../../core/common_widgets/app_bar_v1.dart';
import '../../../core/constants/constants.dart';

class DistrictWiseCampsScreen extends StatefulWidget {
  // Datum campDetailsList;
  List<Map<String, dynamic>> campDetailsList;
  String locationName;
  String totalCamps;

  DistrictWiseCampsScreen(this.campDetailsList, this.locationName, this.totalCamps, {super.key});

  // const DistrictWiseCampsScreen(this.campDetailsList, {super.key});

  @override
  State<DistrictWiseCampsScreen> createState() => _DistrictWiseCampsScreen();
}

class _DistrictWiseCampsScreen extends State<DistrictWiseCampsScreen> {
  List<DistrictCampDetails> _districtWiseCampList = [];

  bool isLoading = false;

  // late Datum campDetails;

  late TextEditingController _districtName;
  late TextEditingController _date;

  @override
  void initState() {
    super.initState();

    _districtName = TextEditingController();
    _date = TextEditingController();
    /* WidgetsBinding.instance.addPostFrameCallback((_) {
      campDetails = ModalRoute.of(context)!.settings.arguments as Datum;

      _districtName.text = campDetails.locationMasterId.toString();
      _date.text = campDetails.propCampDate.toString();
    });*/

    _districtName.text = widget.locationName.toString();
    // _date.text = widget.campDetailsList.propCampDate.toString();

    loadInit();

    /*  _districtWiseCampList.addAll([
      DistrictWiseCampsModel(campId: "243305", campName: "Health Camp", campLocation: "Panchsheel Hospital, 368 /, Nana Peth,Pune 411042", noOfPatientRegisteredforCamp: "210"),
      DistrictWiseCampsModel(campId: "243306", campName: "Health Camp", campLocation: "K.E.M. Hospital, 580/2, Rasta Peth, Vaidya Nanal Shastri Path, Pune 411011", noOfPatientRegisteredforCamp: "45"),
      DistrictWiseCampsModel(campId: "243381", campName: "Health Camp", campLocation: "Joshi Hospital, Opposite Kamala Nehru Park,778, Shivajinagar, Pune 411004", noOfPatientRegisteredforCamp: "24"),
      DistrictWiseCampsModel(campId: "243345", campName: "Health Camp", campLocation: "S. Hospital, 32/2, Erandwane, Near Mehendale Garage, Pune 411004", noOfPatientRegisteredforCamp: "31"),
    ]);*/
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
              onBackButtonPress: () {
                Navigator.pop(context);
              },
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
                )*/
            ),
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
                            Text("District : ", style: TextStyle(fontSize: responsiveFont(14), color: kBlackColor, fontWeight: FontWeight.bold)),
                            Text(_districtName.text),
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
                              "Date : ",
                              style: TextStyle(fontSize: responsiveFont(14), color: kBlackColor, fontWeight: FontWeight.bold),
                            ),
                            Text(_date.text),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Total Camps",
                          style: TextStyle(fontWeight: FontWeight.bold),
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
                                widget.totalCamps,
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
            _districtWiseCampList.isEmpty
                ? DataNotFound()
                : Expanded(
                    child: ListView.builder(
                        itemCount: _districtWiseCampList.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          print("_districtWiseCampList" + _districtWiseCampList.length.toString());
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, AppRoutes.campWiseRegisteredPatients);
                            },
                            child: isLoading
                                ? Container(
                                    width: SizeConfig.designScreenWidth,
                                    height: SizeConfig.screenHeight * 0.7,
                                    color: Colors.black.withOpacity(0.3), // Semi-transparent overlay
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        CircularProgressIndicator(color: Colors.red),
                                        SizedBox(height: 10),
                                        Text(
                                          'Please wait..',
                                          style: TextStyle(
                                            color: Colors.white, // Text color for visibility
                                            fontFamily: Montserrat,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(
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
                                                padding: EdgeInsets.only(left: 10, right: 10, top: 4, bottom: 4),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(
                                                      Radius.circular(10),
                                                    ),
                                                    color: kPrimaryColor),
                                                child: Text(
                                                  "",
                                                  style: TextStyle(color: kWhiteColor, fontWeight: FontWeight.bold, fontFamily: "Montserrat"),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
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
                                                  Text(_districtWiseCampList[index].campCreateRequestId.toString()),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              /*  Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Camp Name : ",
                                          style: TextStyle(fontSize: responsiveFont(14), color: kBlackColor, fontWeight: FontWeight.bold),
                                        ),
                                        Text(_districtWiseCampList[index].c, style: TextStyle(fontSize: responsiveFont(14), color: kBlackColor, fontWeight: FontWeight.normal)),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),*/
                                              RichText(
                                                text: TextSpan(
                                                  text: "Camp Location : ",
                                                  style: TextStyle(fontFamily: Montserrat, color: kBlackColor, fontSize: responsiveFont(14), fontWeight: FontWeight.bold),
                                                  children: [
                                                    TextSpan(
                                                        text: _districtWiseCampList[index].locationName,
                                                        style: TextStyle(fontFamily: Montserrat, fontSize: responsiveFont(14), color: kBlackColor, fontWeight: FontWeight.normal))
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

  Future<List<DistrictCampDetails>> getAllDistrictWiseCamps() async {
    setState(() {
      isLoading = true;
    });

    // var locationId = widget.campDetailsList['lookup_det_hier_id'].toString();
    var locationId = 0;

    var url = Uri.parse('http://210.89.42.117:8085/api/administrator/masters/get/district-wise-camp-details/$locationId');

    print(url);

    var headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.post(url);

      if (response.statusCode == 200) {
        print(response.body);

        var jsonResponse = json.decode(response.body);

        if (jsonResponse['message'] == "Data Not Found") {
          _districtWiseCampList = [];
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Data Not Found',
              ),
              backgroundColor: Colors.red,
            ),
          );
        } else {
          DistrictWiseCampsModel districtWiseCampsModel = DistrictWiseCampsModel.fromJson(jsonResponse);

          _districtWiseCampList = districtWiseCampsModel.details;
        }

        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print(e);

      setState(() {
        isLoading = false;
      });
    }

    return _districtWiseCampList;
  }

  void loadInit() {
    getAllDistrictWiseCamps();
  }
}
