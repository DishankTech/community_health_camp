import 'dart:convert';

import 'package:community_health_app/core/utilities/api_urls.dart';
import 'package:community_health_app/core/utilities/cust_toast.dart';
import 'package:community_health_app/screens/camp_creation/model/location/location_name_details.dart';
import 'package:community_health_app/screens/camp_creation/model/member_type/member_type_model.dart';
import 'package:community_health_app/screens/camp_creation/model/save_camp_req/save_camp_req_model.dart';
import 'package:community_health_app/screens/camp_creation/model/user_list_model/user_details.dart';
import 'package:community_health_app/screens/camp_creation/model/user_list_model/user_list_model.dart';
import 'package:community_health_app/screens/location_master/model/country/lookup_det_hierarchical.dart';
import 'package:community_health_app/screens/location_master/model/sub_location_model/sub_location_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../location_master/model/country/country_model.dart';
import '../location_master/model/sub_location_model/sub_location_model.dart';
import 'model/location/location_name_model.dart';
import 'model/save_camp_req/tt_camp_create_det_list.dart';

class CampCreationController extends GetxController {
  List<TtCampCreateDetails> campCreationCardList = [];

  TextEditingController locationNameController = TextEditingController();
  TextEditingController dateTimeController = TextEditingController();

  // TextEditingController userNameController = TextEditingController();
  // TextEditingController userController = TextEditingController();
  UserDetails? selectedUser;
  TextEditingController distNameController = TextEditingController();

  TextEditingController designationType = TextEditingController();

  TextEditingController stakeHolderController = TextEditingController();

  // TextEditingController countryCodeController = TextEditingController();

  // Map<String, dynamic>? selectedCountryCode;

  // TextEditingController mobileController = TextEditingController();
  // TextEditingController memberTypeController = TextEditingController();
  TextEditingController stakHolderUserCreation = TextEditingController();
  TextEditingController loginNameUserCreation = TextEditingController();

  bool isLoading = false;

  String? status;

  LocationNameModel? locationNameModel;

  bool hasInternet = true;

  String? selectedLocationVal;

  LocationNameDetails? selectedLocation;

  SubLocationModel? distModel;

  SubLocationDetails? selectedDist;

  String? selectedDistVal;

  CountryModel? stakeHolderModel;

  String? selectedStakeHVal;

  LookupDetHierarchical? selectedStakeH;
  LookupDetHierarchical? selectedStakeHolder;

  MemberTypeModel? memberTypeModel;

  UserListModel? userList;
  SaveCampReqModel saveCampReqModel = SaveCampReqModel();

  saveCampCreation() async {
    isLoading = true;
    final uri = Uri.parse(ApiConstants.baseUrl + ApiConstants.saveCampCreation);

    String jsonbody = json.encode(saveCampReqModel);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // debugPrint(body.toString());

    final response = await http.post(uri, headers: headers, body: jsonbody);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // addlocationMasterResp = AddLocationMasterResp.fromJson(data);

      // if (addlocationMasterResp!.statusCode == 200) {
      isLoading = false;
      CustomMessage.toast("Save Successfully");
      Get.back();

      // } else {
      //   isLoading = false;
      //   CustomMessage.toast("Save Failed");
      //   Get.back();
      // }

      update();
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

  userCreation(loginName) async {
    isLoading = true;
    final uri = Uri.parse(ApiConstants.baseUrl + ApiConstants.userCreation);

    var body = {
      "user_id": null,
      "stakeholder_master_id": 1,
      // "stakeholder_master_id": selectedStakeHolder?.lookupDetHierId,
      "full_name": loginName,
      "login_name": loginName,
      "passwords": "",
      "mobile_number": "",
      "email_id": "",
      "first_login_pass_reset": "Y",
      "status": 1,
      "org_id": 1,
      "lookup_det_hier_id_stakeholder_type1": null,
      "lookup_det_id_membertype": null
    };

    String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // debugPrint(body.toString());

    final response = await http.post(uri, headers: headers, body: jsonbody);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      if (data['status_code'] == 200) {
        isLoading = false;
        CustomMessage.toast("Save Successfully");
        Get.back();

        await getUserList();

        update();
      }
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

  getLocationName() async {
    isLoading = true;
    final uri = Uri.parse(ApiConstants.baseUrl + ApiConstants.getLocationName);
    final Map<String, dynamic> body = {
      "lookup_det_code_list1": [
        {"lookup_det_code": "CRY"}
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
      locationNameModel = LocationNameModel.fromJson(data);

      update();
    } else if (response.statusCode == 401) {
      isLoading = false;

      status = "Something went wrong";
    } else {
      isLoading = false;

      throw Exception('Failed search');
    }
    update();
  }

  getMemberType() async {
    isLoading = true;
    final uri = Uri.parse(ApiConstants.baseUrl + ApiConstants.getDivision);
    final Map<String, dynamic> body = {
      "lookup_code_list1": [
        {"lookup_code": "MTY"}
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
      memberTypeModel = MemberTypeModel.fromJson(data);

      update();
    } else if (response.statusCode == 401) {
      isLoading = false;

      status = "Something went wrong";
    } else {
      isLoading = false;

      throw Exception('Failed search');
    }
    update();
  }

  getDist(id, bool? isView) async {
    isLoading = true;
    final uri = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.getAllSubLocation}/$id');

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await http.post(uri, headers: headers, body: null);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;

      final data = json.decode(response.body);
      // if (data['status'] == 'Success') {
      isLoading = false;
      distModel = SubLocationModel.fromJson(data);

      distNameController.text =
          distModel?.details?.first.lookupDetHierDescEn ?? "";

      update();
    } else if (response.statusCode == 401) {
      isLoading = false;

      status = "Something went wrong";
    } else {
      isLoading = false;

      throw Exception('Failed search');
    }
    update();
  }

  getUserList() async {
    isLoading = true;
    final uri = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.useList}');

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await http.post(uri, headers: headers, body: null);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;

      final data = json.decode(response.body);
      // if (data['status'] == 'Success') {
      isLoading = false;
      userList = UserListModel.fromJson(data);

      update();
    } else if (response.statusCode == 401) {
      isLoading = false;

      status = "Something went wrong";
    } else {
      isLoading = false;

      throw Exception('Failed search');
    }
    update();
  }

  getStakHolder() async {
    isLoading = true;
    final uri = Uri.parse(ApiConstants.baseUrl + ApiConstants.getAllAddress);
    final Map<String, dynamic> body = {
      "lookup_det_code_list1": [
        {"lookup_det_code": "STY"}
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
      stakeHolderModel = CountryModel.fromJson(data);

      update();
    } else if (response.statusCode == 401) {
      isLoading = false;

      status = "Something went wrong";
    } else {
      isLoading = false;

      throw Exception('Failed search');
    }
    update();
  }
}
