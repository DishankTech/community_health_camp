import 'dart:convert';

import 'package:community_health_app/core/constants/fonts.dart';
import 'package:community_health_app/core/constants/images.dart';
import 'package:community_health_app/core/routes/app_routes.dart';
import 'package:community_health_app/core/utilities/size_config.dart';
import 'package:community_health_app/screens/camp_calendar/model/date_wise_camps_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/common_widgets/app_bar_v1.dart';
import '../../../core/constants/constants.dart';
import 'package:http/http.dart' as http;

import '../model/camp_list_response_model.dart';

class DateWiseCampsScreen extends StatefulWidget {
  DateTime selectedDay;

  DateWiseCampsScreen(this.selectedDay, {super.key});

  @override
  State<DateWiseCampsScreen> createState() => _DateWiseCampsScreenState();
}

class _DateWiseCampsScreenState extends State<DateWiseCampsScreen> {
  List<DateWiseCampsModel> _dateWiseCampList = [];

  List<Map<String, dynamic>> locationData = [];
  late Future<List<Map<String, dynamic>>> _locationData;

  bool isLoading = false;

  List<Datum> campDetailsList = [];
  List<Datum> uniqueLocationList = [];

  List<String> campCount = [];

  List<String> idsWithEmptyDescription = [];

  @override
  void initState() {
    super.initState();

    loadInit();

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
                onBackButtonPress: () {
                  Navigator.pop(context);
                },
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
            isLoading
                ? Container(
                    width: SizeConfig.designScreenWidth,
                    height: SizeConfig.screenHeight * 0.7,
                    color: Colors.black
                        .withOpacity(0.3), // Semi-transparent overlay
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
                        itemCount: campDetailsList.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          // String name = getNameById(locationData, campDetailsList[index].locationMasterId);
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
                                  borderRadius: BorderRadius.circular(
                                      responsiveHeight(20))),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("District : ",
                                                style: TextStyle(
                                                    fontSize:
                                                        responsiveFont(14),
                                                    color: kBlackColor,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            // Text(campDetailsList[index].locationMasterId.toString()),
                                            Text(getNameById(
                                                locationData,
                                                campDetailsList[index]
                                                    .locationMasterId)),
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
                                            Text(campDetailsList[index]
                                                .propCampDate
                                                .toString()),
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
                                                campCount[index].toString(),
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

  Future<void> loadInit() async {
    _locationData = fetchLocationData();
    locationData = await _locationData;
    setState(() {
      locationData;
    });

    getAllCamps();
  }

  Future<List<Datum>> getAllCamps() async {
    /* setState(() {
      isLoading = true;
    });*/
    var url = Uri.parse(
        'http://210.89.42.117:8085/api/administrator/camp/all-camp-details-pagination');

    var headers = {'Content-Type': 'application/json'};

    var body = json.encode({
      "total_pages": 10,
      "page": 1,
      "total_count": 20,
      "per_page": 20,
      "data": null
    });

    try {
      campDetailsList = [];
      // Use the post method directly to get the response
      http.Response response =
          await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        print(response.body);
        var jsonResponse = json.decode(response.body);

        CampDetailsResponseModel campResponse =
            CampDetailsResponseModel.fromJson(jsonResponse);
        campDetailsList = campResponse.details.data;

        // The date to filter by
        String filterDate = widget.selectedDay.toString().split(' ')[0];

        // Filter the list by the date '2024-08-23'
        List<Datum> filteredList = campDetailsList.where((camp) {
          String campDate = camp.propCampDate
              .toString()
              .split(' ')[0]; // Extract the date part
          return campDate == filterDate;
        }).toList();

        Set<int> seenLocationIds = {};
        uniqueLocationList = [];
        // Print the filtered list
        print('Filtered Camps on $filterDate:');
        for (var camp in filteredList) {
          print(camp);
        }

        // Count occurrences of each location_master_id
        Map<int, int> locationCountMap = {};

        for (var camp in filteredList) {
          if (camp.locationMasterId != null) {
            int locationId = int.parse(camp.locationMasterId.toString());
            if (locationCountMap.containsKey(locationId)) {
              locationCountMap[locationId] = locationCountMap[locationId]! + 1;
            } else {
              locationCountMap[locationId] = 1;
            }
          }
        }

        // Print the count of occurrences of each location_master_id
        print('Count of occurrences of each location_master_id:');
        locationCountMap.forEach((locationId, count) {
          print('location_master_id: $locationId, count: $count');
          campCount.add(count.toString());
        });

        setState(() {
          campCount;
        });

        for (var camp in filteredList) {
          if (camp.locationMasterId != null) {
            int locationId = int.parse(camp.locationMasterId.toString());
            if (!seenLocationIds.contains(locationId)) {
              seenLocationIds.add(locationId);
              uniqueLocationList.add(camp);
            }
          }
        }

        // Print the final filtered list with unique location_master_id
        print('Filtered Camps on $filterDate with unique location_master_id:');
        for (var camp in uniqueLocationList) {
          print(camp);
        }

        campDetailsList = [];
        // campDetailsList.addAll(filteredList);
        campDetailsList.addAll(uniqueLocationList);

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

    return campDetailsList;
  }

  Future<List<Map<String, dynamic>>> fetchLocationData() async {
    setState(() {
      isLoading = true;
    });
    final url = Uri.parse(
        'http://210.89.42.117:8085/api/administrator/masters/dropdown/location-list');

    try {
      final response = await http.post(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> details = data['details'];

        setState(() {
          isLoading = false;
        });
        return details.map((item) {
          return {
            'location_master_id': item['location_master_id'],
            // 'lookup_det_hier_desc_en': item['lookup_det_hier_desc_en'],
            'location_name': item['location_name'],
          };
        }).toList();
      } else {
        setState(() {
          isLoading = false;
        });
        throw Exception('Failed to load data: ${response.reasonPhrase}');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      throw Exception('Exception occurred: $e');
    }
  }

// Function to get name by id
  String getNameById(List<Map<String, dynamic>> data, int? id) {
    try {
      // Find the map where id matches
      Map<String, dynamic> item =
          data.firstWhere((map) => map['location_master_id'] == id);

      // Return the name associated with the id
      return item['location_name'] as String;
    } catch (e) {
      // Handle case where id is not found
      return 'ID not found';
    }
  }
}
