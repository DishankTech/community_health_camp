import 'dart:convert';
import 'dart:io';

import 'package:community_health_app/core/constants/network_constant.dart';
import 'package:community_health_app/core/utilities/api_urls.dart';
import 'package:community_health_app/core/utilities/network_call.dart';
import 'package:dio/io.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:http/io_client.dart';

class UserMasterRepository {
  Dio dio = Dio();
  UserMasterRepository() {
    // Configure Dio to bypass SSL certificates
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }
  Future<Response> createUser(Map<String, dynamic> payload) async {
    IOClient ioClient = IOClient(ByPassCert().httpClient);

    print(payload);
    return await dio.post(
      '${ApiConstants.baseUrl}${ApiConstants.kCreateUser}', // Your API endpoint
      data: jsonEncode(payload), // JSON data
      options: Options(
        headers: {
          'Content-Type': 'application/json', // Set the content type to JSON
          // Add other headers if necessary
        },
      ),
    );
  }

  Future<Response> updateUser(Map<String, dynamic> payload) async {
    print(payload);
    return await dio.post(
      '${ApiConstants.baseUrl}${ApiConstants.kUpdateUser}', // Your API endpoint
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
    IOClient ioClient = IOClient(ByPassCert().httpClient);

    var headers = {'Content-Type': 'application/json'};
    return await ioClient.post(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.kGetAllUsers}'),
        body: jsonEncode(payload), headers: headers);
  }

  Future<http.Response> getLoginNameValidation(String payload) async {
    IOClient ioClient = IOClient(ByPassCert().httpClient);

    var headers = {'Content-Type': 'application/json'};
    return await ioClient.post(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.kLoginNameValidation}$payload'),
        body: jsonEncode(payload), headers: headers);
  }
}
