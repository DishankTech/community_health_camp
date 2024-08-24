import 'dart:convert';

import 'package:community_health_app/core/constants/network_constant.dart';
import 'package:community_health_app/core/utilities/data_provider.dart';
import 'package:http/http.dart' as http;

class PatientRegistrationRepository {
  Future<http.Response> getAll(Map payload) async {
    var headers = {'Content-Type': 'application/json'};
    return await http.post(Uri.parse('$kBaseUrl$kGetAllPatients'),
        body: jsonEncode(payload), headers: headers);
  }

  Future<http.Response> registerPatient(Map payload) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'bearer ${DataProvider().getParsedUserData()!.details!.last.accessToken!}'
    };
    return await http.post(Uri.parse('$kBaseUrl$kPatientRegistration'),
        body: jsonEncode(payload), headers: headers);
  }
}
