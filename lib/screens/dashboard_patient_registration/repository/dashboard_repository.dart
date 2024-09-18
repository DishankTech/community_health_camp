import 'dart:convert';

import 'package:community_health_app/core/constants/network_constant.dart';
import 'package:community_health_app/core/utilities/api_urls.dart';
import 'package:community_health_app/core/utilities/network_call.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class DashboardRepository {
  IOClient ioClient = IOClient(ByPassCert().httpClient);


  Future<http.Response> getCount(Map payload) async {
    var header = {'Content-Type': 'application/json'};
    return await ioClient.post(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.kGetCount}'),
        body: jsonEncode(payload), headers: header);
  }

  Future<http.Response> getDateWiseDistrictCount(Map payload) async {
    print(payload);
    var header = {'Content-Type': 'application/json'};
    return await ioClient.post(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.kGetDateWiseDistrictCount}'),
        body: jsonEncode(payload), headers: header);
  }

  Future<http.Response> getExcelData(Map payload) async {
    var header = {'Content-Type': 'application/json'};
    return await ioClient.post(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.kGetExcelData}'),
        body: jsonEncode(payload), headers: header);
  }

  Future<http.Response> getDistrictWisePatientCount(Map payload) async {
    var header = {'Content-Type': 'application/json'};
    return await ioClient.post(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.kDistrictWisePatientCount}'),
        body: jsonEncode(payload), headers: header);
  }
}
