import 'dart:convert';

import 'package:community_health_app/core/constants/network_constant.dart';
import 'package:community_health_app/core/utilities/api_urls.dart';
import 'package:community_health_app/core/utilities/network_call.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class StakeholderRepository {
  IOClient ioClient = IOClient(ByPassCert().httpClient);


  Future<http.Response> getAll(Map payload) async {
    var headers = {'Content-Type': 'application/json'};
    return await ioClient.post(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.kGetAllStakeholders}'),
        body: jsonEncode(payload), headers: headers);
  }

  Future<http.Response> register(Map payload) async {
    var headers = {'Content-Type': 'application/json'};
    return await ioClient.post(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.kAddStakeholder}'),
        body: jsonEncode(payload), headers: headers);
  }



  Future<http.Response> getStakeholderName(int payload) async {
    var headers = {'Content-Type': 'application/json'};
    return await ioClient.post(
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.kGetStakeholderName}$payload'),
    );
  }
}
