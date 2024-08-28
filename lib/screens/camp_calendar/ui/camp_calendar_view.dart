import 'dart:collection';
import 'dart:convert';

import 'package:community_health_app/core/constants/constants.dart';
import 'package:community_health_app/core/utilities/size_config.dart';
import 'package:community_health_app/screens/camp_calendar/model/camp_list_response_model.dart';
import 'package:community_health_app/screens/camp_calendar/ui/camp_calendar_view_new.dart';
import 'package:community_health_app/screens/camp_calendar/ui/date_wise_camps.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../core/constants/fonts.dart';
import '../../../core/routes/app_routes.dart';
import '../model/event_model.dart';
import 'package:http/http.dart' as http;

class CampCalendarPage extends StatefulWidget {
  const CampCalendarPage({Key? key}) : super(key: key);

  @override
  _CampCalendarPageState createState() => _CampCalendarPageState();
}

class CampEvent {
  final int? campCreateRequestId;
  final int? stakeholderMasterId;
  final int? locationMasterId;
  final DateTime? propCampDate;
  final int? orgId;

  CampEvent({
    this.campCreateRequestId,
    this.stakeholderMasterId,
    this.locationMasterId,
    this.propCampDate,
    this.orgId,
  });

  @override
  String toString() => 'Camp ID: $campCreateRequestId';
}

class _CampCalendarPageState extends State<CampCalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // late final ValueNotifier<List<Event>> _selectedEvents;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff; // Can be toggled on/off by longpressing a date

  // final ValueNotifier<List<Event>> _selectedEvents = ValueNotifier([]);

  List<Datum>? campDetailsList = [];

  // Using a `LinkedHashSet` is recommended due to equality comparison override
  final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  late Map<DateTime, List> eventsByDate;
  late Map<DateTime, List> eventList;

  // late List<CampEvent> _selectedEvents;
  late Map<DateTime, List<CampEvent>> _events;

  bool isLoading = false;

  // List<Datum> uniqueLocationList  = [];
  List<dynamic> uniqueLocationList = [];

  Set<int> seenLocationIds = {};

  @override
  void dispose() {
    // _selectedEvents.clear();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    loadData();

    _selectedDay = _focusedDay;

  }


  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      // _focusedDay = focusedDay;
      // Update values in a Set
      if (_selectedDays.contains(selectedDay)) {
        _selectedDays.remove(selectedDay);
      } else {
        _selectedDays.add(selectedDay);
      }
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DateWiseCampsScreen(selectedDay),
      ),
    );

    // Navigator.pushNamed(context, AppRoutes.dateWiseCamps);
    // _selectedEvents.value = _getEventsForDays(_selectedDays);
  }



  List _getEventsForDay(DateTime day) {
    return eventsByDate[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                "assets/pagesbg.png",
                fit: BoxFit.fill,
              )),
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 40, left: 10),
                    child: Material(
                      color: Colors.transparent, // Use transparent if you don't want a background color
                      child: Row(
                        children: [
                          IconButton(
                            color: Colors.white,
                            onPressed: () {
                              print('Back button pressed');
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Camp Calendar",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      isLoading
                          ? Container(
                              width: SizeConfig.screenWidth,
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
                              margin: EdgeInsets.all(10),
                              // padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white, border: Border.all(color: Colors.grey)),
                              child: TableCalendar(
                                firstDay: kFirstDay,
                                lastDay: kLastDay,
                                focusedDay: _focusedDay,
                                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                                rangeStartDay: _rangeStart,
                                rangeEndDay: _rangeEnd,
                                calendarFormat: _calendarFormat,
                                rangeSelectionMode: _rangeSelectionMode,
                                eventLoader: _getEventsForDay,
                                startingDayOfWeek: StartingDayOfWeek.monday,
                                calendarBuilders: CalendarBuilders(
                                  markerBuilder: (context, day, events) => events.isNotEmpty
                                      ? Container(
                                          width: 20,
                                          height: 20,
                                          alignment: Alignment.center,
                                          decoration: const BoxDecoration(
                                            color: Colors.green,
                                          ),
                                          child: Text(
                                            '${events.length}',
                                            style: const TextStyle(color: Colors.white),
                                          ),
                                        )
                                      : null,
                                ),
                                calendarStyle: CalendarStyle(
                                  // cellPadding: EdgeInsets.all(2),
                                  // cellMargin: EdgeInsets.all(2),
                                  isTodayHighlighted: false,
                                  weekendDecoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(4.0)),
                                  defaultDecoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(4.0)),
                                  markersAlignment: Alignment.bottomRight,
                                  markerMargin: EdgeInsets.only(bottom: 15),
                                  // Use `CalendarStyle` to customize the UI
                                  outsideDaysVisible: false,
                                ),
                                onDaySelected: _onDaySelected,
                                // onRangeSelected: _onRangeSelected,
                                onFormatChanged: (format) {
                                  if (_calendarFormat != format) {
                                    setState(() {
                                      _calendarFormat = format;
                                    });
                                  }
                                },
                                onPageChanged: (focusedDay) {
                                  _focusedDay = focusedDay;
                                },
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildCellDate(DateTime day, {DateTime? focusedDay}) {
    return Container(
      margin: const EdgeInsets.all(5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: (day == focusedDay) ? BoxShape.circle : BoxShape.rectangle,
        color: Colors.green, // you custom color here
        borderRadius: (day == focusedDay) ? null : BorderRadius.circular(4),
      ),
      child: Text(
        day.day.toString(),
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  Future<Map<DateTime, List>> getAllCamps() async {
    setState(() {
      isLoading = true;
    });
    eventsByDate = {};
    // var url = Uri.parse('http://210.89.42.117:8085/api/administrator/camp/all-camp-details-pagination');
    var url = Uri.parse('http://210.89.42.117:8085/api/administrator/camp/all-camp-approval-details-by-date');

    var headers = {'Content-Type': 'application/json'};

    var body = json.encode({{
      "start_date": "2024-08-01",
      "end_date": "2024-08-31"
    }});

    try {
      // Use the post method directly to get the response
      http.Response response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        print(response.body);
        var jsonResponse = json.decode(response.body);

        // CampDetailsResponseModel campResponse = CampDetailsResponseModel.fromJson(jsonResponse);
        // List<Datum>? campDetailsList = campResponse.details?.data;
        //  campDetailsList = campResponse.details?.data;
        // Print the camp details
        /*if(campDetailsList!=null)
          {
            for (var campDetail in campDetailsList!) {
              print('Camp ID: ${campDetail.campCreateRequestId}, Date: ${campDetail.propCampDate}');
            }
          }*/

        List<dynamic> dataList = jsonResponse['details']['data'];
        uniqueLocationList = [];

      /*  for (var camp in dataList) {
          // if(camp.locationMasterId!=null)
          if (camp['location_master_id'] != null) {
            int locationId = int.parse(camp['location_master_id'].toString());
            if (!seenLocationIds.contains(locationId)) {
              seenLocationIds.add(locationId);
              uniqueLocationList.add(camp);
            }
          }
        }*/

        // Set to track unique location_master_id and date combinations
        final Set<String> uniqueEntries = {};
        final List<Map<String, dynamic>> filteredData = [];

        for (var entry in dataList) {
          // Extract location_master_id and date (yyyy-MM-dd)
          final locationMasterId = entry['location_master_id'].toString();
          final propCampDate = entry['prop_camp_date'].substring(0, 10);

          // Create a unique key using location_master_id and date
          final uniqueKey = '$locationMasterId-$propCampDate';

          // Check if this combination is already in the set
          if (!uniqueEntries.contains(uniqueKey)) {
            // If not, add it to the set and filtered list
            uniqueEntries.add(uniqueKey);
            filteredData.add(entry);
          }
        }



        // for (var item in dataList) {
        // for (var item in uniqueLocationList) {
        for (var item in filteredData) {
          // String dateStr = item['prop_camp_date'].split('T')[0];
          // String dateStr = item.propCampDate.timeZoneName.split('T')[0];
          // String dateStr = item['prop_camp_date'].timeZoneName.split('T')[0];
          String dateStr = item['prop_camp_date'].split('T')[0];
          // Parse the string into a DateTime object
          DateTime dateTime = DateTime.parse(dateStr + ' 00:00:00.000Z');

          if (eventsByDate[dateTime] == null) {
            eventsByDate[dateTime] = [];
          }
          eventsByDate[dateTime]!.add(item);

          print(eventsByDate);
          setState(() {
            isLoading = false;
          });

          // return campDetailsList;
        }
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

    return eventsByDate;
  }

  Future<void> loadData() async {
    eventList = await getAllCamps();
    if (eventList.isNotEmpty) {
      eventsByDate = eventList;
    }
  }
}
