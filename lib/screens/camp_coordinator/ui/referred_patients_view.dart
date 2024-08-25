import 'dart:convert';

import 'package:community_health_app/core/common_widgets/app_bar_v1.dart';
import 'package:community_health_app/core/constants/constants.dart';
import 'package:community_health_app/core/constants/fonts.dart';
import 'package:community_health_app/core/routes/app_routes.dart';
import 'package:community_health_app/core/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../../../core/constants/images.dart';
import '../models/referred_patients_resp_model.dart';

class ReferredPatientListScreen extends StatefulWidget {
  const ReferredPatientListScreen({super.key});

  @override
  State<ReferredPatientListScreen> createState() => _ReferredPatientListScreenState();
}

class _ReferredPatientListScreenState extends State<ReferredPatientListScreen> {
  bool isLoading = false;

  List<ReferredPatientList> patientsList = [];

  @override
  void initState() {
    super.initState();

    loadInit();
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
              title: "Patient Referred List",
              context: context,
            ),
            isLoading
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
                : Expanded(
                    child: ListView.builder(
                        itemCount: patientsList.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          // String name = getNameById(locationData, patientsList[index].locationMasterId);
                          return Container(
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [BoxShadow(offset: Offset(0, 0), color: Colors.grey.withOpacity(0.5), spreadRadius: 1, blurRadius: 5)],
                                borderRadius: BorderRadius.circular(responsiveHeight(20))),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        patientsList[index].patientName,
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
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
                                        "Mobile No. : ",
                                        style: TextStyle(fontSize: responsiveFont(14), color: kBlackColor, fontWeight: FontWeight.bold),
                                      ),
                                      Text(patientsList[index].contactNumber.toString()),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: "Referred To : ",
                                      style: TextStyle(
                                          color: kTextColor,
                                          fontFamily: Montserrat,
                                          fontSize: responsiveFont(15),
                                          fontWeight: FontWeight.bold),
                                      children: [
                                        TextSpan(
                                            text:patientsList[index].stakeholderNamesEn.toString(),
                                            style: TextStyle(
                                              fontFamily: Montserrat,
                                                  fontSize: responsiveFont(15),
                                                color: kTextColor,
                                                fontWeight:
                                                FontWeight.normal))
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          );
                        }))
          ],
        ),
      ),
    );
  }

  Future<void> loadInit() async {
    getAllPatientsList();
  }

  Future<List<ReferredPatientList>> getAllPatientsList() async {
    setState(() {
      isLoading = true;
    });
    var url = Uri.parse('http://210.89.42.117:8085/api/administrator/masters/get/patient-ref-details/');

    var headers = {'Content-Type': 'application/json'};

    var body = json.encode({
      "filter_date": "",
    });

    try {
      patientsList = [];
      // Use the post method directly to get the response
      http.Response response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        print(response.body);
        var jsonResponse = json.decode(response.body);

        CampsReferredPatientsRespModel campResponse = CampsReferredPatientsRespModel.fromJson(jsonResponse);
        patientsList = campResponse.details;

        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Exception: $e');
    }

    return patientsList;
  }

  Future<List<Map<String, dynamic>>> fetchLocationData() async {
    final url = Uri.parse('http://210.89.42.117:8085/api/administrator/masters/dropdown/location-list');

    try {
      final response = await http.post(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> details = data['details'];

        return details.map((item) {
          return {
            'location_master_id': item['location_master_id'],
            // 'lookup_det_hier_desc_en': item['lookup_det_hier_desc_en'],
            'location_name': item['location_name'],
          };
        }).toList();
      } else {
        throw Exception('Failed to load data: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Exception occurred: $e');
    }
  }

// Function to get name by id
  String getNameById(List<Map<String, dynamic>> data, int? id) {
    try {
      // Find the map where id matches
      Map<String, dynamic> item = data.firstWhere((map) => map['location_master_id'] == id);

      // Return the name associated with the id
      return item['location_name'] as String;
    } catch (e) {
      // Handle case where id is not found
      return 'ID not found';
    }
  }
}
