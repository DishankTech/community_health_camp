import 'dart:convert';

import 'package:community_health_app/core/constants/network_constant.dart';
import 'package:community_health_app/core/utilities/api_urls.dart';
import 'package:community_health_app/core/utilities/data_provider.dart';
import 'package:community_health_app/core/utilities/network_call.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class PatientRegistrationRepository {
  IOClient ioClient = IOClient(ByPassCert().httpClient);

  Future<http.Response> getAll(Map payload) async {

    var headers = {'Content-Type': 'application/json'};
    return await ioClient.post(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.kGetAllPatients}'),
        body: jsonEncode(payload), headers: headers);
  }

  Future<http.Response> searchPatient(String payload) async {

    var headers = {'Content-Type': 'application/json'};
    return await ioClient.post(
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.kSearchPatient}/$payload'),
    );
  }

  Future<http.Response> registerPatient(Map payload) async {

    print(payload);
    var headers = {
      'Content-Type': 'application/json',
    };
    return await ioClient.post(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.kPatientRegistration}'),
        body: jsonEncode(payload), headers: headers);
  }
}
