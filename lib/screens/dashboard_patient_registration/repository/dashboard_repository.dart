import 'dart:convert';

import 'package:community_health_app/core/constants/network_constant.dart';
import 'package:http/http.dart' as http;

class DashboardRepository {
  Future<http.Response> getCount(Map payload) async {
    var header = {'Content-Type': 'application/json'};
    return await http.post(Uri.parse('$kBaseUrl$kGetCount'),
        body: jsonEncode(payload), headers: header);
  }

  Future<http.Response> getDateWiseDistrictCount(Map payload) async {
    print(payload);
    var header = {'Content-Type': 'application/json'};
    return await http.post(Uri.parse('$kBaseUrl$kGetDateWiseDistrictCount'),
        body: jsonEncode(payload), headers: header);
  }

  Future<http.Response> getExcelData(Map payload) async {
    var header = {'Content-Type': 'application/json'};
    return await http.post(Uri.parse('$kBaseUrl$kGetExcelData'),
        body: jsonEncode(payload), headers: header);
  }

  Future<http.Response> getDistrictWisePatientCount(Map payload) async {
    var header = {'Content-Type': 'application/json'};
    return await http.post(Uri.parse('$kBaseUrl$kDistrictWisePatientCount'),
        body: jsonEncode(payload), headers: header);
  }
}
