import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;

import '../model/camp_list_response_model.dart';

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

class CampCalendar extends StatefulWidget {
  @override
  _CampCalendarState createState() => _CampCalendarState();
}

class _CampCalendarState extends State<CampCalendar> {
  late Map<DateTime, List<CampEvent>> _events;
  late CalendarFormat _calendarFormat;
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  late List<CampEvent> _selectedEvents;

  bool _isLoading = true;

  late Map<DateTime, List> eventsByDate; // Loading state variable

  @override
  void initState() {
    super.initState();
    _events = {};
    _calendarFormat = CalendarFormat.month;
    _focusedDay = DateTime.now();
    _selectedDay = _focusedDay;

    String jsonData = '''{
      "status_code": 200,
      "message": "Data Found",
      "path": "/api/administrator/camp/all-camp-details-pagination",
      "dateTime": "2024-08-24 08:42:38.009875",
      "details": {
        "total_pages": 3,
        "page": 1,
        "total_count": 43,
        "per_page": 20,
        "data": [
          {"camp_create_request_id": 1, "stakeholder_master_id": 16, "location_master_id": 1, "prop_camp_date": "2024-08-22T13:19:07.234000", "org_id": null, "status": 1},
          {"camp_create_request_id": 2, "stakeholder_master_id": 16, "location_master_id": 1, "prop_camp_date": "2024-08-22T13:19:07.234000", "org_id": null, "status": 1},
          {"camp_create_request_id": 3, "stakeholder_master_id": 614, "location_master_id": 1, "prop_camp_date": "2024-08-22T13:19:07.234000", "org_id": null, "status": 1},
          {"camp_create_request_id": 4, "stakeholder_master_id": 614, "location_master_id": 1, "prop_camp_date": "2024-08-23T12:55:00", "org_id": 1, "status": 1},
          {"camp_create_request_id": 5, "stakeholder_master_id": 20, "location_master_id": 1, "prop_camp_date": "2024-08-23T12:59:00", "org_id": 1, "status": 1},
          {"camp_create_request_id": 6, "stakeholder_master_id": 614, "location_master_id": 1, "prop_camp_date": "2024-08-23T12:59:00", "org_id": 1, "status": 1},
          {"camp_create_request_id": 7, "stakeholder_master_id": 50, "location_master_id": 1, "prop_camp_date": "2024-08-23T15:47:00", "org_id": 1, "status": 1},
          {"camp_create_request_id": 8, "stakeholder_master_id": 50, "location_master_id": 1, "prop_camp_date": "2024-08-23T15:47:00", "org_id": 1, "status": 1},
          {"camp_create_request_id": 9, "stakeholder_master_id": null, "location_master_id": 1, "prop_camp_date": "2024-08-23T15:47:00", "org_id": 1, "status": 1},
          {"camp_create_request_id": 10, "stakeholder_master_id": null, "location_master_id": 1, "prop_camp_date": "2024-08-23T15:51:00", "org_id": 1, "status": 1},
          {"camp_create_request_id": 18, "stakeholder_master_id": 47, "location_master_id": 4, "prop_camp_date": "2024-08-23T16:18:00", "org_id": 1, "status": 1},
          {"camp_create_request_id": 19, "stakeholder_master_id": 47, "location_master_id": 4, "prop_camp_date": "2024-08-23T16:18:00", "org_id": 1, "status": 1},
          {"camp_create_request_id": 20, "stakeholder_master_id": null, "location_master_id": null, "prop_camp_date": "2024-08-23T16:29:24.668000", "org_id": 1, "status": 1},
          {"camp_create_request_id": 21, "stakeholder_master_id": null, "location_master_id": 4, "prop_camp_date": "2024-08-23T16:29:24.668000", "org_id": 1, "status": 1},
          {"camp_create_request_id": 22, "stakeholder_master_id": null, "location_master_id": 4, "prop_camp_date": "2024-08-23T16:18:00", "org_id": 1, "status": 1},
          {"camp_create_request_id": 23, "stakeholder_master_id": 47, "location_master_id": 4, "prop_camp_date": "2024-08-23T16:18:00", "org_id": 1, "status": 1},
          {"camp_create_request_id": 24, "stakeholder_master_id": 47, "location_master_id": 4, "prop_camp_date": "2024-08-23T16:18:00", "org_id": 1, "status": 1},
          {"camp_create_request_id": 25, "stakeholder_master_id": 47, "location_master_id": 4, "prop_camp_date": "2024-08-23T16:18:00", "org_id": 1, "status": 1},
          {"camp_create_request_id": 26, "stakeholder_master_id": 47, "location_master_id": 4, "prop_camp_date": "2024-08-23T16:18:00", "org_id": 1, "status": 1},
          {"camp_create_request_id": 27, "stakeholder_master_id": 47, "location_master_id": 4, "prop_camp_date": "2024-08-23T16:18:00", "org_id": 1, "status": 1}
        ]
      }
    }''';



    // Map<String, dynamic> data = json.decode(jsonData);
     eventsByDate = groupEventsByDate(jsonData);

    // _events = mapEventsToDate(eventsByDate);



    _selectedEvents = _events[_selectedDay] ?? [];

    // fetchData();
  }



  /*void fetchData() async {
    var url = Uri.parse('http://210.89.42.117:8085/api/administrator/camp/all-camp-details-pagination');

    var headers = {
      'Content-Type': 'application/json',
    };

    var body = json.encode({"total_pages": null, "page": 1, "total_count": null, "per_page": 20, "data": null});

    try {
      http.Response response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        CampResponse campResponse = CampResponse.fromJson(jsonResponse);

        // Create and add CampEvent instances
        for (var campDetail in campResponse.campDetails) {
          DateTime eventDate = DateTime.parse(campDetail.propCampDate!);
          CampEvent event = CampEvent(
            title: 'Camp ID: ${campDetail.campCreateRequestId}',
            date: eventDate,
          );

          if (_events[eventDate] == null) {
            _events[eventDate] = [];
          }
          _events[eventDate]!.add(event);
        }

        setState(() {
          _isLoading = false; // Data is loaded
        });
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }*/

  List _getEventsForDay(DateTime day) {
    return eventsByDate[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camp Calendar'),
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _selectedDay,
            firstDay: DateTime(2023),
            lastDay: DateTime(2025),
            calendarFormat: _calendarFormat,
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, day, events) {
                if (events.isNotEmpty) {
                  return Positioned(
                    right: 1,
                    bottom: 1,
                    child: _buildMarkers(events.length),
                  );
                }
                return null;
              },
            ),
           /* eventLoader: (day) {
              return _events[day] ?? [];
            },*/
            eventLoader: _getEventsForDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _selectedEvents = _events[selectedDay] ?? [];
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ListView.builder(
              itemCount: _selectedEvents.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_selectedEvents[index].toString()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Map<DateTime, List<CampEvent>> mapEventsToDate(Map<String, dynamic> jsonData) {
    Map<DateTime, List<CampEvent>> events = {};

    List<dynamic> data = jsonData['details']['data'];

    for (var item in data) {
      DateTime date = DateTime.parse(item['prop_camp_date']);
      CampEvent event = CampEvent(
        campCreateRequestId: item['camp_create_request_id'],
        stakeholderMasterId: item['stakeholder_master_id'],
        locationMasterId: item['location_master_id'],
        propCampDate: date,
        orgId: item['org_id'],
      );

      if (events[date] == null) {
        events[date] = [];
      }
      events[date]!.add(event);
    }

    return events;
  }

  _buildMarkers(int length) {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          '$length',
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }

  Map<DateTime, List<dynamic>> groupEventsByDate(String jsonData) {
    eventsByDate = {};

   /* // Parse JSON data
    final Map<String, dynamic> jsonMap = jsonDecode(jsonData.toString());
    final List<dynamic> dataList = jsonMap['details']['data'];

    // Create Datum objects
    final List<Datum> dataObjects = dataList.map((data) => Datum.fromJson(data)).toList();

    // Group by propCampDate
    final LinkedHashMap<DateTime, List<Datum>> groupedData = LinkedHashMap<DateTime, List<Datum>>();

    for (Datum datum in dataObjects) {
      DateTime dateKey = datum.propCampDate;
      if (!groupedData.containsKey(dateKey)) {
        groupedData[dateKey] = [];
      }
      groupedData[dateKey]!.add(datum);
    }

    // Print results
    groupedData.forEach((key, value) {
      print('Date: $key');
      value.forEach((datum) {
        print('  Datum ID: ${datum.campCreateRequestId}');
      });
    });*/


   /* Map<String, dynamic> jsonMap = jsonDecode(jsonData.toString());

    // Step 2: Extract 'data' list
    List<dynamic> dataList = jsonMap['details']['data'];

    LinkedHashMap<DateTime, List<CampEvent>> eventsByDate = LinkedHashMap();
    for (var item in dataList) {
      Datum campEvent = Datum.fromJson(item);

      // Add the event to the corresponding date in the map
      if (!eventsByDate.containsKey(campEvent.propCampDate)) {
        eventsByDate[campEvent.propCampDate] = [];
      }
      eventsByDate[campEvent.propCampDate]!.add(campEvent);
    }*/

    final Map<String, dynamic> jsonMap = jsonDecode(jsonData);
    List<dynamic> dataList = jsonMap['details']['data'];
    for (var item in dataList) {
      String dateStr = item['prop_camp_date'].split('T')[0];
      // Parse the string into a DateTime object
      DateTime dateTime = DateTime.parse(dateStr+ ' 00:00:00.000Z');

      // Format the DateTime object to the desired format
      String formattedDate = dateStr ;



      if (eventsByDate[dateTime] == null) {
        eventsByDate[dateTime] = [];
      }
      eventsByDate[dateTime]!.add(item);

      print(eventsByDate);
    }

  /*  // Convert the map to use DateTime as the key
    Map<DateTime, List> dateTimeMap = {};

    eventsByDate.forEach((key, value) {
      DateTime dateTimeKey = DateTime.parse(key);
      dateTimeMap[dateTimeKey] = value;
    });*/


    return eventsByDate;
  }
}

class CampResponse {
  final int statusCode;
  final String message;
  final String path;
  final String dateTime;
  final List<CampDetail> campDetails;

  CampResponse({
    required this.statusCode,
    required this.message,
    required this.path,
    required this.dateTime,
    required this.campDetails,
  });

  factory CampResponse.fromJson(Map<String, dynamic> json) {
    var list = json['details']['data'] as List;
    List<CampDetail> campDetailsList = list.map((i) => CampDetail.fromJson(i)).toList();

    return CampResponse(
      statusCode: json['status_code'],
      message: json['message'],
      path: json['path'],
      dateTime: json['dateTime'],
      campDetails: campDetailsList,
    );
  }
}

class CampDetail {
  final int? campCreateRequestId;
  final int? stakeholderMasterId;
  final int? locationMasterId;
  final String? propCampDate;
  final int? orgId;
  final int? status;

  CampDetail({
    required this.campCreateRequestId,
    required this.stakeholderMasterId,
    required this.locationMasterId,
    required this.propCampDate,
    required this.orgId,
    required this.status,
  });

  factory CampDetail.fromJson(Map<String, dynamic> json) {
    return CampDetail(
      campCreateRequestId: json['camp_create_request_id'],
      stakeholderMasterId: json['stakeholder_master_id'],
      locationMasterId: json['location_master_id'],
      propCampDate: json['prop_camp_date'],
      orgId: json['org_id'],
      status: json['status'],
    );
  }
}
