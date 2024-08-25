import 'dart:convert';

import 'package:community_health_app/core/constants/network_constant.dart';
import 'package:http/http.dart' as http;

class UserMasterRepository {
  Future<http.StreamedResponse> createUser(Map<String, dynamic> payload) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('$kBaseUrl$kCreateUser'));
    request.body = json.encode(payload);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    return response;
  }

  Future<http.Response> getAll(Map payload) async {
    var headers = {'Content-Type': 'application/json'};
    return await http.post(Uri.parse('$kBaseUrl$kGetAllUsers'),
        body: jsonEncode(payload), headers: headers);
  }
}
