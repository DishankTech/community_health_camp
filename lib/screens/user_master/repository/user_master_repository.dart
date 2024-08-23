import 'dart:convert';

import 'package:community_health_app/core/constants/network_constant.dart';
import 'package:http/http.dart' as http;

class UserMasterRepository {
  Future<http.StreamedResponse> createUser(Map<String, dynamic> payload) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request('POST', Uri.parse('$kBaseUrl$kCreateUser'));
    request.body = json.encode(payload);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    return response;
  }

  Future<http.Response> getAll() async {
    return await http.get(Uri.parse('$kBaseUrl$kGetAllUsers'));
  }
}
