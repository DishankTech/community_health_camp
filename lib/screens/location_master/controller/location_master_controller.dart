import 'dart:convert';

import 'package:community_health_app/core/utilities/api_urls.dart';
import 'package:community_health_app/core/utilities/cust_toast.dart';
import 'package:community_health_app/screens/location_master/model/division/lookup_det.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/division/division_model.dart';

class LocationMasterController extends GetxController {
  TextEditingController countryController = TextEditingController();
  String? selectedCountryVal;
  LookupDet? selectedCountry;
  LookupDet? selectedState;
  String? selectedStateVal;
  String? selectedDistVal;
  LookupDet? selectedDist;
  String? selectedTalukaVal;
  LookupDet? selectedTaluka;
  String? selectedCityVal;
  LookupDet? selectedCity;

  bool hasInternet = true;
  bool isLoading = false;

  TextEditingController stateController = TextEditingController();

  TextEditingController distController = TextEditingController();

  TextEditingController talukaController = TextEditingController();

  TextEditingController cityController = TextEditingController();

  TextEditingController locationName = TextEditingController();

  TextEditingController address2 = TextEditingController();

  TextEditingController address1 = TextEditingController();

  TextEditingController emailId = TextEditingController();

  TextEditingController contactPerson = TextEditingController();

  TextEditingController contactNo = TextEditingController();

  String? status;

  DivisionModel? divisinModel;

  getDivisionList() async {
    isLoading = true;
    final uri = Uri.parse(ApiConstants.baseUrl + ApiConstants.getDivision);

    // final Map<String, dynamic> body = {
    //   "unitId": unitId,
    //   "type": type,
    //   "input": input,
    //   "category": "",
    //   "sId": sId,
    // };

    final Map<String, dynamic> body = {
      "lookup_code_list1": [
        {"lookup_code": "DIV"}
      ]
    };

    String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    debugPrint(body.toString());

    final response = await http.post(uri, headers: headers, body: jsonbody);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;

      final data = json.decode(response.body);
      // if (data['status'] == 'Success') {
      isLoading = false;
      divisinModel = DivisionModel.fromJson(data);
      debugPrint(divisinModel?.details?.first.lookupCode ?? "");
      update();

      // } else {
      //   isLoading = false;
      //
      //   status = data['status'];
      // }
    } else if (response.statusCode == 401) {
      isLoading = false;

      status = "Something went wrong";
    } else {
      isLoading = false;

      throw Exception('Failed search');
    }
    update();
  }

  saveLocationMaster() async {
    isLoading = true;
    final uri =
        Uri.parse(ApiConstants.baseUrl + ApiConstants.saveLocationMaster);

    final Map<String, dynamic> body = {
      "location_master_id": 0,
      "location_name": locationName.text,
      "contact_number": contactNo.text,
      "contact_person_name": contactPerson.text,
      "email_id": emailId.text,
      "address1": address1.text,
      "address2": address2.text,
      "lookup_det_hier_id_country": selectedCountry?.lookupDetId,
      "lookup_det_hier_id_state": selectedState?.lookupDetId,
      "lookup_det_hier_id_district": selectedDist?.lookupDetId,
      "lookup_det_hier_id_taluka": selectedTaluka?.lookupDetId,
      "lookup_det_hier_id_city": selectedCity?.lookupDetId,
      "lookup_det_id_division": 0,
      "org_id": 0,
      "status": 0
    };

    String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    debugPrint(body.toString());

    final response = await http.post(uri, headers: headers, body: jsonbody);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;

      final data = json.decode(response.body);

      isLoading = false;
      CustomMessage.toast("Save Successfully");
      Get.back();

      // divisinModel = DivisionModel.fromJson(data);
      // debugPrint(divisinModel?.details?.first.lookupCode ?? "");
      update();

      // } else {
      //   isLoading = false;
      //
      //   status = data['status'];
      // }
    } else if (response.statusCode == 401) {
      isLoading = false;
      CustomMessage.toast("Save Failed");
      Get.back();

      status = "Something went wrong";
    } else {
      isLoading = false;
      CustomMessage.toast("Save Failed");
      Get.back();

      throw Exception('Failed search');
    }
    update();
  }
}
