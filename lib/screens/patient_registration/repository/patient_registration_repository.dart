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

  Future<http.Response> searchPatient(String payload) async {
    var headers = {'Content-Type': 'application/json'};
    return await http.post(
      Uri.parse('$kBaseUrl$kSearchPatient/$payload'),
    );
  }

  Future<http.Response> registerPatient(Map payload) async {
    print(payload);
    var headers = {
      'Content-Type': 'application/json',
    };
    return await http.post(Uri.parse('$kBaseUrl$kPatientRegistration'),
        body: jsonEncode(payload), headers: headers);
  }
}
