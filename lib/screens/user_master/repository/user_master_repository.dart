import 'dart:convert';

import 'package:community_health_app/core/constants/network_constant.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class UserMasterRepository {
  Dio dio = Dio();
  // Future<http.StreamedResponse> createUser(Map<String, dynamic> payload) async {
  //   print(payload);
  //   var headers = {'Content-Type': 'application/json'};
  //   var request = http.Request('POST', Uri.parse('$kBaseUrl$kCreateUser'));
  //   request.body = json.encode(payload);
  //   request.headers.addAll(headers);

  //   http.StreamedResponse response = await request.send();

  //   return response;
  // }

  // Future<http.Response> createUser(Map<String, dynamic> payload) async {
  //   print(payload);
  //   var headers = {'Content-Type': 'application/json'};
  //   return await http.post(Uri.parse('$kBaseUrl$kCreateUser'),
  //       body: jsonEncode(payload), headers: headers);
  // }
  Future<Response> createUser(Map<String, dynamic> payload) async {
    print(payload);
    return await dio.post(
      '$kBaseUrl$kCreateUser', // Your API endpoint
      data: jsonEncode(payload), // JSON data
      options: Options(
        headers: {
          'Content-Type': 'application/json', // Set the content type to JSON
          // Add other headers if necessary
        },
      ),
    );
  }

  Future<http.Response> getAll(Map payload) async {
    var headers = {'Content-Type': 'application/json'};
    return await http.post(Uri.parse('$kBaseUrl$kGetAllUsers'),
        body: jsonEncode(payload), headers: headers);
  }

  Future<http.Response> getLoginNameValidation(String payload) async {
    var headers = {'Content-Type': 'application/json'};
    return await http.post(Uri.parse('$kBaseUrl$kLoginNameValidation$payload'),
        body: jsonEncode(payload), headers: headers);
  }
}
