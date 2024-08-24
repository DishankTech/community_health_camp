import 'dart:convert';

import 'package:community_health_app/core/constants/network_constant.dart';
import 'package:http/http.dart' as http;

class StakeholderRepository {
  Future<http.Response> getAll(Map payload) async {
    var headers = {'Content-Type': 'application/json'};
    return await http.post(Uri.parse('$kBaseUrl$kGetAllStakeholders'),
        body: jsonEncode(payload), headers: headers);
  }

  Future<http.Response> register(Map payload) async {
    var headers = {'Content-Type': 'application/json'};
    return await http.post(Uri.parse('$kBaseUrl$kAddStakeholder'),
        body: jsonEncode(payload), headers: headers);
  }
}
